
goのthread生成のタイミング

threadはruntimeとruntime/cgo周り

newm() {
  asmcall(_cgo_thread_start, xxx);
}


基本はこれかな。

呼び出し条件を見てみる

newm経由でthreadが呼び出されるパターンを洗い出す
すべてruntime/proc

startm -> newm

handoffp -> startm

wakep -> startm

injectglist -> startm

結構制限なくstartmを呼び出すのかな？
