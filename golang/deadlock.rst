DeadLockDetector
###############################################################################


all goroutines are asleep - deadlock! 

これが出る。


src/pkg/runtime
===============================================================================

メッセージはproc.c

checkdead() runtime..throw

//これはどういう意味だろう。
// -1 for sysmon
run = runtime..sched.mcount - runtime..sched.nmidle - runtime..sched.nmidlelocked - 1
// Mからnmiddleとnmiddlelockedとsysmonを引いたった。

// If we are dying because of a signal caught on an already idle thread,
// freezetheworld will cause all running threads to block.
// And runtime will essentially enter into deadlock state,
// except that there is a thread that will call runtime·exit soon.

if run > 0 continue
if run < 0 panic
なので下記にくるのはrunが0の場合。

runtime..lock() で全gを止める。中身をiterate
forEach runtime..allglen
  gp = runtime..allg[i]
  if gp->isbackground continue
  if gp state == Gwaiting grunning++
  else if s == Grunnable || s == Grunning || s == Gsyscall
    runtimeのcheckdeadに問題ありそう。
runtime..unlock()

その後強制でdeadlock宣言するのはなんだろうね。。



そもそもrun==0の段階でdeadlock
===============================================================================



===============================================================================
===============================================================================
