# rsdk - RadxaOS Software Development Kit

[![Build images](https://github.com/RadxaOS-SDK/rsdk/actions/workflows/build.yaml/badge.svg)](https://github.com/RadxaOS-SDK/rsdk/actions/workflows/build.yaml) [![Deploy documentation](https://github.com/RadxaOS-SDK/rsdk/actions/workflows/docs.yaml/badge.svg)](https://github.com/RadxaOS-SDK/rsdk/actions/workflows/docs.yaml)

To learn more about `rsdk`, please visit [our documentation](https://RadxaOS-SDK.github.io/rsdk/).



| Pino | GPIO | Offset |
| ---- | ---- | ------ |
| 1_A3 | 35   | 3      | in rock5b+
| 1_D7 | 63   | 31     | in rock5b
| 3_A4 | 100  | 4      | out
| 3_A7 | 103  | 7      | in
| 3_B1 | 105  | 9      | out
| 3_B2 | 106  | 10     | out
| 3_B3 | 107  | 11     | out
| 3_C2 | 114  | 18     | out
| 3_C3 | 115  | 19     | out
| 4_B2 | 138  | 10     | out
| 4_B3 | 139  | 11     | out
| 4_C4 | 148  | 20     | out
| 4_C5 | 149  | 21     | in
| 4_C6 | 150  | 22     | in

gpioset gpiochip3 9=0
gpioset gpiochip3 9=1
gpioget gpiochip4 21