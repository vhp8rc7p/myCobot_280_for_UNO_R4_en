# Product Parameters (UNO R4)

Parameters for a **myCobot 280 for Arduino** using an **Arduino UNO R4** as the
main-control board.

The arm is unchanged — mechanics, servos and the Atom end-effector board are
identical to any other myCobot 280 for Arduino. Only the main-control
parameters differ.

## Robot parameters

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

## Main control parameters — UNO R4

| Parameter | Value |
|---|---|
| Microcontroller | Renesas RA4M1 |
| Core | Arm Cortex-M4, 32-bit |
| Clock | 48 MHz |
| Flash | 256 KB |
| SRAM | 32 KB |
| EEPROM | 8 KB |
| Hardware UARTs | 3 |
| Operating logic level | 5 V |
| USB | USB-C |

### Board variants

| | UNO R4 Minima | UNO R4 WiFi |
|---|---|---|
| Drives the arm | Yes | Yes |
| Wireless | None | Wi-Fi + Bluetooth LE |
| LED matrix | None | 12 × 8 |

### Main control options compared

| | UNO R3 | MEGA 2560 | UNO R4 |
|---|---|---|---|
| MCU | ATmega328P | ATmega2560 | Renesas RA4M1 |
| Architecture | AVR 8-bit | AVR 8-bit | Arm Cortex-M4 32-bit |
| Clock | 16 MHz | 16 MHz | 48 MHz |
| Flash | 32 KB | 256 KB | 256 KB |
| SRAM | 2 KB | 8 KB | 32 KB |
| Logic level | 5 V | 5 V | 5 V |

For wiring and the electrical interface, see
[5.3 Hardware Interface](../../3-FunctionsAndApplications/5.BasicFunction/5.3-HardwareInterface/RoboticArmElectricalInterface.md).
