# 6.6 Serial communication protocol

The wire protocol is **unchanged** by using an UNO R4 — it is defined by the
arm's Atom board, not the controller. The full opcode list is in the official
[communication protocol documentation](https://github.com/elephantrobotics/mycobot_docs/tree/main/myCobot_280_for_Arduino_en/3-FunctionsAndApplications/6.developmentGuide/CommunicationProtocolPackage/18-communication.md).

## Frame format

```
FE FE <len> <cmd> [payload...] FA
```

- `FE FE` — header
- `len` — number of bytes following, including the `FA` terminator
- `FA` — footer

Total frame size is `3 + len`.

## Controller-level commands

These are handled by the **controller board**, not the Atom, and are the ones a
transponder must answer itself:

| Code | Command |
|---|---|
| `0xa0` | `SET_BASIC_OUT` |
| `0xa1` | `GET_BASIC_IN` |
| `0xc1` | `GET_BASIC_VERSION` |
| `0xc2` | `SET_COMMUNICATE_MODE` |
| `0xc3` | `GET_COMMUNICATE_MODE` |

On an M5 build these also include `0xb0`/`0xb1` (WiFi SSID/password) and
`0xc0` (TOF distance). Neither applies to an R4 — there is no equivalent
WiFi transponder mode and no TOF sensor.

## Transport parameters

| Link | Baud | Notes |
|---|---|---|
| R4 ↔ arm | 1000000 | fixed, no negotiation |
| PC ↔ R4 | any | USB CDC — the value is ignored |
