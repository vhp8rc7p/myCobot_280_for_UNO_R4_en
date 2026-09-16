# myCobot 280 for Arduino UNO R4

Documentation for driving a **myCobot 280** from an **Arduino UNO R4**
(WiFi or Minima) in place of the M5Stack Basic controller.

```
PC (python / pymycobot)  <--USB CDC-->  [Serial] UNO R4 [Serial1]  <--D0/D1-->  myCobot 280
```

The UNO R4 replaces the M5Stack Basic that normally sits in the arm's base. It
runs the same `MyCobotBasic` library, reconfigured for a non-M5 board, and acts
as a transparent serial bridge so `pymycobot` on the host drives the arm
directly.

| | M5Stack Basic | Arduino UNO R4 |
|---|---|---|
| MCU | ESP32 | Renesas RA4M1 (Cortex-M4) |
| Logic level | 3.3 V | **5 V** |
| Arm UART | `Serial2` (GPIO16/17) | `Serial1` (D0/D1) |
| Host UART | `Serial` | `Serial` (native USB CDC) |
| Screen | 320x240 LCD | 12x8 LED matrix |
| `ParameterList.h` profile | `MyCobot_M5` | `MyCobot_Mkr` |

Pages without a suffix are the UNO R4 version; pages suffixed **`-M5`** are the
original M5Stack / Mega2560 ones, kept unchanged.

## Quick start

New to this? Start with
**[6.1.6 Build and upload, step by step](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.6-arduino_ide_build.md)**
— a click-by-click walkthrough from a fresh Arduino IDE to a moving arm.

Or go straight to the topic you need:

1. [Environment setup](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.1-arduino_download.md)
2. [Wiring](3-FunctionsAndApplications/5.BasicFunction/5.3-HardwareInterface/RoboticArmElectricalInterface.md)
3. [Library configuration and first upload](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.2-arduino_use.md)
4. [Transponder mode](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.4-transponder.md)
5. [Python control](3-FunctionsAndApplications/6.developmentGuide/python/1_download.md)

Ready-to-flash firmware that needs no library install:
[MyCobot280_R4_Transponder](https://github.com/vhp8rc7p/MyCobot280_R4_Transponder).

## The two things that catch people out

1. **`ParameterList.h` must be switched to the Mkr profile**, and only the copy
   in the **library root** is used by the build — the one in the example folder
   is a template to copy *from*.
2. **`Mkr/Transponder.ino` does not compile for the R4 as shipped**
   (`reference to 'data' is ambiguous`).

Both are covered in
[6.1.2 Simple Use](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.2-arduino_use.md).
