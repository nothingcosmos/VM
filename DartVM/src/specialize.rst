
特殊化

案1 IC smi double
  optimizeの際に、ICから取得した型だけ参照するのはよろしくないのかもしれない。

  メソッドをコピるか
  呼び出しをどんどんクローンしていくか？
  T型のクラスごとに、クローンだけしてメソッドをよびわけるか
  よびわけてクローンするだけで、ICの型の履歴は1つに定まるはず

案2 obj作った際の実行時に行う。
  Allocate Object  TypeArgumentsの引数の型を取得する。
  その際に、型をつかって、クラス単位で特殊化する。???

案3 


Materialize命令は、定数の初期化をlazyに扱うためにあるのか？

==== file:///home/elise/language/dart/work/basic/sp.dart_Gen_getRec
 0: [graph]
    {
      v0 <- parameter(0)
      v1 <- parameter(1)
    }  env={ v0, v1, #null }
 1: [target]
   CheckStackOverflow:0() env={ v0, v1, #null }
   v2 <- Materialize:1(#null) env={ v0, v1, #null }
   PushArgument v0 env={ v0, v1, #null, v1, v0 }
   v3 <- InstanceCall:5(get:init, v0) IC[1: Gen] env={ v0, v1, #null, v1, t-1 }
   Branch:7 if v1 > v3 goto (2, 3) IC[=2: Smi, Smi | Double, Double] env={ v0, v1, #null, v1, v3 }
 2: [target]
   PushArgument v1 env={ v0, v1, #null, v1 }
   PushArgument v0 env={ v0, v1, #null, t-1, v0 }
   PushArgument v1 env={ v0, v1, #null, t-1, t-1, v1 }
   PushArgument v0 env={ v0, v1, #null, t-1, t-1, t-1, v0 }
   v6 <- InstanceCall:12(get:init, v0) IC[1: Gen] env={ v0, v1, #null, t-1, t-1, t-1, t-1 }
   PushArgument v6 env={ v0, v1, #null, t-1, t-1, t-1, v6 }
   v7 <- InstanceCall:13(-, v1, v6) IC[=2: Smi, Smi | Double, Double] env={ v0, v1, #null, t-1, t-1, t-1, t-1 }
   PushArgument v7 env={ v0, v1, #null, t-1, t-1, v7 }
   v8 <- InstanceCall:14(getRec, v0, v7) IC[1: Gen] env={ v0, v1, #null, t-1, t-1, t-1 }
   PushArgument v8 env={ v0, v1, #null, t-1, v8 }
   v9 <- InstanceCall:15(* , v1, v8) IC[=2: Smi, Smi | Double, Double] env={ v0, v1, #null, t-1, t-1 }
   goto 4 env={ v0, v1, v9 }
 3: [target]
   PushArgument v0 env={ v0, v1, #null, v0 }
   v4 <- InstanceCall:18(get:init, v0) IC[1: Gen] env={ v0, v1, #null, t-1 }
   goto 4 env={ v0, v1, v4 }
 4: [join]
   v5 <- phi(v4, v9)
   Return:21 v5 env={ v0, v1, v5, v5 }

呼び出し箇所
  v37 <- InstanceCall:55(%, v35, v36) IC[1: Double, Double] env={ v18, v1, v1, v4, v4, v9, v9, v14, v14, v19, v29, v21, v22, v23, t-1, t-1, t-1 }
  PushArgument v37 env={ v18, v1, v1, v4, v4, v9, v9, v14, v14, v19, v29, v21, v22, v23, t-1, v37 }
  v38 <- InstanceCall:56(getRec, v4, v37) IC[1: NoGen] env={ v18, v1, v1, v4, v4, v9, v9, v14, v14, v19, v29, v21, v22, v23, t-1, t-1 }

