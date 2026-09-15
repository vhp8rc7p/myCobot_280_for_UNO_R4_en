# 5.3 Hardware Interface

## Overview

The UNO R4 replaces the M5Stack Basic in the arm's base. It needs three
connections to the arm and one to the PC.

```
        USB-C / USB-B                      D1 (TX) ------> arm RX
PC <----------------------> UNO R4         D0 (RX) <------ arm TX
        Serial (USB CDC)                   GND     ------- arm GND
                                           Serial1 @ 1000000 baud
```

## Serial port mapping

This is the single most important difference from the M5 build.

| Board | Port to PC | Port to arm |
|---|---|---|
| M5Stack Basic | `Serial` | `Serial2` (GPIO16/17) |
| Arduino UNO R4 | `Serial` (native USB CDC) | `Serial1` (D0/D1) |
| Arduino MKR | `Serial` | `Serial1` |
| Arduino Uno (classic) | — | `Serial` (pins 0/1, shared with USB) |

On a **classic** Uno the single hardware UART on pins 0/1 is also the USB
port, which is why the library's `MyCobot_Uno` profile maps the arm to
`Serial`. The **UNO R4 is different**: USB is a separate native CDC
peripheral, and D0/D1 became `Serial1`. Selecting `MyCobot_Uno` on an R4 would
point the arm link at the USB port and collide with your Python connection.
Use `MyCobot_Mkr` — see [6.1.2 Simple Use](../../6.developmentGuide/Arduino/10.2-arduino_use.md).

## Wiring

**Power the arm down before wiring.**

```
R4 D1 (TX)  ---->  arm RX
R4 D0 (RX)  <----  arm TX
R4 GND      -----  arm GND
```

UART must **cross over**: each side's transmitter goes to the other side's
receiver. Ground must be common or nothing works regardless of the data lines.

### If you wire TX to TX

This is the most common mistake and it fails in a distinctive way: **complete
silence at every baud rate**. A sweep from 9600 to 1000000 baud returns zero
bytes in every case:

```
1000000  -- no bytes --
500000   -- no bytes --
250000   -- no bytes --
115200   -- no bytes --
...
9600     -- no bytes --
```

If you see that pattern, do not go looking for a baud or protocol problem —
the link is electrically dead. TX to TX wires two push-pull **outputs**
against each other, so neither transmitter ever reaches a receiver, and one
driving high while the other drives low produces contention current limited
only by the drivers' internal resistance. Power down before correcting it.

In `pymycobot` the same fault shows as `-1` from every call:

```python
>>> mc.is_controller_connected()
-1
>>> mc.get_angles()
-1
```

`-1` means "nothing came back", not "bad reply".

## Baud rate

The arm link runs at **1000000 baud**, fixed. It is selected in
`MyCobotBasic.h` by the arm-model define:

```c
#if defined MyCobot || defined MechArm || defined MyArm750
#define BAUD_RATE           1000000      //mycobot use
#else
#define BAUD_RATE            115200      //mycobot-pro use
#endif
```

There is no negotiation — `Transponder::SetBaud()` in the M5 firmware is an
empty stub. The USB side's baud is ignored entirely because it is USB CDC;
`115200` in your Python code is conventional, not functional.

## Voltage levels

> **The UNO R4's D0/D1 are 5 V logic. The M5Stack Basic it replaces is
> ESP32-based and therefore 3.3 V. Arduino MKR boards — whose profile this
> configuration borrows — are also 3.3 V.**

If the arm's UART expects 3.3 V, the R4 driving its RX at 5 V is outside
spec. In practice it does function, but the correct fix is a level shifter,
or at minimum a divider on the **R4 → arm** line. The **arm → R4** direction
needs nothing: 3.3 V reads reliably as logic HIGH on a 5 V input.

This is the one point where the R4 is genuinely a worse fit than a MKR, and
it is worth addressing for anything left running unattended.

## Verifying the link

With the [transponder firmware](../../6.developmentGuide/Arduino/10.4-transponder.md)
flashed, this checks the **board only** — no arm or arm power required,
because the R4 answers it itself:

```
send: fe fe 02 c1 fa
recv: fe fe 03 c1 18 fa      (0x18 = 24 = SYSTEM_VERSION)
```

If that works but the arm still returns `-1`, the problem is downstream of
the R4: wiring, arm power, or the connector. See
[9.3 Hardware issues](../../../4-SupportAndService/9.Troubleshooting/9.3-hardware.md).
