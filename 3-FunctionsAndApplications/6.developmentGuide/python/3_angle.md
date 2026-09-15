# 6.2.3 Joint control

```python
mc.get_angles()                             # [J1..J6] degrees
mc.send_angles([0, 0, 0, 0, 0, 0], 20)      # all joints, speed 0-100
mc.send_angle(1, -45, 20)                   # single joint
```

A myCobot 280 returns **6** values. If you get 4, you are using the
`MyPalletizer260` class — see [6.2.1](1_download.md).

## Waiting for a move to finish

`send_angles()` returns immediately; the arm takes seconds. To act on arrival
you must wait — and the obvious way is wrong.

> ### Do not detect completion by comparing successive `get_angles()`
>
> Immediately after `send_angles()` the arm **has not started moving yet**, so
> two consecutive reads are identical and look like "finished". The next
> command then clobbers the move in flight.
>
> This is what that failure looks like — each step racing ahead of the arm:
>
> ```
> -> home (all zeros)
>    settled: [-0.87, -0.61, 0.17, -0.61, 0.7, 0.87]
> -> J1 to -45
>    settled: [-1.14, ...]      <- barely moved, returned far too early
> -> back to home
>    settled: [-11.77, ...]     <- still travelling toward -45
> final: [-41.92, ...]          <- ended at -45, not home
> ```

Use `is_moving()`, which is authoritative:

```python
def wait_until_idle(mc, timeout=20.0):
    time.sleep(0.4)                   # let the move actually start
    t0 = time.time()
    while time.time() - t0 < timeout:
        if mc.is_moving() == 0:       # 1 moving, 0 stopped, -1 error
            break
        time.sleep(0.2)
    return mc.get_angles()
```

With that fix the same sequence behaves:

```
-> home       settled: [-0.87, -0.61, 0.17, -0.61, 0.7, 0.87]
-> J1 to -45  settled: [-43.85, ...]
-> back home  settled: [-0.79, ...]
```

## Accuracy

Commanded zero typically settles within about 1 degree per joint:

```
[-0.79, -0.61, 0.17, -0.61, 0.7, 0.87]
```

That residual is servo resolution and backlash, not a transport problem.
