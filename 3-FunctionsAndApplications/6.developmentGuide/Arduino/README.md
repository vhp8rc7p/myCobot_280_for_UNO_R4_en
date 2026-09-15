# 6.1 Development Based on Arduino UNO R4

Using an Arduino UNO R4 (WiFi or Minima) as the myCobot 280's controller in
place of the M5Stack Basic.

There are two ways to work with the arm:

| Approach | What runs the logic | Use when |
|---|---|---|
| **Standalone sketch** | the Arduino | the arm should act on its own, no PC attached |
| **Transponder** | the PC, over USB | you want to drive the arm from Python |

Standalone sketches (`AnglesControl`, `CoordsControl`, `GripperControl`) call
the `MyCobotBasic` API directly from `loop()`. Transponder mode turns the R4
into a transparent serial bridge so `pymycobot` on the host controls the arm —
this is the equivalent of the M5 firmware's `Uart` mode, and is what most
people want.

## Contents

* [6.1.1 Environment Construction](10.1-arduino_download.md)
* [6.1.2 Simple Use](10.2-arduino_use.md)
* [6.1.3 API description](10.3-api.md)
* [6.1.4 Transponder mode](10.4-transponder.md)
* [6.1.5 LED matrix](10.5-led_matrix.md)
