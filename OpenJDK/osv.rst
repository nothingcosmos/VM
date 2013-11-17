OSv
################################################################################

Overview
********************************************************************************
OSvは恐らく JVMからLinux として認識されるはず？

archはx64のみサポート

JavaVMはHotspotのみサポート

興味があるところ
********************************************************************************

OSvにより、Javaのプログラムがどのくらい高速になるのかどうか。
どういったところが性能向上するのかどうか。
たとえば、memoryの管理 GC IO MultiThreading

OSvからJavaVMを起動して制御するところに特殊なところはあるか。

JavaからOSvを呼び出す場合、何か特殊なところはあるか。

OSv <-> JavaVM間で連携するような処理はあるか。


OSvからJVMを起動するところ
********************************************************************************

通常起動において必要なのは
# java/java.so   //JavaVMの起動用
# java/runjava.jar //ClassLoader 兼 MainClass実行

上記はbuild.mkに記述されている。

code java/java.cc ::

  #define JVM_PATH        "/usr/lib/jvm/jre/lib/amd64/server/libjvm.so"
  #define RUNJAVA_PATH    "/java/runjava.jar"
  #define RUNJAVA         "io/osv/RunJava"    // separated by slashes, not dots

  main()関数
  // JNIのインターフェースを使用してJavaVMを作成する。
  auto JNI_CreateJavaVM
  = prog->lookup_function<jint (JavaVM**, JNIEnv**, void*)>("JNI_CreateJavaVM");
  
  //main関数を取得して実行。たぶんここでblockingするんでしょ。
  env->CallStaticVoidMethod(mainclass, mainmethod, args);

  // DestroyJavaVM() waits for all all non-daemon threads to end, and
  // only then destroys the JVM.
  jvm->DetachCurrentThread();
  jvm->DestroyJavaVM();
  return 0;

上記はjava.soとしてビルドされる。
OSvの実行時にjava.soを使用してJavaVMを起動する。
javaコマンド風に引数をいろいろと渡して起動できるので、
runjava.jarを起動して常駐させておく。

上記のjava.soを起動するところは、build.mkにそれっぽいものが定義されている。

build.mk ::

  arch = x64
  # cmdline = java.so -jar /java/cli.jar
  # cmdline = java.so -jar /java/web.jar -cp java/cli.jar app
  cmdline = java.so -jar /usr/mgmt/web-1.0.0.jar app prod
  #cmdline = testrunner.so
  #cmdline = java.so Hello <-- これはJavaVMを起動して、起動するClassとしてtest/hello.javaを指定しているだけ。

build.mk内には、python scriptでmkbootfs.pyを叩くらしい。

python ::

  bootfs.bin: scripts/mkbootfs.py bootfs.manifest $(tests) $(tools) \
    tests/testrunner.so java/java.so java/runjava.jar \
    zpool.so zfs.so
  $(call quiet, $(src)/scripts/mkbootfs.py -o $@ -d $@.d -m $(src)/bootfs.manifest \
    -D jdkbase=$(jdkbase) -D gccbase=$(gccbase) -D \
    glibcbase=$(glibcbase) -D miscbase=$(miscbase), MKBOOTFS $@)


上記からわかることとして、
OSvとJavaVM間で相互に連携する場合は、
javaの起動時に 自作のjarファイルやagentlibを渡して、
callbackすればよい。


javaディレクトリの構成
================================================================================

# cli      //java cli.jar
# cloudius //java cloudius.jar
# java.cc  //java.so
# jni      //jni.so cloudiusがloadするjnilibを定義している。
# runjava  //runjava.jar  独自定義のclassloader
# sshd     //java sshd.jar


java/java.soは、bootfs.manifestファイルに記述されている。

user.manifest には、
jvm.soやらjava/* ディレクトリ以下のJNiのシンボルが登録されている。
jni系のライブラリは、cloudius.jarがloadされた際に、jniのシンボルが解決される必要がある。
なぜusr.manifestに定義されているのかは謎。


JavaからOSvを呼び出す場合、何か特殊なところはあるか。
================================================================================
JNIで解決。

build.mk ::

  jni = java/jni/balloon.so java/jni/elf-loader.so java/jni/networking.so \
        java/jni/stty.so java/jni/tracepoint.so java/jni/power.so


jniはusr.manifestに記述されており、build.mkではloader.imgとしてbuildされるらしい。

jniはすべてJNIExport
jniの関数は、libjniをloadするクラスが読み込まれた際に解決されないといけない。

JNIをloadするJavaのクラスは、java/cloudiusで定義されている。
そのため、jni/tracepoint.soに対応した、TracePoint.javaがペアで定義されている。
JNIの中では、OSvの生のリソースをそのまま弄くれるはず。

上記Javaのクラスはcloudius.jarにコンパイルされるはず。
JNI系は、jniXX.soとしてビルドされ、.so系のlibraryのsearch pathに追加されるはず。

elf-loader
================================================================================
javaのcloudius apiにExecが定義されており、JNI経由でexecが実行できる。
JNIから指定した, Cloudius_Exec_runっていうメソッドが叩かれ、
指定したpathのlibをloadelfで呼び出して、execでmain関数を叩く。

RunJava
********************************************************************************
java/java.ccでは、-DでclasspathにOsvSystemClassLoaderの配置場所を指定している。
OsvSystemClassLoaderはRunJavaで定義されている。

runjava.jarでは、
# sandbox interfaceの定義。run()
# classloaderの自作 //public class OsvSystemClassLoader extends ClassLoader
# ClassLoaderで読み込んだClassのmainを叩く。


::

  // 起動時のオプションは下記に制限されている。
  return starts_with(arg, "-verbose") ||
  starts_with(arg, "-D") ||
  starts_with(arg, "-X") ||
  starts_with(arg, "-javaagent") ||
  starts_with(arg, "-agentlib");

  osvClassLoader.run(appClassLoader,
    new SandBoxedProcess() {
    @Override
    public void run() throws Throwable {
      updateClassPathProperty(classpath);
      runMain(loadClass(mainClass), args);
    }
                                                                                                                                                        });
今のところは
OsvSystemClassLoaderがただ一つなのか、それともSandboxProcessごとに複数作れるのかは不明。

SandboxProcess.runを実装したクラスを作ればhello worldできるんですか。？？

helloworld自体は、osv起動時にHello.classを与えてJavaVMの起動時の引数として渡しているだけ。
osv起動後に指定するためには、SandboxProcess.runを継承したクラスをRunJavaに食わせれば起動できそうな気がする。

上記ユーザ定義クラスは、どのpathに置けばClassLoaderから参照できるのかは要調査かも
runjava.jarを読み込む際の、-Dオプションでclass等を指定できるはず。




tests/bench
********************************************************************************

純粋なjavaのクラスで、mainから起動する。
ベンチマークには、3つ登録されている。

NanoTimeBench()
  iterationをひたすら繰り替えして System.nanoTime()の精度を参照している。 
  System.nanoTime()の精度を参照している。 System.nanoTime()の精度を参照している。 System.nanoTime()の精度を参照している。

ContextSwitchBench()
  JavaのThreadを2つ立てて、ひたすらwait notifyでcontextswitchの性能を測定してる。

SieveBench // Sieve of Eratosthenes - a memory thrashing benchmark
  配列を順番にそうさしてprimを探す奴。
  配列のシーケンシャルアクセス

JVMはSystemCallが頻繁に呼ばないようになっているし、
特定のライブラリ依存の処理が排除されている。
そのため、可能な限りJavaのAPIで解決しているので、osvに移してapiレベルの処理が
うれしいことはなさそう。
最適化の機会は広がるだろうけど。。

todo
ベンチマークの結果を探そう。。


HotspotのOS抽象レイヤとOS固有のレイヤ
********************************************************************************

OS抽象レイヤは、大部分下記で定義されている。
hotspot/src/share/vm/runtime/os.cpp os.hpp

OS固有のレイヤは、大部分下記で定義されている。
/home/elise/project/osv/hotspot/src/os/linux/vm/os_linux.cpp os_linux.hpp

OS固有のレイヤがどんなヘッダファイルを要求するのかというとこんな感じ

os_linux.cpp ::

  // put OS-includes here
  # include <sys/types.h>
  # include <sys/mman.h>
  # include <sys/stat.h>
  # include <sys/select.h>
  # include <pthread.h>
  # include <signal.h>
  # include <errno.h>
  # include <dlfcn.h>
  # include <stdio.h>
  # include <unistd.h>
  # include <sys/resource.h>
  # include <pthread.h>
  # include <sys/stat.h>
  # include <sys/time.h>
  # include <sys/times.h>
  # include <sys/utsname.h>
  # include <sys/socket.h>
  # include <sys/wait.h>
  # include <pwd.h>
  # include <poll.h>
  # include <semaphore.h>
  # include <fcntl.h>
  # include <string.h>
  # include <syscall.h>
  # include <sys/sysinfo.h>
  # include <gnu/libc-version.h>
  # include <sys/ipc.h>
  # include <sys/shm.h>
  # include <link.h>
  # include <stdint.h>
  # include <inttypes.h>
  # include <sys/ioctl.h>

System.nanoTimeってどうなってるの
================================================================================

hotspot ::

  //opto/library_call.cpp
  case vmIntrinsics::_nanoTime:
      return inline_native_time_funcs(true);

  const char * funcName = isNano ? "nanoTime" : "currentTimeMillis";
  const TypeFunc *tf = OptoRuntime::current_time_millis_Type();
  Node* time = make_runtime_call(RC_LEAF, tf, funcAddr, funcName, no_memory_effects);

  //os/linux/vm/os_linux.cpp
  os::javaTimeNanos()
    if (Linux::supports_monotonic_clock())
      int status = Linux::clock_gettime(CLOCK_MONOTONIC, &tp);
    else
      int status = gettimeofday(&time, NULL);

  static bool supports_monotonic_clock() {
    return _clock_gettime != NULL;
  }


  clock_init()
    int (*clock_getres_func)(clockid_t, struct timespec*) =
      (int(*)(clockid_t, struct timespec*))dlsym(handle, "clock_getres");
    int (*clock_gettime_func)(clockid_t, struct timespec*) =
      (int(*)(clockid_t, struct timespec*))dlsym(handle, "clock_gettime");


  //clock_gettimeを探す。
  //osv/glibcに定義されてる
  //たぶんこれが呼ばれるはず。
  int clock_gettime(clockid_t clk_id, struct timespec* ts)
  {
    if (clk_id != CLOCK_REALTIME) {
      return libc_error(EINVAL);
    }
    u64 time = clock::get()->time();
    auto sec = time / 1000000000;
    auto nsec = time % 1000000000;
    ts->tv_sec = sec;
    ts->tv_nsec = nsec;
    return 0;
  }


performance
********************************************************************************
http://www.osv.io/devel-menu/benchmark

networkに依存するベンチでよいかも
memcacheのreq/secは40％改善

通常のspecjvm2008は平均1.7%改善。悪くなるのもいくつかあるらしい。

JVMから頻繁にOSのsystem callを呼び出すようなことはないため、JVMの性能はあまり向上しないのかも。

IOやNetworkをがりがり使うケースは性能向上するのかも。


その他
********************************************************************************

OSv上で動くJavaのプログラムの構築、デプロイ、運用等を考えた場合に、どうすればいいのか。。


Javaのプロセス自体を指定して、
プロファイルや運用ツール等をしようできないぽい。

もしやる場合、JVMがserverportを開いてlistenするタイプでならいろいろできるはず。
Javaのプログラムのリモートデバッグはできるはず。。

agent系のツールも、OSvの起動時のオプションに指定すれば使えそう。
agent系のツールは、RunJavaに別途オプション指定で起動できる見込み。

JVMのプロセス番号を指定して、プロファイル取ったりattacheするタイプは使用不可能なはず。



