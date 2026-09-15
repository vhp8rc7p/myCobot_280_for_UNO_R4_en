# 6. Software Development Guide

Development paths for a myCobot 280 driven by an Arduino UNO R4.

* [6.1 Development Based on Arduino UNO R4](Arduino/README.md) — firmware on the R4 itself
* [6.2 Development and use based on Python](python/README.md) — host control through the transponder
* [6.6 Serial communication protocol](18-communication.md) — the wire format

ROS, ROS2 and myBlockly are unaffected by the choice of controller *provided*
the R4 is running transponder mode, since they all speak the same serial
protocol over a COM port. They are documented in the
[official guide](https://github.com/elephantrobotics/mycobot_docs/tree/main/myCobot_280_for_Arduino_en).
myStudio firmware flashing does **not** apply to the R4 — use the Arduino IDE.
