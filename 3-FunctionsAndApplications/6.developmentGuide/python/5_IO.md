# 6.2.5 IO Control

```python
mc.set_basic_output(pin, 0)     # 0xa0 -> digitalWrite
mc.get_basic_input(pin)         # 0xa1 -> digitalRead
```

## Pin numbers refer to the R4, not the M5

This is the one real difference. `SET_BASIC_OUT` (`0xa0`) and `GET_BASIC_IN`
(`0xa1`) are executed **by the controller board**, so the pin number is an
**Arduino UNO R4 pin**:

```cpp
case SET_BASIC_OUT:
    pinMode(f[4], OUTPUT);
    digitalWrite(f[4], f[5] ? HIGH : LOW);
    return true;
```

Any M5 GPIO numbers in existing code or tutorials (2, 5, 15, …) must be
remapped to R4 pins. Avoid **D0 and D1** — they are the arm's UART.

Usable general-purpose pins on an UNO R4: D2–D13, A0–A5.

Gripper and pump accessories that connect to the *arm's* end effector are
driven by the Atom over the serial protocol and are unaffected — use the
normal `set_gripper_*` calls.
