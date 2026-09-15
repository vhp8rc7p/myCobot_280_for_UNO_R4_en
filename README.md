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

## Why a separate guide

The official myCobot 280 Arduino documentation targets the **M5Stack Basic**,
which is an ESP32 board. The UNO R4 is a Renesas RA4M1 (Arm Cortex-M4), and the
differences are not cosmetic:

| | M5Stack Basic | Arduino UNO R4 |
|---|---|---|
| MCU | ESP32 | Renesas RA4M1 (Cortex-M4) |
| Logic level | 3.3 V | **5 V** |
| Arm UART | `Serial2` (GPIO16/17) | `Serial1` (D0/D1) |
| Host UART | `Serial` | `Serial` (native USB CDC) |
| Screen | 320x240 LCD | 12x8 LED matrix |
| `ParameterList.h` profile | `MyCobot_M5` | `MyCobot_Mkr` |

The stock library does not compile for the R4 without a configuration change,
and one official example does not compile at all. Both are documented here with
verified fixes.

## Status of this document

Everything in the R4-specific chapters was executed end-to-end against a real
myCobot 280 and an UNO R4 WiFi. Compile results, protocol traces and latency
figures are measured, not estimated. Pages that are board-independent
(product parameters, accessories, ROS, Blockly) link to the official
documentation rather than restating it.

## Relationship to the official documentation

This is an **unofficial community supplement**, not an Elephant Robotics
publication. It follows the chapter numbering of the official
[myCobot 280 for Arduino](https://github.com/elephantrobotics/mycobot_docs/tree/main/myCobot_280_for_Arduino_en)
GitBook so the two can be read side by side.

Hardware, product and safety information remains authoritative in the official
documentation. Where a topic is unchanged by the choice of controller, this
guide links there instead of duplicating it.

## Quick start

If you only want the arm moving from Python:

1. [Environment setup](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.1-arduino_download.md)
2. [Wiring](3-FunctionsAndApplications/5.BasicFunction/5.3-HardwareInterface/RoboticArmElectricalInterface.md)
3. [Library configuration and first upload](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.2-arduino_use.md)
4. [Transponder mode](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.4-transponder.md)
5. [Python control](3-FunctionsAndApplications/6.developmentGuide/python/1_download.md)

Ready-to-flash firmware that needs no library install:
[MyCobot280_R4_Transponder](https://github.com/vhp8rc7p/MyCobot280_R4_Transponder).
