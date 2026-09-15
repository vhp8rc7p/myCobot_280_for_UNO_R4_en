# 6.2.2 API description

The `pymycobot` API is unchanged. See the official
[API description](https://github.com/elephantrobotics/mycobot_docs/tree/main/myCobot_280_for_Arduino_en/3-FunctionsAndApplications/6.developmentGuide/python/2_API.md).

## Methods worth knowing on an R4 build

| Method | Note |
|---|---|
| `is_controller_connected()` | `1` good, `-1` nothing returning. First thing to check. |
| `get_basic_version()` | `2.4` from a correct R4 transponder. Answered by the R4 itself, not the arm. |
| `get_system_version()` | comes from the Atom — proves the arm link works. |
| `is_moving()` | `1` moving, `0` stopped, `-1` error. See [6.2.3](3_angle.md). |

`get_basic_version()` is useful for isolating faults: it is answered by the
**R4**, so it succeeds even with the arm unplugged. If it returns `2.4` but
`get_system_version()` returns `-1`, the USB side is fine and the fault is
between the R4 and the arm.

Methods that do **not** work on an R4 build:

| Method | Why |
|---|---|
| anything driving the M5 LCD | no screen — see [6.1.5 LED matrix](../Arduino/10.5-led_matrix.md) |
| WiFi / Bluetooth transponder setup (`0xb0`/`0xb1`) | R4 transponder is USB-only |
| TOF distance (`0xc0`) | no TOF sensor |
