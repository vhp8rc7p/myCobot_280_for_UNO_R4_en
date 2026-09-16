# myCobot 280 for Arduino — Specification (UNO R4 edition)

Standalone specification for a **myCobot 280 for Arduino** whose base
controller is an **Arduino UNO R4**.

The arm itself is unchanged — mechanics, servos, and the ESP32 Atom at the end
effector are identical to any other myCobot 280 for Arduino. Only the
main-control board differs, so only that part of the specification changes.

- **Part 1** reproduces the official arm specification.
- **Part 2** adds the UNO R4 as a main-control option.

---

## Part 1 — Arm specification

As published at
[ER myCobot 280 for Arduino 2023 产品参数](https://www.elephantrobotics.com/mycobot-280-arduino-2023-%E4%BA%A7%E5%93%81%E5%8F%82%E6%95%B0/).
Unchanged by the choice of main-control board.

| Parameter | Value |
|---|---|
| Degrees of freedom | 6 |
| Maximum working radius | 280 mm |
| Maximum payload | 250 g |
| Net weight | 860 g |
| Repeat positioning accuracy | ± 0.5 mm |
| Service life | 500 h |
| Power input | DC 12 V 5 A |
| Main control model | Expandable Arduino UNO / MEGA / MKR **/ UNO R4** |
| Secondary control model | ESP32 × 1 |
| Secondary control core | 240 MHz dual core, 600 DMIPS, 520 KB SRAM, Wi-Fi, dual-mode Bluetooth |
| Secondary control flash | 4 MB |
| Secondary control IO | G19, G21, G22, G23, G25, G33 |
| Free movement | Supported |
| Joint movement | Supported |
| Cartesian movement | Supported |
| Motor encoder type | 12-bit magnetic encoder |
| Power-off position save | Supported |
| Shell material | Metal |
| Gear type | Steel |

### Joint motion range

| Joint | Range |
|---|---|
| J1 | −165° ~ +165° |
| J2 | −165° ~ +165° |
| J3 | −165° ~ +165° |
| J4 | −165° ~ +165° |
| J5 | −165° ~ +165° |
| J6 | −179° ~ +179° |

### Supported platforms and languages

Windows, Linux, macOS, ROS 1, ROS 2, Python, C++, C#, JavaScript, myBlockly,
Arduino, myStudio, serial control protocol.

> **Note on myStudio.** myStudio flashes the **Atom** as normal. It does **not**
> flash an UNO R4 main-control board — use the Arduino IDE for that. This
> matches the existing guidance for the UNO main-control option.

---

## Part 2 — UNO R4 as main control

### Board options

| | UNO R4 Minima | UNO R4 WiFi |
|---|---|---|
| Drives the arm | yes | yes |
| Wireless | none | Wi-Fi + Bluetooth LE (ESP32-S3) |
| LED matrix | none | 12 × 8 |
| USB to host | native RA4M1 USB | routed via ESP32-S3 |

The R4's own Wi-Fi is **not used** by the arm firmware; the transponder is
USB-only. There is no Wi-Fi or Bluetooth transponder mode equivalent to the
M5Stack build.

### Main-control specification

| Parameter | Value |
|---|---|
| Microcontroller | Renesas RA4M1 |
| Core | Arm Cortex-M4 |
| Clock | 48 MHz |
| Flash | 256 KB (262,144 bytes) |
| SRAM | 32 KB (32,768 bytes) |
| EEPROM | 8 KB (emulated in data flash) |
| Hardware UARTs | 3 |
| Operating logic level | **5 V** |
| USB | USB-C |
| Arduino core | `arduino:renesas_uno` |
| FQBN | `arduino:renesas_uno:unor4wifi` / `:minima` |

### Comparison with the other main-control options

| | UNO R3 | MEGA 2560 | UNO R4 |
|---|---|---|---|
| MCU | ATmega328P | ATmega2560 | Renesas RA4M1 |
| Architecture | AVR 8-bit | AVR 8-bit | Arm Cortex-M4 32-bit |
| Clock | 16 MHz | 16 MHz | 48 MHz |
| Flash | 31.5 KB usable | 248 KB usable | 256 KB |
| SRAM | 2 KB | 8 KB | 32 KB |
| Logic level | 5 V | 5 V | 5 V |
| Arm UART | `Serial` (D0/D1, shared with USB) | `Serial1` | `Serial1` (D0/D1) |
| Host USB conflicts with arm link | **yes** | no | no |
| Needs myStudio firmware | no | yes | no |
| `ParameterList.h` profile | `MyCobot_Uno` | `MyCobot_Mega` | `MyCobot_Mkr` |

The R4's practical advantage over the UNO R3 is that its USB port is a separate
peripheral from `Serial1`, so the host connection and the arm link do not
contend for one UART. On an R3 they share pins 0/1.

### Electrical interface to the arm

| Parameter | Value |
|---|---|
| Arm link port | `Serial1` |
| Arm link pins | D0 (RX), D1 (TX) |
| Baud rate | 1,000,000 (fixed, no negotiation) |
| Frame format | `FE FE <len> <cmd> [payload] FA` |
| Host link port | `Serial` (USB CDC) |
| Host baud rate | any — ignored by USB CDC |

Wiring must cross over, with a common ground:

```
R4 D1 (TX)  ---->  arm RX
R4 D0 (RX)  <----  arm TX
R4 GND      -----  arm GND
```

> ### Logic level caution
>
> The UNO R4's D0/D1 operate at **5 V**. The M5Stack Basic that the R4 replaces
> is ESP32-based and therefore **3.3 V**, as are Arduino MKR boards — whose
> `ParameterList.h` profile the R4 configuration borrows.
>
> If the arm's UART is 3.3 V, the **R4 → arm** direction is outside spec. A
> level shifter, or at minimum a divider on the R4 TX line, is the correct fix
> for sustained use. The **arm → R4** direction requires nothing, as 3.3 V
> reads reliably as logic HIGH on a 5 V input.

### Controller-level commands

Handled by the main-control board rather than the Atom:

| Code | Command |
|---|---|
| `0xA0` | `SET_BASIC_OUT` — `digitalWrite` on a main-control pin |
| `0xA1` | `GET_BASIC_IN` — `digitalRead` on a main-control pin |
| `0xC1` | `GET_BASIC_VERSION` |
| `0xC2` | `SET_COMMUNICATE_MODE` |
| `0xC3` | `GET_COMMUNICATE_MODE` |

Pin numbers in `0xA0` / `0xA1` refer to **UNO R4 pins**. Usable
general-purpose pins are D2–D13 and A0–A5; **D0 and D1 are reserved** for the
arm link.

`GET_BASIC_VERSION` returns `SYSTEM_VERSION` = 24, reported by `pymycobot` as
`2.4`.

### Measured firmware footprint

Built against `arduino:renesas_uno:unor4wifi`, library configured with the
`MyCobot_Mkr` profile:

| Sketch | Flash | SRAM |
|---|---|---|
| `AnglesControl` | 52,604 B (20 %) | 6,908 B (21 %) |
| `CoordsControl` | 53,036 B (20 %) | 6,908 B (21 %) |
| `GripperControl` | 52,372 B (19 %) | 6,884 B (21 %) |
| `Transponder` | 53,140 B (20 %) | 6,800 B (20 %) |
| Transponder + LED matrix | 54,912 B (20 %) | 7,280 B (22 %) |

Roughly 80 % of flash and 78 % of SRAM remain free for application code.

### Measured link performance

Transponder mode, 40 consecutive `get_angles()` calls from `pymycobot`, with
the LED matrix animating:

| | |
|---|---|
| Malformed replies | 0 / 40 |
| Median round-trip | 17.8 ms |
| Maximum round-trip | 57.9 ms |

### Host requirements

| | |
|---|---|
| Driver | none — native USB CDC |
| Arduino board package | Arduino UNO R4 Boards (`arduino:renesas_uno`) |
| Python library | `pymycobot` (verified with 4.0.6, Python 3.13) |
| Python class | `MyCobot280` |

Two host-side behaviours differ from an M5 build:

- The R4 **resets when the serial port is opened**. Allow ~2.5 s after
  connecting before sending commands.
- **DTR must be asserted** or the USB CDC endpoint stays silent. `pyserial`
  does this by default.

---

## Provenance

| Section | Source |
|---|---|
| Part 1 arm specification | Elephant Robotics published product parameters |
| R4 MCU, clock, memory, UART count, EEPROM | Arduino core `renesas_uno` 1.6.0 — `boards.txt`, variant headers |
| UNO R3 / MEGA 2560 figures | Arduino core `avr` 1.8.7 — `boards.txt` |
| Firmware footprint | `arduino-cli compile` output |
| Link performance | measured against a myCobot 280 and an UNO R4 WiFi |
| Serial mapping, baud, opcodes | `MyCobotBasic` source (`ParameterList.h`, `MyCobotBasic.h`) |

Flash and SRAM figures for the UNO R3 and MEGA 2560 are the Arduino
toolchain's usable limits after the bootloader, not raw device capacity.
