aioレイヤ
####

src_17.0

aioのレイヤどうなっているのかと。
主にwindows側をどうしているのか気になる。

基本的にはemulator/sys/ose/sys.c

windows
===

emulator/sys/win32/sys.c

struct async_io

init_async_io
async_read_file
  ReadFile(fd, buf, num, aio->bytesTransferred, aio->ov)
async_write_file

上記を呼び出すのは、
  fd_driver_entry
  spawn_driver_entry
  struct erl_drv_entry
    spawn_start
      set_driver_data

  erl_drv_entry vanilla_driver_entryは、unixとwin32双方に定義されている。

beam/io.c ::

  extern ErlDrvEntry vanilla_driver_entry;
  extern ErlDrvEntry spawn_driver_entry;
  extern ErlDrvEntry *driver_tab[]; /* table of static drivers, only used during initialization */

fd_driver_entry

driver構造体

という抽象的な構造体を作って、実装ごとにコントロール可能な

unix
fdのみ管理、select
fd単位に管理して、pipのfdをdup2によるつなぎ替えを駆使して

read_inputの中ではread()かな

ose
aioを使う

win32
WindowsのReadFile/WriteFileを使う

erlangは大変勉強になりますね。。
os非依存にfdを管理するdriver構造体を作って、
その実装はose(aio使用),win32,unix(aioなし)の下で適時実装を切り替えると。
OS抽象にthreadへ依存せず非同期IOしてソフトリアルタイム性確保するためにはこれしか解がないのか。。


linux
===


中層
===

READ_AIO
  初期化
  aio_read

WRITE_AIO
  初期化
  aio_write

aio_dispatch(sig)



具体的には


beam/io.c

extern ErlDrvEntry fd_driver_entry;
extern ErlDrvEntry vanilla_driver_entry;
extern ErlDrvEntry spawn_driver_entry;


初期はこういうのが続く。
init_driver(&vanilla_driver, &vanilla_driver_entry, NULL);

call_driver_control()を使って呼び出される。
  drv_ptr->control()
  (ErlDrvData)prt->drv_data


