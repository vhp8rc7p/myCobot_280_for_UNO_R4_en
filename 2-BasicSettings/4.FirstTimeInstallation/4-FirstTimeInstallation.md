# 4. First Time Installation

Bringing up a myCobot 280 with an Arduino UNO R4 as the base controller, in
order.

## 1. Arm-side firmware

The **Atom** board at the end effector is unchanged from an M5 build. Flash the
latest AtomMain with **myStudio** exactly as normal.

myStudio does **not** flash the UNO R4 — that is done from the Arduino IDE.

## 2. Development environment

Install the Arduino IDE and the **Arduino UNO R4 Boards** package. No M5Stack
package and no CP210x/CH9102 driver are needed; the R4 is a native USB CDC
device.

Details: [6.1.1 Environment Construction](../../3-FunctionsAndApplications/6.developmentGuide/Arduino/10.1-arduino_download.md)

## 3. Library

Clone `MyCobotBasic`, place it in your Arduino libraries folder, and apply the
R4 configuration — the single step most likely to be missed.

Details: [6.1.2 Simple Use](../../3-FunctionsAndApplications/6.developmentGuide/Arduino/10.2-arduino_use.md)

## 4. Bench test before touching the arm

Upload the transponder and confirm the board answers on its own, with **no arm
connected and no arm power**:

```
send: fe fe 02 c1 fa
recv: fe fe 03 c1 18 fa
```

This proves the toolchain, configuration, firmware and USB path in one step,
and it isolates them from any wiring question that follows.

## 5. Wiring

**Power the arm down.** Cross TX and RX, tie the grounds:

```
R4 D1 (TX)  ---->  arm RX
R4 D0 (RX)  <----  arm TX
R4 GND      -----  arm GND
```

Read the voltage-level warning before powering up — the R4 is a 5 V board
replacing a 3.3 V one.

Details: [5.3 Hardware Interface](../../3-FunctionsAndApplications/5.BasicFunction/5.3-HardwareInterface/RoboticArmElectricalInterface.md)

## 6. First contact

Power the arm, then:

```python
import time
from pymycobot import MyCobot280

mc = MyCobot280("COM13", 115200)
time.sleep(2.5)

print(mc.is_controller_connected())   # 1
print(mc.get_system_version())        # a number = arm link is good
print(mc.get_angles())                # 6 values
```

If everything returns `-1`, go to
[9.3 Hardware issues](../../4-SupportAndService/9.Troubleshooting/9.3-hardware.md).

## 7. First movement

Only once telemetry reads correctly. Check the current pose so you know how far
the arm will travel, clear the workspace, and use a low speed:

```python
print(mc.get_angles())
mc.send_angles([0, 0, 0, 0, 0, 0], 20)
```

Full checklist: [9.1 First-time self-check](../../4-SupportAndService/9.Troubleshooting/9.4-first-time-self-check.md)
