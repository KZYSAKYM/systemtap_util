#!/bin/sh

stap -L 'kernel.function("*")' | \
	grep "write@" | \
	cut -d "(" -f 2 | \
	cut -d "@" -f 1 | \
	cut -d "\"" -f 2 >> reg_write.list
