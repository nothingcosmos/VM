memory
###############################################################################

channel and goroutine
qsize = 100

10,000
Sys=4102 kb,TotalAlloc=211 kb,HSys=1024 kb, HAlloc=211 kb
Sys=15258 kb,TotalAlloc=10495 kb,HSys=11264 kb, HAlloc=10477 kb
Sys=98538 kb,TotalAlloc=13811 kb,HSys=14336 kb, HAlloc=13658 kb

100,000
Sys=4102 kb,TotalAlloc=211 kb,HSys=1024 kb, HAlloc=211 kb
Sys=117094 kb,TotalAlloc=102957 kb,HSys=103424 kb, HAlloc=102939 kb
Sys=957122 kb,TotalAlloc=135486 kb,HSys=135168 kb, HAlloc=133856 kb

qsize = 1
10,000
Sys=4102 kb,TotalAlloc=211 kb,HSys=1024 kb, HAlloc=211 kb
Sys=5190 kb,TotalAlloc=1261 kb,HSys=2048 kb, HAlloc=1243 kb
Sys=88585 kb,TotalAlloc=4568 kb,HSys=5120 kb, HAlloc=4387 kb

100,000
Sys=4102 kb,TotalAlloc=210 kb,HSys=1024 kb, HAlloc=209 kb
Sys=16282 kb,TotalAlloc=10635 kb,HSys=11264 kb, HAlloc=10618 kb
Sys=854954 kb,TotalAlloc=43157 kb,HSys=43008 kb, HAlloc=41598 kb
chan 12M, heap10M, chan120byte
g 840M, 8.4kByte

200,000
Sys=4102 kb,TotalAlloc=211 kb,HSys=1024 kb, HAlloc=211 kb
Sys=29078 kb,TotalAlloc=21052 kb,HSys=22080 kb, HAlloc=21034 kb
Sys=1706710 kb,TotalAlloc=86091 kb,HSys=84544 kb, HAlloc=83146 kb

golang 1chanが120byte程度、1goroutineが8.4kbyte程度か、goroutineは8kbyteのstackとすると、goroutineの管理領域は400byte程度か。これならメモリさえ用意すれば100万ノードのシミュレーションも難しくないかも。。

全員へのbroadcastは、
10,000で、3ms
100,000で47msくらい。
200,000で96msくらい。


//go1.3
WARN: 2014/04/24 08:19:11 main.go:189: Sys=3974 kb,TotalAlloc=118 kb,HSys=1024 kb, HAlloc=118 kb
WARN: 2014/04/24 08:19:11 main.go:189: Sys=24854 kb,TotalAlloc=18377 kb,HSys=19456 kb, HAlloc=18362 kb
WARN: 2014/04/24 08:19:11 main.go:189: Sys=54510 kb,TotalAlloc=46252 kb,HSys=47104 kb, HAlloc=46232 kb



###############################################################################

*******************************************************************************
*******************************************************************************

===============================================================================
===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

