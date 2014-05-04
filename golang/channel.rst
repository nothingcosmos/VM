cmd/gc
###############################################################################

make channel
*******************************************************************************

lex.c ::

  "make" OMAKE
  "<-" LCOMM

go.y ::

  expr LCOMM expr 
  OSEND $1 $3

  LCOMM uexpr
  ORECV $2 N

  OTCHAN
  Csend
  Crecv

go.h ::

  Crecv ORECV OSELRECV OSELRECV2
  Csend OSEND
  Cboth Crecv | Csend

  // Node ops
  OSEND // c <^ x
  ORECV // <- c
  OSELRECV  // case x = <-c
  OSELRECV2 // case x, ok = <-c:
  //n->op == OSELRCV
  こんな感じでopになってる。

select.c ::

  walkselect(Node * sel)

  case OSEND:
    ch = cheapexpr()
  case OSELRCV:
  case OSELRCV2:
    ch = cheapexpr()

  case OSELRECV:
  case OSELRECV2:

  case OSEND:
    cheapexpr()
    mkcall1(chanfn("selectnbsend",
  case OSELRECV:
    nod()
    cheapexpr()
    mkcall1(chanfn("selectnbrecv",
  case OSELRECV2:
    nod()
    cheapexpr()
    mkcall1(chanfn("selectnbrecv2",

  case OSEND:
    mkcall1(chanfn("selectsend",


nodってなんだろ。。
基本的にはcheapexpr()を作った後に、
channel系のcallを作っている。
mkcallできるのは、おそらくruntimeでサポートされた組み込み関数のみのはず。

cheapexpr()
ってのはcopyexpr()　特に関係ない。

builtin.c
これが組み込み関数一覧
あとは
runtime.go ::

  // *byte is really *runtime.Type
  func makechan(chanType *byte, hint int64) (hchan chan any)
  func chanrecv1(chanType *byte, hchan <-chan any) (elem any)
  func chanrecv2(chanType *byte, hchan <-chan any) (elem any, received bool)
  func chansend1(chanType *byte, hchan chan<- any, elem any)
  func closechan(hchan any)

  func selectnbsend(chanType *byte, hchan chan<- any, elem any) bool
  func selectnbrecv(chanType *byte, elem *any, hchan <-chan any) bool
  func selectnbrecv2(chanType *byte, elem *any, received *bool, hchan <-chan any) bool

  func newselect(size int32) (sel *byte)
  func selectsend(sel *byte, hchan chan<- any, elem *any) (selected bool)
  func selectrecv(sel *byte, hchan <-chan any, elem *any) (selected bool)
  func selectrecv2(sel *byte, hchan <-chan any, elem *any, received *bool) (selected bool)
  func selectdefault(sel *byte) (selected bool)
  func selectgo(sel *byte)

go/src/pkg/runtime
===============================================================================

全体的にruntimeとreflectで双方用意しているのか。

gocって拡張子はなんだろ。

chan.c ::

  makechanは
  reflect.makechan
    makechan_c
  runtime.makechan
    makechan_c
      // allocate memory in one call
      c = (Hchan*)runtime·mallocgc(sizeof(*c) + hint*elem->size, (uintptr)t | TypeInfo_Chan, 0);
      c->elemsize = elem->size;
      c->elemalg = elem->alg;
      c->dataqsiz = hint;

chansend/chanrecv
===============================================================================

共通の構造体 Hchan ::

  // The garbage collector is assuming that Hchan can only contain pointers into the stack
  // and cannot contain pointers into the heap.
  struct  Hchan
  {
    uintgo  qcount;                 // total data in the q
    uintgo  dataqsiz;               // size of the circular q
    uint16  elemsize;
    uint16  pad;                    // ensures proper alignment of the buffer that follows Hcha
    bool    closed;
    Alg*    elemalg;                // interface for element type
    uintgo  sendx;                  // send index
    uintgo  recvx;                  // receive index
    WaitQ   recvq;                  // list of recv waiters
    WaitQ   sendq;                  // list of send waiters
    Lock;
  };

//SudoG mysg ::

  struct  SudoG
  {
    G*      g;              // g and selgen constitute
    uint32  selgen;         // a weak pointer to g
    SudoG*  link;
    int64   releasetime;
    byte*   elem;           // data element
  };

dequeue(WaitQ * q)
sgp = q->first;
q->first = sgp->link;

selgenをcasする。

selgen = NOSELGEN

chan.c ::

  chansend(Hchan * c) ::

    runtime.lock(c)
    if(c->closed)
      goto closed;
    if(c->dataqsiz > 0)
      goto asynch;
    sg = dequeue(&c->recvq)
      sg->elemalg->copy()
      runtime.ready(gp)
      return
    runtime.unlock(c)
    enqueue()
    runtime.park(runtime.unlock,

    asynch:

  chanrecv(Hchan * c)

    runtime.lock(c)
    sg = dequeue(&c->recvq)
      sg->elemalg->copy()
      runtime.ready(gp)
      return
    runtime.unlock(c)
    enqueue()
    runtime.park(runtime.unlock,

    asynch:

lockはchannel単位か。
enque/dequeの前後のみ。



park
===============================================================================

proc.c ::

  // Puts the current goroutine into a waiting state and unlocks the lock.
  // The goroutine can be made runnable again by calling runtime·ready(gp).
  void
  runtime·park(void(*unlockf)(Lock*), Lock *lock, int8 *reason)
  {
    m->waitlock = lock;
    m->waitunlockf = unlockf;
    g->waitreason = reason;
    runtime·mcall(park0);
      execute(gp)
        gogo(&gp->sched)
        //gotoはasm
          gobuf_sp()で退避
          gobuf_pc(BX)
          JMP BX
          //jumpするのか
  }





===============================================================================
===============================================================================
===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

