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

This is a **complete mirror** of the official
[myCobot 280 for Arduino](https://github.com/elephantrobotics/mycobot_docs/tree/main/myCobot_280_for_Arduino_en)
GitBook, with UNO R4 chapters added alongside the originals. All sections are
present — product information, ROS/ROS2, Blockly, accessories, successful cases
and supporting resources — with their images.

Two kinds of page live side by side:

| Suffix | Meaning |
|---|---|
| *(none)* | the **UNO R4** version — rewritten for this board |
| `-M5` | the **original** page, preserved unchanged |

So `6.1.2 Simple Use` is the R4 guide, and `6.1.2-M5 Simple Use` is the
original M5Stack/Mega2560 one. Nothing from the source documentation was
removed.

Everything in the R4 chapters was executed end-to-end against a real myCobot
280 and an UNO R4 WiFi — compile results, protocol traces, error messages and
latency figures are measured output, not estimates. The inherited chapters are
reproduced as published and were not re-verified against R4 hardware.

## Relationship to the official documentation

This mirrors Elephant Robotics' documentation and follows its chapter numbering
so the two can be read side by side. Hardware, product and safety information
remains authoritative in the official version — if the two ever disagree on
anything that is not R4-specific, the official one is correct.

Upstream issues repaired while mirroring:

- **5.3 Hardware Interface** — the link in the official `SUMMARY.md` is split
  across two lines and does not resolve; repaired here.
- **7. Successful Cases** — three entries point at a `demo/` directory that is
  not present in the source tree (`demo/280ar_mega2560_gripper.md`,
  `demo/280ar_raspi4B_camera_flange.md`, `demo/280ar_jetsonxavier_pump.md`);
  omitted here rather than left broken.

## Quick start

If you only want the arm moving from Python:

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
