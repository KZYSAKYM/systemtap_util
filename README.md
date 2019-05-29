# systemtap utility

The purpose of this repository is to create/store systemtap scripts for kernel developper.

## Cheat Sheet

T.B.D

## STP scripts

### `argv_reg_write.stp`

- Purpose: check arguments of a function writing register of each driver.
- Usage: stap $this [target function name]

Maybe, you should create a shell script to parse the messages of this script.
