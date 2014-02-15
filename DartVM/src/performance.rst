performance
###############################################################################

StartUp
===============================================================================

dart vm 新規にisolateをspawnしてメッセージ受信できるようになるまで10msくらいか。
10msでhot code replacement / hot loadingできそうだな。

Coreの読み込みは、
snapshot済みなら、100 micro sec
snapshotなしの場合、100 ms
1000倍違う。
dartのtime系のオプションで測定すればわかる。

snapshot済みの場合、file ioとscan済みのメモリの状態をsnapshotでバイナリにする
普通のcoreで 400kbyte
たぶんmakeの下のヘッダにuint8_t で出力していたはず。

IO
===============================================================================

1GBのファイルをdartのstream系のapiで全readすると、
ページキャッシュに乗っていれば1.4secくらい、
ページキャッシュをクリアすると20secくらい。2TBのHD。JavaのNIO2あたりと比較してみるか

GC
===============================================================================

newgenのgcが0.6～1 msで、oldgenはcapacityに比例するけど、
oldgenがnewgenと同じ16Mくらいのときで、12-14msくらいか。

MessagePassing
===============================================================================
Dart VMのmessage passingのレイテンシは100microsecondから50microsecondくらいか。
JVMとC#と同じ。ほんとにErlang/OTPは5microsecondで終わってんのか、、

連続で送信すると、メッセージが詰まる

MessageBoxは片方向
