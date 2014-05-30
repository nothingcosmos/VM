golang debug
###############################################################################

goのmake方法
*******************************************************************************

srcの取得
===============================================================================

hgが必要。apt-get install mercurial

http://golang.org/doc/install/source ::

  hg clone -u release https://code.google.com/p/go
  hg update default

buld手順
===============================================================================

build ::

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

runtime debug option
===============================================================================

runtimeを-g付でdebugするオプションを探す。

all.bash
  make.bash
  run.bash
    go build ../misc/goplay
    //bootstrapしててよくわからん。。

run.bash
run.rc

go envで下記が確認できる。
GOGCCFLAGS="-g -O2 -fPIC -m64 -pthread"

GOGCCFLAGS
===============================================================================

GOGCCFLAGSで探すと以下がみつかる。 ::

  cmd/go/env.go:    env = append(env, envVar{"GOGCCFLAGS", strings.Join(cmd[3:], " ")})

これじゃないので、-g -O2で探す。

cmd/go/build.go ::

  cppflags = stringList(envList("CGO_CPPFLAGS", ""), p.CgoCPPFLAGS)
  cflags = stringList(envList("CGO_CFLAGS", defaults), p.CgoCFLAGS)
  cxxflags = stringList(envList("CGO_CXXFLAGS", defaults), p.CgoCXXFLAGS)
  ldflags = stringList(envList("CGO_LDFLAGS", defaults), p.CgoLDFLAGS)

-gがデフォルトで付いてるっぽい。もしO2を外したくなったら上記で。。


gdb
===============================================================================

gdb ::

  $ gdb go
  $ break main
  $ run

  asm_amd64.s //ここで止まった。。

grep _rt0_go ::

  pkg/runtime/runtime.h
  pkg/runtime/asm_amd64.s:TEXT _rt0_go(SB),NOSPLIT,$0
  cmd/link/link_test.go:    StartSym: "_rt0_go"

pkg/runtime/runtime.hのシンボルは全部breakできるっぽい。


callchain ::

  pkg/runtime/asm_amd64.s
    pkg/runtime/os_linux.c
      pkg/runtime/sys_linux_amd64.s

  pkg/runtime/proc.c:140
    runtime.schedinit  //これはbreak可能
    runtime・schedinit //gdbからはbreakできなかった。


runtime debugging
===============================================================================

runtime/proc.c ::

  runtime·parsedebugvars();
    runtime..getenv("GODEBUG");
    *dbgvar[i].value = runtime.atoiなどなど
  ...

  DebugVars runtime.debug

  {"allocfreetrace", &runtime·debug.allocfreetrace}, //int 1
  {"efence", &runtime·debug.efence},            //int 1
  {"gctrace", &runtime·debug.gctrace},          //int 1 or 2
  {"gcdead", &runtime·debug.gcdead},            //int 1
  {"scheddetail", &runtime·debug.scheddetail},  //int 1
  {"schedtrace", &runtime·debug.schedtrace},    //int X 恐らく1millisだと思う

  設定例は以下
  GODEBUG=gctrace=1

  printの中身を見てみる。
  runtime/print.c
    vprintf()
      gwrite(lp, p-lp);
      // write to goroutine-local buffer if diverting output,
      // or else standard error.

環境変数であるGODEBUGを設定すると、runtimeが起動時に環境変数を読み込んでモードを切り替えできる。

設定例 ::

  export GODEBUG="scheddetail=1,schedtrace=1"

上記を設定すると、go buildしたプログラムも、goプログラム自体もdebugモードが有効にできる。

1は1ms単位に可能であればtraceしてくれということ。


GODEBUG scheddetail
===============================================================================

export GODEBUG="scheddetail=1,schedtrace=1"

SCHED ::

  //Pが1個なのは制限してるからか？
  SCHED 0ms: gomaxprocs=1 idleprocs=0 threads=2 idlethreads=0 runqueue=0 gcwaiting=1 nmidlelocked=0 nmspinning=0 stopwait=0 sysmonwait=0
    P0: status=3 schedtick=1 syscalltick=0 m=0 runqsize=1/128 gfreecnt=0
    M1: p=-1 curg=-1 mallocing=0 throwing=0 gcing=0 locks=1 dying=0 helpgc=0 spinning=0 lockedg=-1
    M0: p=0 curg=1 mallocing=0 throwing=0 gcing=0 locks=3 dying=0 helpgc=0 spinning=0 lockedg=1
    G1: status=2(garbage collection) m=0 lockedm=0
    G2: status=1() m=-1 lockedm=-1
  SCHED 1ms: gomaxprocs=1 idleprocs=0 threads=4 idlethreads=1 runqueue=0 gcwaiting=0 nmidlelocked=1 nmspinning=0 stopwait=0 sysmonwait=0
    P0: status=1 schedtick=4 syscalltick=0 m=0 runqsize=0/128 gfreecnt=0
    M3: p=-1 curg=-1 mallocing=0 throwing=0 gcing=0 locks=0 dying=0 helpgc=0 spinning=0 lockedg=-1
    M2: p=-1 curg=2 mallocing=0 throwing=0 gcing=0 locks=0 dying=0 helpgc=0 spinning=0 lockedg=-1
    M1: p=-1 curg=-1 mallocing=0 throwing=0 gcing=0 locks=1 dying=0 helpgc=0 spinning=0 lockedg=-1
    M0: p=0 curg=1 mallocing=0 throwing=0 gcing=0 locks=1 dying=0 helpgc=0 spinning=0 lockedg=-1
    G1: status=2(garbage collection) m=0 lockedm=-1
    G2: status=3() m=2 lockedm=-1
  SCHED 2ms: gomaxprocs=1 idleprocs=0 threads=4 idlethreads=1 runqueue=0 gcwaiting=1 nmidlelocked=1 nmspinning=0 stopwait=0 sysmonwait=0
    P0: status=3 schedtick=4 syscalltick=4 m=0 runqsize=1/128 gfreecnt=0
    M3: p=-1 curg=-1 mallocing=0 throwing=0 gcing=0 locks=0 dying=0 helpgc=0 spinning=0 lockedg=-1
    M2: p=-1 curg=2 mallocing=0 throwing=0 gcing=0 locks=0 dying=0 helpgc=0 spinning=0 lockedg=-1
    M1: p=-1 curg=-1 mallocing=0 throwing=0 gcing=0 locks=1 dying=0 helpgc=0 spinning=0 lockedg=-1
    M0: p=0 curg=1 mallocing=0 throwing=0 gcing=0 locks=3 dying=0 helpgc=0 spinning=0 lockedg=-1
    G1: status=2(garbage collection) m=0 lockedm=-1
    G2: status=3() m=2 lockedm=-1
    G3: status=1() m=-1 lockedm=-1

0ms, 1msと1ms単位に可能であればtrace出すようになっている。

0ms P=1, M=2, G=2
1ms P=1, M=4, G=2 Mの個数が増えたのは何故だろう。
2ms P=1, M=4, G=3 mainのGが起動した？

Gを100個起動してみる。

G108: status=4(chan receive) m=-1 lockedm=-1
G109: status=3(timer goroutine (idle)) m=3 lockedm=-1

statusの意味
()の中のtrace
m=の意味
lockedmの意味

GOMAXPROCSが4個まえ増えたのは確認できた。
M=5
thread=6


status
lockedm

表示の読み方
===============================================================================

ソースコードは
runtime/proc.c:runtime..schedtrace()

P0: status=3 schedtick=4 syscalltick=4 m=0 runqsize=1/128 gfreecnt=0
p->status
p->schedtick
p->syscalltick
mp->id or -1

M3: p=-1 curg=-1 mallocing=0 throwing=0 gcing=0 locks=0 dying=0 helpgc=0 spinning=0 lockedg=-1
mp->id
p->id or -1
gp->goid or -1
lockedg->goid or -1

G109: status=3(timer goroutine (idle)) m=3 lockedm=-1
gp->goid
gp->status
gp->waitreason
mp->id or -1
lockedm->id or -1

status=idle,runnable,running,syscall,waiting,waitreason


pritty printer
===============================================================================
runtime-gdb.py:This  script is loaded by GDB when it finds a .debug_gdb_scripts

手でtrueにして実行すればいいか。


runtime/runtime.c  DebugVars runtime..debug;
===============================================================================

GOTRACEBACK
===============================================================================

// The GOTRACEBACK environment variable controls the
// behavior of a Go program that is crashing and exiting.
//      GOTRACEBACK=0   suppress all tracebacks
//      GOTRACEBACK=1   default behavior - show tracebacks but exclude runtime frames
//      GOTRACEBACK=2   show tracebacks including runtime frames
//      GOTRACEBACK=crash   show tracebacks including runtime frames, then crash (core dump etc)


enum debug
===============================================================================

if(debug) これでいろいろとprintを切り分けている。

sample ::

  if(debug) {
      runtime·printf("chansend: chan=%p; elem=", c);
      c->elemtype->alg->print(c->elemsize, ep);
      runtime·prints("\n");
  }

下記のファイルに定義されている、rebuildすれば有効になるはず。

grep "debug = 0" *
chan.h:	debug = 0,
hashmap.goc:  debug = 0,    // print every operation
slice.goc:  debug = 0
symtab.goc:   debug = 0
time.goc: debug = 0,
zhashmap_linux_amd64.c:debug = 0 , 
zslice_linux_amd64.c:debug = 0 
zsymtab_linux_amd64.c:debug = 0 
ztime_linux_amd64.c:debug = 0 , 

chan.hのdebug = 1を有効にしてrebuildすればchanのデバッグ出力が有効になった。

===============================================================================
