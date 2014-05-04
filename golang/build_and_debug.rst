golang debug
###############################################################################

build
*******************************************************************************

buld手順
===============================================================================
http://golang.org/doc/install/source

hg clone -u release https://code.google.com/p/go

hg update default

cd go/src

./all.bash

build log (2014/03)
===============================================================================

bootstrapとcompiler and bootstrap

log ::

  # Building C bootstrap tool.
  cmd/dist

  # Building compilers and Go bootstrap tool for host, linux/amd64.
  lib9
  libbio
  libmach
  liblink
  misc/pprof
  cmd/addr2line
  cmd/objdump
  cmd/prof
  cmd/cc
  cmd/gc
  cmd/6l
  cmd/6a
  cmd/6c
  cmd/6g
  pkg/runtime
  pkg/errors
  pkg/sync/atomic
  pkg/sync
  pkg/io
  pkg/unicode
  pkg/unicode/utf8
  pkg/unicode/utf16
  pkg/bytes
  pkg/math
  pkg/strings
  pkg/strconv
  pkg/bufio
  pkg/sort
  pkg/container/heap
  pkg/encoding/base64
  pkg/syscall
  pkg/time
  pkg/os
  pkg/reflect
  pkg/fmt
  pkg/encoding
  pkg/encoding/json
  pkg/flag
  pkg/path/filepath
  pkg/path
  pkg/io/ioutil
  pkg/log
  pkg/regexp/syntax
  pkg/regexp
  pkg/go/token
  pkg/go/scanner
  pkg/go/ast
  pkg/go/parser
  pkg/os/exec
  pkg/os/signal
  pkg/net/url
  pkg/text/template/parse
  pkg/text/template
  pkg/go/doc
  pkg/go/build
  cmd/go

  # Building packages and commands for linux/amd64.
  runtime
  errors
  sync/atomic
  unicode
  ...以降省略

  # Checking API compatibility.


debug runtime
===============================================================================

all.bash
  make.bash
  run.bash
    go build ../misc/goplay

run.bash
run.rc

build.go -g
gccで検索して-g　つければいいか？


cmd/go/build.go
===============================================================================

build.go -Wall -gを追加する

GO_CFLAGS

書き換えテスト
===============================================================================

${CC:-gcc} $mflag -O2 -Wall -Werror -o cmd/dist/dist -Icmd/dist "$DEFGOROOT"

gdb
===============================================================================

gdb debug ::

  gdb go
  break main

  asm_amd64.s

grep _rt0_go

  pkg/runtime/runtime.h
  pkg/runtime/asm_amd64.s:TEXT _rt0_go(SB),NOSPLIT,$0
  cmd/link/link_test.go:    StartSym: "_rt0_go"

pkg/runtime/runtime.hのシンボルは全部breakできるっぽい。



gdb
*******************************************************************************

call ::

  pkg/runtime/asm_amd64.s
    pkg/runtime/os_linux.c
      pkg/runtime/sys_linux_amd64.s

  pkg/runtime/proc.c:140
    runtime.schedinit  //これはbreak可能
    runtime・schedinit //gdbからはbreakできなかった。


===============================================================================
===============================================================================
===============================================================================


===============================================================================
