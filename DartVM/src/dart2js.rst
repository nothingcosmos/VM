src
###############################################################################

dart/sdk/lib/_internal/compiler/implementation

speed up
===============================================================================

r20305 | ngeoffray@google.com | 2013-03-21 17:48:04 +0900 (木, 21  3月 2013) | 2 lines

New CL for https://codereview.chromium.org/12770009/, but this time treat intercepted calls uniformly.
The regression we had was because a call on an interceptor was not optimized anymore.
Review URL: https://codereview.chromium.org//12951006



r19838 | kasperl@google.com | 2013-03-12 14:59:39 +0900 (火, 12  3月 2013) | 57 lines

Get rid of old code for union/intersection in HType.

Introduce the concept of an empty type mask and use it to represent
both truly non-nullable empty masks (conflicting) and nullable
empty masks (null).

Here are the differences (old ==> new) between the output of the union
and intersection operations when running all our tests:


R=ngeoffray@google.com
Review URL: https://codereview.chromium.org//12764005

RichardとDeltaBlueが大幅にスコア上方したけど、Tracerで減少したパッチ。
===============================================================================
25272 - 25253
revertしていないので、bugだったっぽい。


Tracerの大幅上昇
===============================================================================

https://code.google.com/p/dart/source/detail?r=27427

simple_types_inferrer から、 type_graph_inferrerへ切り替えた。
dart/sdk/lib/_internal/compiler/implementation/types/type_graph_inferrer.dart


type_graph_inferrerの詳細
===============================================================================

1.3k

class TypeInformation

class parameterAssignment extends IterableBase<TypeInformation>

class ElementTypeInformation extends TypeInformation

class CallSiteTypeInformation extends TypeInformation

class DynamicCallSiteTypeInformation extends CallSiteTypeInformation

class ConcreteTypeInformation extends TypeInformation

class NarrowTypeInformation extends TypeInformation

class ContainerTypeInformation extends ConcreteTypeInformation

class ElementInContainerTypeInformation extends TypeInformation

class PhiElementTypeInformation extends TypeInformation

class TypeInformationSystem extends TypeSystem<TypeInformation>

class WorkQueue

class TypeGraphInferrerEngine
    extends InferrerEngine<TypeInformation, TypeInformationSystem>

class TypeGraphInferrer implements TypesInferrer


types.dart ::

  /**
   * Common super class for our type inferrers.
  */
  abstract class TypesInferrer {
    void analyzeMain(Element element);
    TypeMask getReturnTypeOfElement(Element element);
    TypeMask getTypeOfElement(Element element);
    TypeMask getTypeOfNode(Element owner, Node node);
    TypeMask getTypeOfSelector(Selector selector);
    Iterable<TypeMask> get containerTypes;
    void clear();
    Iterable<Element> getCallersOf(Element element);
  }

TypeInferrerの使い方
===============================================================================

analyzeMain()

getGuaranteedTypeOfElement() -> TypeMask
getGuaranteedReturnTypeOfElement() -> TypeMask
getGuaranteedTypeOfNode() -> TypeMask
getGuaranteedTypeOfSelector() -> TypeMask


callgraph
===============================================================================

この辺が肝かも
runOverAllElements()

  sortResolvedElements().forEach((Element element) {
    SimpleTypeInferrerVisitor
    if (elm.isField) {
      if (isFinal() || isConst()) {
      } else if (asSendSet() == null) {
        //static field
      } else {
        recordTypeOfNonFinalField()
      }
    } else {
      recordReturnType()
    }
  });

  buildWorkQueue()  //all
  refineOptimistic()//queue walking
  buildWorkQueue()  //
  refine()

recordTypeOfNonFinalField()

fieldへの推論が悩ましい



まとめ
===============================================================================
dart2jsのtype inferrer は関数内だけじゃなく、手続き間にclassのfield sensitiveな型推論行うぽい。
queueで制限時間内に型の候補の集合Sのrefineを繰り替えして収束させていく。
call graph作ったあとに、手続き間でassignやuserを登録して、TypeInformationのグラフを作ると。TypeInformationを継承するクラスは6-7種で、Nodeに相当する。
Concrete types Elements Call sites Narrowing instructions Phi instructions Containers (for lists) Type of the element in a container





===============================================================================

===============================================================================


sdk/lib/_internal/compiler
dart --output-type=dart
--output-type=js



dart2js
bashなんだけどオプションを指定可能
--enable-diagnostic-colors
--library-root=
--heap_growth_rate=512
--checked












speed up tracer

r30108 | ngeoffray@google.com | 2013-11-08 21:15:57 +0900 (金, 08 11月 2013) | 5 lines

Simple per-block load elimination phase.

R=kasperl@google.com
Review URL: https://codereview.chromium.org//64573002


SsaLoadElimination



------------------------------------------------------------------------
r30100 | johnniwinther@google.com | 2013-11-08 16:18:17 +0900 (金, 08 11月 2013) | 6 lines

Don' show members of private libraries in documentation.

BUG=
R=ahe@google.com

Review URL: https://codereview.chromium.org//64613002
------------------------------------------------------------------------
r30048 | karlklose@google.com | 2013-11-07 23:24:30 +0900 (木, 07 11月 2013) | 5 lines

Optimize setting and getting type arguments for simple cases.

R=johnniwinther@google.com

Review URL: https://codereview.chromium.org//55873002
------------------------------------------------------------------------
r30047 | ngeoffray@google.com | 2013-11-07 23:12:59 +0900 (木, 07 11月 2013) | 5 lines

Use compile time constant handler to find the length of a fixed list.

R=kasperl@google.com

Review URL: https://codereview.chromium.org//61793004

