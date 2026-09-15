# 6.2.1 Environment construction

```
pip install pymycobot
```

Verified with `pymycobot` 4.0.6 on Python 3.13.

## Connecting

```python
import time
from pymycobot import MyCobot280

mc = MyCobot280("COM13", 115200)
time.sleep(2.5)

print(mc.is_controller_connected())   # 1 = good
```

## Three things that will cost you time

### 1. Wait after opening the port

The UNO R4 **resets when the serial port is opened**. Commands sent in the
first ~2 seconds are lost. Always sleep after connecting:

```python
mc = MyCobot280("COM13", 115200)
time.sleep(2.5)          # not optional
```

This does not happen on an M5 build, so examples copied from the official docs
may appear to fail intermittently.

### 2. DTR must be asserted

The R4's USB CDC stays silent until DTR is raised. `pyserial` asserts it by
default, so plain `serial.Serial(port, baud)` and `pymycobot` both work — but a
terminal or script that leaves DTR low gets **zero bytes** and looks exactly
like dead hardware.

If you are talking to the board with raw `pyserial` and getting nothing:

```python
s = serial.Serial("COM13", 115200, timeout=1)
s.dtr = True            # explicit, in case something cleared it
```

### 3. Use the class that matches your arm

```python
from pymycobot import MyCobot280      # correct for a 280
```

`MyPalletizer260` will connect and appear to work, but parses `get_coords()`
as 4 values and silently truncates `rx`, `ry`, `rz`:

```
MyPalletizer260 -> [-19.5, -59.8, 365.8, -100.74]
MyCobot280      -> [-19.5, -59.8, 365.8, -100.74, 64.29, -105.29]
```

It also reports a wrong `get_basic_version()`.

## Checking the link

```python
mc.is_controller_connected()   # 1 = arm responding, -1 = nothing coming back
mc.get_basic_version()         # 2.4 on a correctly-built R4 transponder
```

`-1` from every call means no bytes are arriving at all. That is wiring or
power, not software — see
[9.3 Hardware issues](../../../4-SupportAndService/9.Troubleshooting/9.3-hardware.md).
