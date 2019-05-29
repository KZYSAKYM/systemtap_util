# systemtap utility

The purpose of this repository is to create/store systemtap scripts for kernel developper.

## Cheat Sheet
### Basic syntax

```awk
/* user defined stp function */
function <func name>(<argv>) {
	/* procedure */
}

probe <probe point> {
	/* procedure */
}

global <global stp variable>

$1 /* similar to sh $1 */
@1 /* similar to sh "$1" */
$# /* similar to sh $# */
@# /* similar to sh "$#" */
```

#### Probe Point

- begin: begining of stap script
- end: end of stap script
- error: when error happened
- timer.jiffies: heart beat by jiffiers
- timer.s: heart beat by sec
- timer.ms: heart beat by msec
- timer.us: heart beat by usec
- timer.ns: heart beat by nsec
- timer.hz: heart beat by Hz
- syscall.\<syscall\>[.return]: system call. below variables are available.
  - argstr: list of value of args
  - name: function name
  - retstr: return value (available in .return only)
- kernel.function("PATTERN")[.return]: any kernel functions. wild cards are available.
  - `$<var>`: variable in source codes
  - `$<var>-><member>`: arrow syntax is available
  - `$return`: return value
  - `$var[N]`: array
  - `$$<var>`: variables expanded as string
  - `$$locals`: local variables expanded as string
  - `$$perms`: arguments expanded as string
  - `$$return`: return expanded as string
  - PATTERN:
    - name: e.g. `"vfs_read"`
    - wild cards: e.g. `"*"`
    - file@line: e.g. `"@kernel/timer.c:111"`
- module(\<MOD NAME\>).function("PATTERN"): any module function
- kernel.trace("TRACE POINT"): static trace point

### built-in function

- `cpu()`: current cpu number
- `execname()`: current process name
- `exit()`: exit from stap script
- `pid()`: current process id
- `gettimeofday_[s/ms/us/ns]()`: UNIX epoch time
- `ctime()`: translate UNIX epoch time to string
- `pp()`: show info of probe point
- `probefunc()`: name of probed function
- `probemod()`: name of probed module
- `print_backtrace()`: show call stack
- `print_regs()`: show info of reg

### Get Probe List

- kernel function

```sh
$ stap -L 'kernel.function("*")'
```

- static probe point

```sh
$ stap -L 'kernel.trace("*")'
```

- module function

```sh
$ stap -L 'module("*").function("*")'
```

- vfs

```sh
$ stap -L 'vfs.*'
```

## Build kernel module

You can prebuild systemtap script with below cmd.

```sh
$ stap -v -p4 -m <mod name> <stp> [arg]
```

You can run prebuilt kernel module.

```sh
$ staprun -v <mod name>.ko
```

## STP scripts

### `argv_reg_write.stp`

- Purpose: check arguments of a function writing register of each driver.
- Usage: stap $this [target function name]

Maybe, you should create a shell script to parse the messages of this script.
