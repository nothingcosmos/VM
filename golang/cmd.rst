goコマンドの各種オプションについて
###############################################################################

適当に
*******************************************************************************

go env
===============================================================================

::

  GOARCH="amd64"
  GOBIN=""
  GOCHAR="6"
  GOEXE=""
  GOHOSTARCH="amd64"
  GOHOSTOS="linux"
  GOOS="linux"
  GOPATH="/home/elise/share/golang"
  GORACE=""
  GOROOT="/home/elise/language/golang/go"
  GOTOOLDIR="/home/elise/language/golang/go/pkg/tool/linux_amd64"
  TERM="dumb"
  CC="gcc"
  GOGCCFLAGS="-g -O2 -fPIC -m64 -pthread"
  CXX="g++"
  CGO_ENABLED="1"


go build
===============================================================================

-gcflags '-N -l'  最適化されなくなるため、バイナリが大きくなるが、
gdb debuggin時の変数がたくさん見える

go build -gcflags --help
===============================================================================

--helpが必要

go build -gcflags --help ::
  
  usage: 6g [options] file.go...
  -+  compiling runtime
  -%  debug non-static initializers
  -A  for bootstrapping, allow 'any' type
  -B  disable bounds checking
  -D path
      set relative path for local imports
  -E  debug symbol export
  -I dir
      add dir to import search path
  -K  debug missing line numbers
  -L  use full (long) path in error messages
  -M  debug move generation
  -N  disable optimizations
  -P  debug peephole optimizer
  -R  debug register optimizer
  -S  print assembly listing
  -V  print compiler version
  -W  debug parse tree after type checking
  -complete compiling complete package (no C or assembly)
  -d list
      print debug information about items in list
  -e  no limit on number of errors reported
  -f  debug stack frames
  -g  debug code generation
  -h  halt on error
  -i  debug line number stack
  -installsuffix pkg directory suffix
  -j  debug runtime-initialized variables
  -l  disable inlining
  -m  print optimization decisions
  -o obj
      set output file
  -p path
      set expected package import path
  -r  debug generated wrappers
  -race enable race detector
  -s  warn about composite literals that can be simplified
  -u  reject unsafe code
  -v  increase debug verbosity
  -w  debug type checking
  -x  debug lexer
  -y  debug declarations in canned imports (with -d)
  -largemodel generate code that assumes a large memory model

デバッグ時は
-N -l

最適化時は

bounds checking
move generation
optimization
peephole
register
inlining
largemodel


デバッグ用のオプション
===============================================================================

-Sをつけるとアセンブリ出力




===============================================================================
===============================================================================
===============================================================================
template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

