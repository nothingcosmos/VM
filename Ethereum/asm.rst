
EVM
#######

https://github.com/comaeio/porosity/wiki/Ethereum-Internals

core/vm
instructions.go

accountは以下を管理していることを前提とする
balance, nonce, codeHash(contract専用), storageRoot

以下の領域が存在する

code //readonly
stack
memory
storage //永続化対象, 256bit=32byte単位のkvs
calldata
returndata

stackは256bit単位, 最大で1024 element

memory
#########

0x00 〜 0x3f: スクラッチ領域。storageに定義された配列の要素の先頭アドレスを求める時とかに使われる。直ぐ消えてもいいデータを扱う領域。
0x40 〜 0x5f: フリーメモリのポインタ。この領域に格納されたアドレス以降が未使用のメモリ領域。メモリをアロケートする場合はここの値が増えていく。
0x60 〜 0x7f: 常に０で、dynamic memory arrayの初期化に使われるらしい。この領域を参照しているopcodeは見たことないので具体的にどういう時に使われるのかはよくわからない。
0x80 〜 : これ以降は全てフリーメモリ。

storage opcode
##########
https://y-nakajo.hatenablog.com/entry/2018/06/03/165658

stack
PUSH01〜PUSH32: 次に続く1〜32byteのデータをstackの先頭に積みます
DUP1〜DUP16: stack上の1〜16番目の値をコピーしてstackの先頭に積みます
POP: stackの先頭のデータを取り除きます
SWAP1〜SWAP16: stack上の2〜17番目のデータと先頭のデータを入れ替えます。
ADD, SUB, MOD, MUL, EXP, ADDMOD, MULMOD: 四則演算系のopcode

memory //memory修飾子, 3gas
MSTORE(p, v); pを先頭アドレスとしてp+32の32byte領域にvの値を格納します。
MSTOREB(p, v); pの位置にv & 0xffの1byteデータを格納します。
MLOAD(p): pを先頭アドレスしてp+32までの32byteの値をロードしてstackの先頭に積みます。

storage //永続化
SSTORE(p, v): storageのpの位置に32byteのv値を格納します。
SLOAD(p): storageのpの位置から32byteの値をロードしstackの先頭に積みます。

calldata //functionの引数を格納するための領域
calldatasize: calldataに格納されたデータサイズをstackの先頭に積みます。
calldataload(p): calldataのpの位置からp+32の位置までの32byteのデータをstackの先頭に積みます。
calldatacopy(t, f, s): calldata領域のfの位置からsで指定されたサイズ(s bytes)のデータをmemory tの位置にコピーします。つまり、メモリのt〜t+sまでの間にコピーします。

returndata //他のContractの関数を呼び出したときの返却データの格納先
returndatasize: returndataに格納されているデータのサイズをstackの先頭に積みます。
returndatacopy(t, f, s): returndata領域のfの位置からsで指定されたサイズ(s bytes)のデータをmemory tの位置にコピーします。つまり、メモリのt〜t+sまでの間にコピーします。

storage gas
###############
Ethereumではstorageにデータを格納する場合、32byteごとにgas代がかかります。
20000gas //初回strage書き込み
21000gas //transaction gas

zero -> non zero: (NEW VALUE) cost 20000gas
non zero -> zero: (DELETE) refund 15000gas、 cost 5000gas
non zero -> non zero: (CHANge) cost 5000gas
read 200gas

memory read/write 3gas

truffle　opmizeすると32byteに押し込むらしい。

ABI
####################



