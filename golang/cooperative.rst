cooperative scheduler
###############################################################################

http://morsmachine.dk/go-scheduler
*******************************************************************************

なぜuserspace schedulerが必要か、
OSはThreadsをスケジュールできるのになぜ？

Threadsの問題
===============================================================================
POSIX thread APIは、Unix process modelを論理的に拡張したもので、
threadsはprocessと同じコントロールを得る

独自のsignal mask
CPU affinityの割り当て、cgroupへの追加、resourceの参照

上記の機能はgoroutineの使い方では不要
また、100,000 threadsが動く場合、それらのcontrolにoverheadが発生する。


OSの問題
===============================================================================
以下ができない
informed scheduling decisions
(双方向にcallbackできるような機能？

GO GCはすべてのThreadsを停止させる。
なぜなら、メモリが一貫性のある状態に到達しないといけない、
そのためには全Threadsが停止ポイントに到達するのを待つ。

3Model
===============================================================================

(1) N:1 model

コンテキストスイッチに非常に迅速

マルチコアシステムの利点をとることができない。

(2) 1:1 model

マルチコアシステムの利点をとれる。
OSを通じてtrapが必要。
コンテキストの切り替えが遅い。

(3) N:M model

両方の利点をとるぜ
OSのスレッドが任意数のGoroutineを受け持ちつつ、迅速なコンテキストスイッチを実現する。
でもスケジューラを追加するのが複雑になる。


M Machine
OS Thread 1つに対応

P Process
schedulingのためのcontext
単一スレッドで、P自体はN:1を担当し、
MでM:N Schedulerに対応

G Goroutine
Goroutineに対応
スタック、命令ポインタなどの情報を持つ。

上記のような対応であるため、
GOMAXPROCSでコンテキストの数を指定できるとあるが、
GOMAXPROCSは、M==P==1で、Mを増やすのか、
Mは論理CPUで自動できまって、Pの個数を指定するのか。



M:N Scheduler
===============================================================================

Gが複数あって、Gをschedulingするのはどういう仕組みでやるか。
P間でGを融通してload balanceみたいなことできるのかな。
work steel


goroutine runqueues

global contextを管理する、Syscall M0が存在する？

M0-G0
syscall用に用意

最低減で、GOMAXPROCSが1であっても、
system call用のthreadを生成する。


work steal
===============================================================================

global実行キューから取得できるかも



TODO
===============================================================================

Gが複数あって、Gをschedulingするのはどういう仕組みでやるか。
P間でGをwork steelしてload balanceみたいなことできるのかな。

GCのためのチェックポイントの制約がゆるくなっており、
GもしくはPで制御するだけでよくなった。


https://docs.google.com/document/d/1TTj4T2JO42uD5ID9e89oa0sLKhJYD0Y_kqxDv3I3XMw/edit
*******************************************************************************

旧実装の問題
===============================================================================

並行プログラムのスケーラビリティに制限があった

Vtoccにおいて、14%がruntime.futex()に取られていた。

single global mutex(Sched.Lock)

G hand-off

M must be

Design
===============================================================================

P Processorの追加

work-stealing scheduler

http://supertech.csail.mit.edu/papers/steal.pdf

M P G

de-centralized



struct P

gfree
ghead
gtail


P * allp; //[GOMAXPROCS] //Pが操作できるのか。

P * idlep; //lock-free list


syscallとの制御や連携はどうなるのか。

1. Introduce the P struct (empty for now); implement allp/idlep containers (idlep is mutex-protected for starters); associate a P with M running Go code. Global mutex and atomic state is still preserved.
2. Move G freelist to P.
3. Move mcache to P.
4. Move stackalloc to P.
5. Move ncgocall/gcstats to P.
6. Decentralize run queue, implement work-stealing. Eliminate G hand off. Still under global mutex.
7. Remove global mutex, implement distributed termination detection, LockOSThread.
8. Implement spinning instead of prompt blocking/unblocking.
The plan may turn out to not work, there are a lot of unexplored details.

実装の工夫
===============================================================================
Potential Further Improvements
1. Try out LIFO scheduling, this will improve locality.
   However, it still must provide some degree of fairness and gracefully handle yielding goroutines.
2. Do not allocate G and stack until the goroutine first runs.
   For a newly created goroutine we need just callerpc,
   fn, narg, nret and args, that is, about 6 words.
   This will allow to create a lot of running-to-completion goroutines
   with significantly lower memory overhead.
4. Better locality of G-to-P.
   Try to enqueue an unblocked G to a P on which it was last running.
5. Better locality of P-to-M.
   Try to execute P on the same M it was last running.
6. Throttling of M creation.
   The scheduler can be easily forced to create thousands of M's per second until OS refuses
   to create more threads. M’s must be created promptly up to k*GOMAXPROCS,
   after that new M’s may added by a timer.


わざのばより抜粋
===============================================================================

2) Preemption

Go 1.2より前では、
GOMAXPROCSをデフォルトにタイトなループを実行するとgoroutineがCPUを占有してしまうことがあったが、
ガベージコレクタにおいてもそれなりに影響があった。

ガベージコレクタはまず、全てのgoroutineがスケジューラに戻ってくるのを待つが、
CPUをかなり使っているgoroutineがあれば、このプロセスに時間がかかる可能性がある。
その解決策として、ガベージコレクタがgoroutineの実行を早く止められるように、
ファンクションのエントリの前にチェックが置かれるようになった。
この機能の詳細と制限事項についてはGo 1.2 のリリースノートを参照。


===============================================================================
===============================================================================

===============================================================================
===============================================================================
