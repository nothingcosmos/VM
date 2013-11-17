TODO
###############################################################################

読み進める前に、ARTの疑問点と予想の洗い出し


疑問点
*******************************************************************************

LLVM
===============================================================================
llvm-irに変換する際に何かやる？

>> dex->llvmあたりを読む必要あり。

llvm-irに変換する際の、object headerはどうするのか、gcやruntimeとの連携を事前埋め込み？

上記は全部独自のintrinsicsを定義して埋め込み？

>> intrinsicsとShadowFrameで解決するっぽい。そもそもDalvikってObjectHeaderどうなってるの。

>> 事前に大量のintrinsicsを埋め込んだ後に、GBCExpanderパスでput/get系はexpand

llvmの制御はどうやっている？

>> llvmとの連携は、全部intrinsicのみ あとはMDで制御。TBAAとか。

Runtime
===============================================================================

Runtimeの最小構成は?

各種連携はentry pointらしい。safe pointみたいなものか。

>> intrinsicsに対応した、呼び出し先の実装らしい。いつでも呼べるように考慮してるのかも。

Reflectionからmirrorに変わっているらしいが。

>> Reflectionっていう用語は完全にJava.langのみ。artのruntimeは全部mirrorに統一。

intrinsicの全定義がruntimeにあるか？

>> ない。GBCExpanderで大部分解決している。ある程度はentrypointで定義されていて、
compilerが生成したコードから、自由にruntimeを呼べるようになっている。

deoptimize

>> やるらしい。entrypointの中で、quickとportableの双方で定義されていた。まだ動いてないはず。
どこかにclassloader/mirrorからのトリガーがあるはずだが。

quick portableの連携

>> まだ何もない。

SeaIr
===============================================================================

sea_irの使い道は、なぞ

