# myCobot 280 For Arduino — UNO R4 edition

Algorithm Verification Practice Teaching

Core Document
---

This document contains comprehensive information from product introduction,
detailed technical parameters to user instructions and product development
guidance. The document will introduce the basic functions of the myCobot 280
For Arduino robot arm in depth, provide a software development guide, and show
successful application cases to help you understand how to effectively
integrate myCobot 280 For Arduino into various applications. In addition, we
also provide a wealth of support and service information to ensure that you can
get the necessary help when you encounter any technical challenges.

This edition additionally covers using an **Arduino UNO R4** (WiFi or Minima)
as the main-control board, in place of the M5Stack Basic:

```
PC (python / pymycobot)  <--USB CDC-->  [Serial] UNO R4 [Serial1]  <--D0/D1-->  myCobot 280
```

The arm is unchanged — mechanics, servos and the Atom end-effector board are
identical. Only the controller in the base differs, so only the chapters that
depend on it are rewritten.

| | M5Stack Basic | Arduino UNO R4 |
|---|---|---|
| MCU | ESP32 | Renesas RA4M1 (Cortex-M4) |
| Logic level | 3.3 V | **5 V** |
| Arm UART | `Serial2` (GPIO16/17) | `Serial1` (D0/D1) |
| Host UART | `Serial` | `Serial` (native USB CDC) |
| Screen | 320x240 LCD | 12x8 LED matrix |
| `ParameterList.h` profile | `MyCobot_M5` | `MyCobot_Mkr` |

Pages without a suffix are the UNO R4 version. Pages suffixed **`-M5`** are the
original, kept unchanged — so `6.1.2 Simple Use` is the R4 guide and
`6.1.2-M5 Simple Use` is the original M5Stack / Mega2560 one.

Document Description
---

Depending on your needs and your level of expertise in myCobot 280 For Arduino
application development, you can choose to follow this order from beginning to
end or use it as a standalone reference. You can always use the sidebar
navigation on the left to jump to any part of this document. The full text is
divided into the following five sections:

#### Product Information

The product information section will provide you with a basic overview of the
robot arm, including detailed technical specifications such as main functions,
product parameters and electrical characteristics, to help you quickly
understand the basic characteristics and usage environment of the product. In
addition, this section will detail the application examples and supported
extension development of the product, providing you with the necessary
development guides and resources. At the end of the article, relevant purchase
links and channels will be given to facilitate your purchase.

#### Basic Settings

This section is an important part that every user of this product must read
carefully. It covers key information about product use, transportation, storage
and maintenance, aiming to ensure the safety and efficiency of users when
operating the product. In addition, this section also details the division of
responsibilities for product failure or damage that may occur due to failure to
follow these guidelines.

#### Functions and Applications

The Functions and Applications section details the basic functions of the robot
arm and how to use the software, including system instructions and firmware
functions. The Software Development Guide provides guidance based on different
development environments, such as Python and ROS, to support technical
developers to expand applications. By showing successful application cases and
providing supporting resources, it provides you with practical references and
necessary support materials for a deeper understanding and use of the product.

#### Support and Services

The Support and Services section will provide you with comprehensive
troubleshooting guides and post-purchase service information, such as warranty
and service terms, to help you quickly resolve problems when you encounter
them, and ensure that you understand your rights and obligations after
purchase. In addition, the 'About Us' section strengthens the user's
understanding of the design and manufacturer of the myCobot series products,
aiming to build trust and brand loyalty.

#### Acknowledgements

We really appreciate you taking the time to read the myCobot 280 For Arduino
User Manual. We hope this document will help you better understand and
effectively use this robot, thereby inspiring your creativity. If you have any
questions or need further assistance, please feel free to contact our customer
support team. We look forward to seeing your innovative projects using
myCobot 280 For Arduino and welcome you to join our fast-growing developer
community.

Quick start
---

New to the UNO R4 setup? Start with
**[6.1.6 Build and upload, step by step](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.6-arduino_ide_build.md)**
— a click-by-click walkthrough from a fresh Arduino IDE to a moving arm.

Or go straight to the topic you need:

1. [Environment setup](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.1-arduino_download.md)
2. [Wiring](3-FunctionsAndApplications/5.BasicFunction/5.3-HardwareInterface/RoboticArmElectricalInterface.md)
3. [Library configuration and first upload](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.2-arduino_use.md)
4. [Transponder mode](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.4-transponder.md)
5. [Python control](3-FunctionsAndApplications/6.developmentGuide/python/1_download.md)
6. [Specification (UNO R4 edition)](1-ProductInformation/2.ProductParameter/2-ProductParameters-R4.md)

Ready-to-flash firmware that needs no library install:
[MyCobot280_R4_Transponder](https://github.com/vhp8rc7p/MyCobot280_R4_Transponder).

### The two things that catch people out

1. **`ParameterList.h` must be switched to the Mkr profile**, and only the copy
   in the **library root** is used by the build — the one in the example folder
   is a template to copy *from*.
2. **`Mkr/Transponder.ino` does not compile for the R4 as shipped**
   (`reference to 'data' is ambiguous`).

Both are covered in
[6.1.2 Simple Use](3-FunctionsAndApplications/6.developmentGuide/Arduino/10.2-arduino_use.md).
