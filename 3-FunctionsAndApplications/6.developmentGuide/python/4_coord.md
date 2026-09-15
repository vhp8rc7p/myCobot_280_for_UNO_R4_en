# 6.2.4 Coordinate Control

```python
mc.get_coords()                 # [x, y, z, rx, ry, rz]
mc.send_coords([50, -60, 420, -91, 0.9, -90], 20, 0)
```

A myCobot 280 returns **6** values: three translations in mm, three rotations
in degrees.

```
[47.9, -63.5, 420.0, -91.05, 0.89, -90.1]
```

If you see only 4, you are using `MyPalletizer260` — that class is for a
4-axis palletizer and truncates `rx`, `ry`, `rz`. See
[6.2.1](1_download.md).

Waiting for completion works exactly as in
[6.2.3 Joint control](3_angle.md) — use `is_moving()`, not repeated
`get_coords()` comparisons.

Inverse kinematics runs on the arm, not the R4, so reachability and singularity
behaviour are unchanged from an M5 build.
