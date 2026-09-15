# 5.1 Development environment

## System layout

```
+---------------------+        +-------------------+        +------------------+
|  PC                 |  USB   |  Arduino UNO R4   |  UART  |  myCobot 280     |
|  python / pymycobot |<------>|  (base controller)|<------>|  Atom + servos   |
+---------------------+  CDC   +-------------------+ D0/D1  +------------------+
                                 Serial      Serial1         1000000 baud
```

The UNO R4 occupies the role of the M5Stack Basic. The **Atom** board at the
end effector is unchanged and still runs its own firmware, flashed with
myStudio as usual.

## What changes, what does not

| Layer | Changed by using an R4? |
|---|---|
| Arm mechanics, servos, Atom | no |
| Serial protocol to the Atom | no |
| `pymycobot` host API | no |
| Base controller board | **yes** |
| `ParameterList.h` profile | **yes** — `MyCobot_M5` → `MyCobot_Mkr` |
| Logic level on the arm UART | **yes** — 3.3 V → 5 V |
| Screen / buttons / speaker | **yes** — LCD replaced by a 12x8 LED matrix |

Because the protocol and host API are unchanged, anything that talks to the
arm over a serial port — `pymycobot`, ROS, myBlockly — works through the R4 in
transponder mode without modification.

Code that used the M5's screen, buttons, speaker, WiFi or Bluetooth does not
port. The M5 RoboFlow firmware is in this category: it is built on
`M5Stack.h`, `WiFi.h`, `BLEDevice.h` and `BluetoothSerial.h`, all ESP32-only.

## Firmware requirements

* **Atom:** flash the latest AtomMain with myStudio, as for an M5 build.
* **Base (UNO R4):** flash from the Arduino IDE. myStudio cannot flash it.
