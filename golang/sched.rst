scheduler
###############################################################################

参考
===============================================================================

https://gist.github.com/methane/5377227

https://docs.google.com/document/d/1TTj4T2JO42uD5ID9e89oa0sLKhJYD0Y_kqxDv3I3XMw/mobilebasic



構造体 ::

  typedef struct Sched Sched;
  struct Sched {
    Lock;
    uint64  goidgen;

    M*      midle;   // idle m's waiting for work
    int32   nmidle;  // number of idle m's waiting for work
    int32   nmidlelocked; // number of locked m's waiting for work
    int32   mcount;  // number of m's that have been created
    int32   maxmcount;      // maximum number of m's allowed (or die)

    P*      pidle;  // idle P's
    uint32  npidle;
    uint32  nmspinning;

    // Global runnable queue.
    G*      runqhead;
    G*      runqtail;
    int32   runqsize;

    // Global cache of dead G's.
    Lock    gflock;
    G*      gfree;
    uint32  gcwaiting;      // gc is waiting to run

    int32   stopwait;
    Note    stopnote;
    uint32  sysmonwait;
    Note    sysmonnote;
    uint64  lastpoll;

    int32   profilehz;      // cpu profiling rate
  };

他には、pkg/runtime/runtime.h
G P Mが定義されている。

work-stealing scheduler

M Machine Thread
P Processors execute
G Goroutine


work steal
===============================================================================

findrunnable ::

    // random steal from other P's
    for(i = 0; i < 2*runtime·gomaxprocs; i++) {
        if(runtime·sched.gcwaiting)
            goto top;
        p = runtime·allp[runtime·fastrand1()%runtime·gomaxprocs];
        if(p == m->p)
           gp = runqget(p);
        else
           gp = runqsteal(m->p, p);
        if(gp)
           return gp;
    }



struct
*******************************************************************************

struct G
===============================================================================

Goroutine ::
  struct  G
  {
      // stackguard0 can be set to StackPreempt as opposed to stackguard
      uintptr stackguard0;    // cannot move - also known to linker, libmach, runtime/cgo
      uintptr stackbase;      // cannot move - also known to libmach, runtime/cgo
      uint32  panicwrap;      // cannot move - also known to linker
      Defer*  defer;
      Panic*  panic;
      Gobuf   sched;
      uintptr syscallstack;   // if status==Gsyscall, syscallstack = stackbase to use during gc
      uintptr syscallsp;      // if status==Gsyscall, syscallsp = sched.sp to use during gc
      uintptr syscallpc;      // if status==Gsyscall, syscallpc = sched.pc to use during gc
      uintptr syscallguard;   // if status==Gsyscall, syscallguard = stackguard to use during gc
      uintptr stackguard;     // same as stackguard0, but not set to StackPreempt
      uintptr stack0;
      uintptr stacksize;
      void*   param;          // passed parameter on wakeup
      int16   status;
      int64   goid;
      int64   waitsince;      // approx time when the G become blocked
      int8*   waitreason;     // if status==Gwaiting
      G*      schedlink;
      bool    ispanic;
      bool    issystem;       // do not output in stack dump
      bool    isbackground;   // ignore in deadlock detector
      bool    preempt;        // preemption signal, duplicates stackguard0 = StackPreempt
      bool    paniconfault;   // panic (instead of crash) on unexpected fault address
      int8    raceignore;     // ignore race detection events
      M*      m;              // for debuggers, but offset not hard-coded
      M*      lockedm;
      int32   sig;
      int32   writenbuf;
      byte*   writebuf;
      uintptr sigcode0;
      uintptr sigcode1;
      uintptr sigpc;
      uintptr gopc;           // pc of go statement that created this goroutine
      uintptr racectx;
      uintptr end[];
    };

struct P
===============================================================================

Process ::

    struct P
    {
        Lock;

        int32   id;
        uint32  status;         // one of Pidle/Prunning/...
        P*      link;
        uint32  schedtick;      // incremented on every scheduler call
        uint32  syscalltick;    // incremented on every system call
        M*      m;              // back-link to associated M (nil if idle)
        MCache* mcache;
        Defer*  deferpool[5];   // pool of available Defer structs of different sizes (see panic.c)

        // Cache of goroutine ids, amortizes accesses to runtime·sched.goidgen.
        uint64  goidcache;
        uint64  goidcacheend;

        // Queue of runnable goroutines.
        uint32  runqhead;
        uint32  runqtail;
        G*      runq[256];

        // Available G's (status == Gdead)
        G*      gfree;
        int32   gfreecnt;

        byte    pad[64];
    };

struct M
===============================================================================

Machine ::

    struct  M
    {
        G*      g0;             // goroutine with scheduling stack
        void*   moreargp;       // argument pointer for more stack
        Gobuf   morebuf;        // gobuf arg to morestack
                                // Fields not known to debuggers.
        uint32  moreframesize;  // size arguments to morestack
        uint32  moreargsize;    // known by amd64 asm to follow moreframesize
        uintreg cret;           // return value from C
        uint64  procid;         // for debuggers, but offset not hard-coded
        G*      gsignal;        // signal-handling G
        uintptr tls[4];         // thread-local storage (for x86 extern register)
        void    (*mstartfn)(void);
        G*      curg;           // current running goroutine
        G*      caughtsig;      // goroutine running during fatal signal
        P*      p;              // attached P for executing Go code (nil if not executing Go code)
        P*      nextp;
        int32   id;
        int32   mallocing;
        int32   throwing;
        int32   gcing;
        int32   locks;
        int32   softfloat;
        int32   dying;
        int32   profilehz;
        int32   helpgc;
        bool    spinning;       // M is out of work and is actively looking for work
        bool    blocked;        // M is blocked on a Note
        uint32  fastrand;
        uint64  ncgocall;       // number of cgo calls in total
        int32   ncgo;           // number of cgo calls currently in progress
        CgoMal* cgomal;
        Note    park;
        M*      alllink;        // on allm
        M*      schedlink;
        uint32  machport;       // Return address for Mach IPC (OS X)
        MCache* mcache;
        int32   stackinuse;
        uint32  stackcachepos;
        uint32  stackcachecnt;
        void*   stackcache[StackCacheSize];
        G*      lockedg;
        uintptr createstack[32];// Stack that created this thread.
        uint32  freglo[16];     // D[i] lsb and F[i]
        uint32  freghi[16];     // D[i] msb and F[i+16]
        uint32  fflag;          // floating point compare flags
        uint32  locked;         // tracking for LockOSThread
        M*      nextwaitm;      // next M waiting for lock
        uintptr waitsema;       // semaphore for parking on locks
        uint32  waitsemacount;
        uint32  waitsemalock;
        GCStats gcstats;
        bool    needextram;
        uint8   traceback;
        bool    (*waitunlockf)(G*, void*);
        void*   waitlock;
        uintptr forkstackguard;
    #ifdef GOOS_windows
        void*   thread;         // thread handle
        // these are here because they are too large to be on the stack
        // of low-level NOSPLIT functions.
        LibCall libcall;
        uintptr libcallpc;      // for cpu profiler
        uintptr libcallsp;
        G*      libcallg;
    #endif
    #ifdef GOOS_solaris
        int32*  perrno;         // pointer to TLS errno
        // these are here because they are too large to be on the stack
        // of low-level NOSPLIT functions.
        LibCall libcall;
          struct {
          int64   tv_sec;
          int64   tv_nsec;
        } ts;
        struct {
          uintptr v[6];
          } scratch;
        #endif
        #ifdef GOOS_plan9
        int8*   notesig;
        byte*   errstr;
        #endif
        uintptr end[];
    };



GOMAXPROCS
===============================================================================

The GOMAXPROCS variable limits the number of operating system threads that
can execute user-level Go code simultaneously. There is no limit to the number of threads
that can be blocked in system calls on behalf of Go code; those do not count against
the GOMAXPROCS limit. This package's GOMAXPROCS function queries and changes
the limit.

変数 MaxGomaxprocs

GoidCacheBatch = 16

int32 runtime.gomaxprocs

gomaxprocs
===============================================================================

int32 procs
runtime.allp = runtime..malloc((MaxGomaxprocs+1)
procresize(procs)

allpから追えばいいかもね。
extern  P** runtime·allp;

Pの構造体は上記の領域確保


Thread
===============================================================================

M worker thread, or machine.


runtime..main() ::

  runtime..lockOSThread()
    この中では、
    m->lockedg = g;
    g->lockedm = m;

  ...
  runtime..newproc1
  ...
  runtime..unlockOSThread()

Machineはどこだ。

external
===============================================================================

runtime.h external data ::

  G** runtime..allg
  uintptr runtime..allglen
  M* runtime..allm
  P** runtime..allp


allmの確保方法
===============================================================================

これは固定だったんじゃ

allmからはじまる片方向のlinkなのかも。alllinkに片方向。

mcommoninit(M) ::

  runtime..lock()
  runtime..mpreinit(mp)
  mp->alllink = runtime..allm;
  runtime..atomicstorep(&runtime..allm, mp)
  runtime..unlock()


runtime..schedinit(void) ::

  runtime..sched.maxmcount = 10000
  runtime..symtabinit()
  runtime..mallocinit()
  mcommoninit(m)

  runtime/malloc.goc::mallocinit()
    runtime..MHeap_Init
    m->mcache = runtime..allocmcache()

mってなんだ。。

runtime.h ::

  extern register G* g;
  extern register M* m;



allgの確保方法
===============================================================================

allgaddでつなげる。
要はgは固定でサイズが決まらないので、listなんだと思う。

allglenでサイズを調整している。基本的にはcap = 2 * allgcap;で伸長していく。




goroutine context switch
===============================================================================

1.2 release note

Pre-emption in the scheduler
In prior releases,
a goroutine that was looping forever could starve out other goroutines on the same thread,
a serious problem when GOMAXPROCS provided only one user thread.

In Go 1.2, this is partially addressed:
The scheduler is invoked occasionally upon entry to a function.
This means that any loop that includes a (non-inlined) function call can be pre-empted,
allowing other goroutines to run on the same thread.

http://qiita.com/umisama/items/93333ffe4d9fc7e4ba1f
===============================================================================

主に、以下の契機でスケジューラに制御がわたり、スイッチが起こされる
アンバッファなチャネルへの読み書き
システムコール呼び出し
メモリアロケーション
time.Sleep()が呼ばれる
runtime.Gosched()が呼ばれる

go build -gcflags -m test1.go

https://code.google.com/p/go/source/detail?r=575afd15c877

runtime: preempt goroutines for GC
The last patch for preemptive scheduler,
with this change stoptheworld issues preemption
requests every 100us.
Update issue 543.


go1.3
===============================================================================
===============================================================================






