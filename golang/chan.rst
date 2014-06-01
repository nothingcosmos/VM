GoCompiler and Channel
###############################################################################

goのchannelがどうなっているのか気になる。。

channelの実装がどうなっているのか調べる。

コンパイラを調べる
*******************************************************************************

"<-"みたいな特徴的なシンボルを手がかりに、探せばみつかりそう。。

src/cmd/gc
===============================================================================

コンパイラは src/cmd/gcの中

適当に"<-"でgrepしてみる。あとはmakeでchanを作るらしいので、makeを探す。

lex.c ::

  OMAKE, "make"
  LCOMM,  "<-"

lexなので、字句解析のシンボル。これを元に更にgrepする。

go.y ::

  expr LCOMM expr   //左辺のexprがchanのdst $1, 右辺がchanのsrc $3
  {
      $$ = nod(OSEND, $1, $3);  //OSENDっていうのでgrepすればいいか。
  }

  LCOMM uexpr       //ORECVでもgrepしてみる
  {
      $$ = nod(ORECV, $2, N);
  }

  LCHAN LCOMM ntype
  {
      $$ = nod(OTCHAN, $3, N);   //OTCHAN ???
      $$->etype = Csend;         //exprの型がCsend なのかな
  }

  recvchantype:
  LCOMM LCHAN ntype
  {
      $$ = nod(OTCHAN, $3, N);   //OTCHANってなんだろ
      $$->etype = Crecv;         //exprの型がCrecv なのかな
  }

.yって拡張子は、yacc bisonの拡張子、構文解析のルールになる。

構文解析でnodeを生成して、treeを構築することが多いので、etype Csend/Crecvや、ORECV/OSENDが怪しい。


go.h ::

  // Node ops.
  enum
  {
  ...
  OSEND // c <- x
  ORECV // <-c
  OSELRECV  // case x = <-c
  OSELRECV2 // case x, ok = <-c:

walk.c ::

  walkstmt(Node **np)
    switch(n->op) {
    case ORECV:
    case OSEND:
    ...
  こんな感じでNodeのopになってる。


  ...
  case OSEND:
  n = mkcall1(chanfn("chansend1", 2, n->left->type), T, init, 
  //すごく怪しい。。 chansend1ってなんだよ。。

runtime.go ::

  // *byte is really *runtime.Type
  func makechan(chanType *byte, hint int64) (hchan chan any)
  func chanrecv1(chanType *byte, hchan <-chan any, elem *any)
  func chanrecv2(chanType *byte, hchan <-chan any, elem *any) bool
  func chansend1(chanType *byte, hchan chan<- any, elem *any)
  func closechan(hchan any)

正に、そのものが出てきた。

でもsrc/cmd/gcの中に定義がない。。

広くgrepしてみると、pkg/runtimeの中に定義があるっぽい。

runtime.goなので、goの関数のシンボルに見える。

mkcall1()で、対応する"chansend1"への呼び出しを生成しているように見える。

chansend1は、runtimeで定義された組込み関数のように見える。

mkcall1()で組込関数への呼び出しを生成しているのかも。

mkcall1 ::

  n = mkcall1(chanfn("chansend1", 2, n->left->type), T, init, 
  ...
  Node*   mkcall1(Node *fn, Type *t, NodeList **init, ...);
    r = vmkcall(fn, t, init, va);
      nod(OCALL, fn, N);  //OCALLを作っている

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
  ...
  ...

runtime.goが、runtimeで定義された組込関数の一覧っぽい。

chan系を列挙すると上記

どうやって確認するか
===============================================================================

ASTをdumpできるといいんだけど

ダンプのオプション何かあるかな。

gcにオプション-S でアセンブリを出力できる。

fibo.go ::

  $ go build -gcflags -S

  func fibo(n int) int {
    if n < 2 {
      return n
    } else {
      return fibo(n-1) + fibo(n-2);
    }
  }

  func printfibo(ch chan int) {
    for {
      var ret = <- ch          //CALL    ,runtime.chanrecv1(SB)
      fmt.Printf("fobo(%d) = %d\n", ret, fibo(ret))
    }
  }

  func main() {
    var ch = make(chan int)    //CALL    ,runtime.makechan(SB)
    go printfibo(ch)           //CALL    ,runtime.newproc(SB)
    for i := 0; i < 41; i++ {
      ch <- i                  //CALL    ,runtime.chansend1(SB)
    }
  }

  chansend1のアセンブり

  00042  CALL    ,runtime.makechan(SB)
  00047  PCDATA  $0,$-1
  00047  MOVQ    16(SP),AX
  00052  MOVQ    AX,"".ch+40(SP)           //chanは"".ch+40(SP)
  ...

  00085  MOVQ    AX,"".i+24(SP)            //AXが変数i
  00090  MOVQ    AX,"".autotmp_0013+32(SP) //iをautotmp_0013+32(SP)に格納
  00095  MOVQ    $type.chan int+0(SB),(SP) //第1引数 type.chan intを格納
  00103  MOVQ    "".ch+40(SP),BX
  00108  MOVQ    BX,8(SP)                  //第2引数 chanを格納
  00113  LEAQ    "".autotmp_0013+32(SP),BX
  00118  MOVQ    BX,16(SP)                 //第3引数 iを格納
  00123  PCDATA  $0,$24
  00123  PCDATA  $1,$1
  00123  CALL    ,runtime.chansend1(SB)    //chansend1
  00128  PCDATA  $0,$-1
  00128  MOVQ    "".i+24(SP),AX
  00133  INCQ    ,AX
  00136  NOP     ,
  00136  CMPQ    AX,$41
  00140  JLT     $0,85

  //src/cmd/gc/runtime.goに組込み関数の定義がある。 
  func makechan(chanType *byte, hint int64) (hchan chan any)
  func chanrecv1(chanType *byte, hchan <-chan any) (elem any)
  func chansend1(chanType *byte, hchan chan<- any, elem any)

  newprocはsrc/cmd/gc/runtime.goに定義が存在しない。 
  src/pkg/runtime/runtime.h
  G*      runtime·newproc1(FuncVal*, byte*, int32, int32, void*);

独特の呼び出し規約にみえるが、Plan9由来だろうか。。

go runtime
*******************************************************************************

runtimeで定義された組込み関数の詳細を調べる。

go/src/pkg/runtime ::

  func makechan(chanType *byte, hint int64) (hchan chan any)
  func chanrecv1(chanType *byte, hchan <-chan any) (elem any)
  func chansend1(chanType *byte, hchan chan<- any, elem any)

  G*      runtime·newproc1(FuncVal*, byte*, int32, int32, void*);

組込み関数は、pkg/runtimeとpkg/reflectにそれぞれあるっぽい。本体はruntimeだと思うけど。

src/pkg/runtime/chan.goc
===============================================================================

chan系の組込み関数が定義されている。

gocって拡張子はなんだろ。 Cのソースだと思うけど。

makechan, chanrecv1, chansend1が定義されている。

gocファイルには、なぜかgoのソースとCのソースが混在している。

このファイルをPlan9のCコンパイラはコンパイルできるのだろうか。。
それともgocはコンパイルできるように改造されている？

chan.goc ::

  static Hchan*
  makechan(ChanType *t, int64 hint)
      // allocate memory in one call
      c = (Hchan*)runtime·mallocgc(sizeof(*c) + hint*elem->size, (uintptr)t | TypeInfo_Chan, 0);
      c->elemsize = elem->size;
      c->elemalg = elem->alg;
      c->dataqsiz = hint;  //ここがchanのqueueだと思う。


  //なぜか同じソースコードにgoとCのソースが混在している。
  func chansend1(t *ChanType, c *Hchan, elem *byte)
      chansend(t, c, elem, true, runtime·getcallerpc(&t)); //ここからC言語

  func chanrecv1(t *ChanType, c *Hchan, elem *byte)        //ここからC言語
      chanrecv(t, c, elem, true, nil);

ChanType chanの型っぽい

Hchan chanの実体っぽい

byte  chanで送信するデータっぽい

middle dot
===============================================================================

所々 ピリオドでない、 · というシンボルが埋まっている。

これはmiddle dotと呼ぶらしく、Plan9のCコンパイラはmiddle dotでnamespaceを分けることができるらしい。

middle dotは毎回コピーして使っているのだが、よい入力方法はないだろうか。。


chansend
===============================================================================

comment ::

  /*
   * generic single channel send/recv
   * if the bool pointer is nil,
   * then the full exchange will
   * occur. if pres is not nil,
   * then the protocol will not
   * sleep but return if it could
   * not complete.
   *
   * sleep can wake up with g->param == nil
   * when a channel involved in the sleep has
   * been closed.  it is easiest to loop and re-run
   * the operation; we'll see that it's now closed.
   */

chansend ::

  static bool
  chansend(ChanType *t, Hchan *c, byte *ep, bool block, void *pc)
    SudoG *sg;
    SudoG mysg;
    G* gp;
    int64 t0;

    mysg.releasetime = 0;

    runtime·lock(c);     //lockはchan単位
    if(c->closed)
        goto closed;
    if(c->dataqsiz > 0)  //chan bufferが0だったら、そのまま下に進む
        goto asynch;

    sg = dequeue(&c->recvq); // chanにはsendq/recvqがあって、
                             // sendの場合、まずrecvqを取得
                             // このqueueはchanにblockしているGのqueue

    if(sg != nil) {          // つまりchanの宛先でrecv blockして待っていたのを取得した、sg
        runtime·unlock(c);

        gp = sg->g;          //qのさすG pointerを取得
        gp->param = sg;
        if(sg->elem != nil)  //epは、chanで送付するelem  copy(size, dst, src)に注意
            c->elemtype->alg->copy(c->elemsize, sg->elem, ep); //send/recvでcopy先が逆
        if(sg->releasetime)
            sg->releasetime = runtime·cputicks();
        runtime·ready(gp);   //blockするGをrunnableにしてスルー
        return true;
    }

    if(!block) {
        runtime·unlock(c);
        return false;
    }

    //このパスは、chanの宛先がblock recvしていない場合
    mysg.elem = ep;
    mysg.g = g;
    mysg.selectdone = nil;     //mysgとしてsendの引数のep , 自分のg を設定
    g->param = nil;
    enqueue(&c->sendq, &mysg); //mysgをenqueue sendなので、sendqにmysgをpush
    runtime·parkunlock(c, "chan send"); //context switch 自分から譲る

    //戻ってくるポイントはここ。
    if(g->param == nil) {
        runtime·lock(c);
        if(!c->closed)
            runtime·throw("chansend: spurious wakeup");
        goto closed;
    }

    if(mysg.releasetime > 0) //releasetimeを確認し、Bucket *b = stkbucket() count++, += cycles
        runtime·blockevent(mysg.releasetime - t0, 2);

    return true;

  asynch:
    if(c->closed)
        goto closed;

    if(c->qcount >= c->dataqsiz) { //chanのqが一杯になっていた、if qcount <= chanのbufferを越えていた
        if(!block) {
            runtime·unlock(c);
            return false;
        }
        mysg.g = g;                //自分のgをmysgに設定して譲る
        mysg.elem = nil;
        mysg.selectdone = nil;
        enqueue(&c->sendq, &mysg); //mysgをenqueueする
        runtime·parkunlock(c, "chan send"); //gを譲る

        runtime·lock(c);
        goto asynch;               //再度asynchにloop
    }

    // copy  chanbuf <- ep  elemをbufferにcopyする。ここはepからsize分コピーする
    c->elemtype->alg->copy(c->elemsize, chanbuf(c, c->sendx), ep);
    if(++c->sendx == c->dataqsiz)
        c->sendx = 0;
    c->qcount++;

    sg = dequeue(&c->recvq);       //dequeue 繰り返し
    if(sg != nil) {                //chanのrecv先でblockしてる奴をactiveにする
        gp = sg->g;
        runtime·unlock(c);
        if(sg->releasetime)
            sg->releasetime = runtime·cputicks();
        runtime·ready(gp);         //blockしてるGをrunnableにしてスルー
    } else
        runtime·unlock(c);         //recvで待ってるGがいない場合、throughする。
    if(mysg.releasetime > 0)
        runtime·blockevent(mysg.releasetime - t0, 2);
    return true;

chansendにおいて

(1) chanのbufferが0だったら、

(1-1) chanのrecv先にblockするGがいた場合、そのcontextをdequeueして、
そのcontextのelemにsend対象のelemをcopyし、そいつをready()、自分はそのままreturn

(1-2) chanのrecv先にblockするGがいない場合、
自分のcontextをWaitQを作成し、chanのsendq側WaitQにenqueueして寝る。parkunlock()でContextSwitchする。

(2) chanのbufferが0より大きければ、

(2-1) bufferが一杯か確認し、bufferが一杯なら、自分のcontextをWaitQを作成し、
chanのsendq側WaitQにenqueueして寝るparkunlock()

(2-2) bufferが一杯でなければ、bufferにsend対象のelemをcopyして、
もしrecv先にblockするGがいる場合、そいつをready()して起こす。
自分はreturn


chanのsend/recvでは、elemをCopyしている。
そのため、可能であればでかい配列を直接送受信するよりも、
ポインタを送受信したほうがよいのかもしれない。

chanrecv
===============================================================================

基本的にはchansendと鏡のように同じ構造になっている。

WaitQのlistの参照先(sendq/recvq)だけが異なる。

あとは、bufferからCopyしたあと、空のnullを書き込む。

chanrecvにおいて

(1) chanのbufferが0だったら、

(1-1) chanのsendq先にblockするGがいた場合、そのcontextをdequeueして、
そのcontextのelemからrecv対象のelemにcopyし、そいつをready()、
自分は受信したelemを保持してreturnする。

(1-2) chanのrecv先にblockするGがいない場合、
自分のcontextをWaitQを作成し、chanのrecvq側WaitQにenqueueして寝る。parkunlock()でContextSwitchする。

(2) chanのbufferが0より大きければ、

(2-1) bufferが空か確認し、bufferが空なら、自分のcontextをWaitQを作成し、
chanのsendq側WaitQにenqueueして寝るparkunlock()

(2-2) bufferが空でなければ、自分のelemにbufferから溜まっている分をcopyして、
もしsendq先にblockするGがいる場合、そいつをready()して起こす。
自分はelemを持ってreturn


chanrecvは、bufferに溜まっているelemを即事回収してreturnするのが特徴かな。

chanの構造体
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

chan自体は、genericなメッセージを送受信できるように設計されており、

chanが送受信する型はコンパイル時にチェックするようだ。

送受信する型のサイズを、elemsizeに格納するのだと思う

送受信する実体は、以下のSudoGのbyte * elemが対応する。

SudoG mysg ::

  struct  SudoG
  {
    G*      g;              // g and selgen constitute
    uint32* selectdone;     // a weak pointer to g
    SudoG*  link;
    int64   releasetime;
    byte*   elem;           // data element
  };

SudoGは、誰(G)に何(byte*)を送受信するのかを管理している。

byte*だけでは、何が入っているのか分からないような気がするが、
byte*の実体のデータサイズは、Hchanのelemsizeが対応している。

chanは、複数の送信者と複数の受信者を想定するため、SudoGで対応付けている。

SudoGはdequeue/enqueueできるようになっている。

linked listになっていて、基本的にはfifo構造。

dequeue時にselectdoneをフラグとし、casするタイプのqueue

ready or parkunlock
===============================================================================

context switchの仕組み

parkunlockを寝る、readyを遷移すると表現したけど、実際はどうなのか。。

readyは、対象のGをrunnableに設定し、実行はscheduler任せにする。

parkunlockは、自分のGをwaitingに設定し、寝る。


proc.c ::

  // Puts the current goroutine into a waiting state and unlocks the lock.
  // The goroutine can be made runnable again by calling runtime·ready(gp).
  void
  runtime·parkunlock(Lock *lock, int8 *reason)
  {
          runtime·park(parkunlock, lock, reason);   //parkするけど、parkunlockをcallbackする
  }

  第1引数がlock, 第2引数はreason
  parkunlockの中で上記のparkを呼び出す。

  static bool
  parkunlock(G *gp, void *lock)    //unlock用のcallback
    USED(gp)
    runtime..unlock(lock)

  #define FLUSH(x) USED(x) //なぞだ

  // Puts the current goroutine into a waiting state and unlocks the lock.
  // The goroutine can be made runnable again by calling runtime·ready(gp).
  void
  runtime·park(void(*unlockf)(Lock*), Lock *lock, int8 *reason)
  {
    m->waitlock = lock;
    m->waitunlockf = unlockf;
    g->waitreason = reason;
    runtime·mcall(park0);   //mcallはアセンブラ
      //continuation on g0  //g0を特別に扱っている？
      park0(G *gp)
        if m->waitunlockf //このパスに入るはず
          ok = m->waitunlockf(gp, m->waitlock)
          gp->satus = Grunnable;
          execute(gp) //proc.c
            gp->status = Grunning
            gp->preempt = false;
            m->p->schedtick++;
            runtime..gogo(&gp->sched) //amd64.asm
              //gogoはasm
              gobuf_sp()で退避
              gobuf_pc(BX)
              JMP BX //jumpするのか
        schedule() //これはrunnable goroutineを探してcontinueする
          execute(gp);
  }

asm ::

  // void mcall(void (*fn)(G*))
  // Switch to m->g0's stack, call fn(g).
  // Fn must never return.  It should gogo(&g->sched)
  // to keep running g.

  callerのPC, SPをg_sched+gobuf_spなどに退避する。
  ...
  //switch to m->g0
  ...
  CALL DI //DIはmcallの引数。MOVQ fn+0(FP),-> DI


お次はreadyの中身か

proc.c ::

  Mark gp ready to run.
  void runtime..ready(G *gp)
    runqput(m->p, gp)  //putして後はよろしく。
    //atomicloadでidleがある、かつspinningしているようであれば、
      wakep() //起こす。
    //preemptのフラグ操作も入っている。


  // Tries to add one more P to execute G's.
  // Called when a G is made runnable (newproc, ready).
  wakep(void)
    startm(nil, true)


  // Try to put g on local runnable queue.
  // If it's full, put onto global queue.
  // Executed only by the owner P.
  static void
  runqput(P *p, G *gp)
    atomicにqueueに追加しようとする。だめなら何度かretry

readyの中は、runqputするだけ、どこで起きるんだろう

runqget
===============================================================================

名前的に対応してるのはこいつ。

findrunnable()およびschedule()から呼ばれる。

findrunnable()はschedule()からしか呼ばれない。

schedule()がfindrunnable()でrunnableなGをrunqから取得する。

runqの制御は、schedulerが独立してがんばっているのだと思う。

まとめ
===============================================================================

chanのsend/recvは、context switchの機会にはなるが、必ずしもswitchするわけではない。

sendでblockするのは、

(1) bufferが0の場合、recv側でblockするGがいないとき。
なぜならblockするGに書き込んで、即復帰できないため。

(2) bufferが0より大きい場合、bufferが満杯だったとき。
blockするGより、chanのbufferへ優先して書き込む。
そのためbufferが満杯でない場合は、そのままスルーするか、可能ならblockするGへ書き込んでready

recvでblockするのは、

(3) bufferが0の場合、send側でblockするGがいないとき。
なぜならblockするGから受信データをもらえないため。

(4) bufferが0より大きい場合、bufferが空だったとき。
bufferに1つでもelemが入っていれば、そのデータを受信して即returnできる。
