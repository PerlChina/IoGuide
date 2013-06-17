# Io 语言简介（1）

作者：perlvim@gmail.com 2013/6/17
版权: 不经同意，也可随意转载

## Io 语言学习的意义


Io 语言借鉴了 SmallTalk 的消息机制，Self 的原型模型，NewtonScript 的多重继承，Act1 语言的并发原理，Lisp 的运行时动态语法和 Lua 的小巧，可嵌入性。

学习 Io 可让你无限接近 Lisp 的设计理念。而且不需要那么多括号。

Io 语言是一种完全的原型语言，另外还有 Javascript, Lua 都是基于原型的语言。

如果你想了解解释器的原理，或者想自己制作一个解释器的话，学习 Io 将
让你事半功倍。因为 Io 语言内置的可定制的词法分析器和动态扩展语法，
让你有可能用极少的代码，构建一门语言的解释器，并获得可观的性能。因为
在并发领域，Io 的算法模型甚至比 C 更快。

Io 精致小巧的设计和无以伦比的领域特定语言(DSL)能力，将帮助你在许多领域成为
语言解析方面的专家。

## Hello world

和许多编程入门书一样，从打印一个简单的 "hello world" 开始吧

  "hello world!" print

## 运行环境

  for windows: 
  http://iobin.suspended-chord.info/win32/iobin-win32-current.zip

  for linux x86:
  http://iobin.suspended-chord.info/linux/iobin-linux-x86-rpm-current.zip

  for linux x64
  http://iobin.suspended-chord.info/linux/iobin-linux-x64-rpm-current.zip

## Io 的基本语法

### 注释
Io 的注释同 PHP 的很像：

 # This is comment of Io
 "hello world" print

 // This is comment of Io
 "hello world" print

 /* this is comment */
 "hello world" print // This is comment
 /* 
    this is comment
 */


### 语句

Io 的语句是以分号或回车结束

 "print hello" print; "print thanks" print;
 "print hello" print
 "print thanks" print

### 赋值

初始化一个变量并进行赋值，是用 ":=", 改写一个已经存在的变量，才可以用 "=".

  var := "string"
  var = "other string"

字符串字面量必须用双引号来进行标记，单引号是无效的。如果内容中有双引号，
就要进行转义：

  var := "this is \"string\"!"


### 对象

在 Io 中，所有的数据都是对象，包括字符串和数字。type 方法可以获取对象的类型

  Io> "string" type 
  --> Sequence

在 Io 中，字符串字面量的数据类型是 Sequence, 这和其他语言不同，Io 中
出现的方法名，变量名等标识符，都是一种 Sequence, 叫做 Symbol，这个和 Ruby 
中的 Symbol 很像，这个类型是不可变的，也就是说没有什么方法能修改这个数据，
除非用一个副本来保存计算结果。

从另外一个方面也说明，所有类似字符串形式的变量，在 Io 内部都是以字符序列
的方式保存的。

Io 中的 String 类型是一种不可变的字符序列

   Io> String type
   --> ImmutableSequence

   Io> 13 type
   --> Number

Lobby 是 Io 的主命名空间，相当于Java 的 main 包。命名空间也是 Object.

   Io> Lobby type
   --> Object

许多类型的 type 就是它自己，也就是顶级对象，
不能继续寻根溯源(内部进行了封装)：

   Io> true type
   --> true

   Io> false type
   --> false

   Io> Sequence type
   --> Sequence

   Io> Number type
   --> Number

类似的类型还有 Range, Vector, nil, System, List, Block, Map, Return
Object, Path, File, WeakLink, Message,...

### Io 的表达式组成

Io 的表达式是一个对象开始的，然后后面串联了一些消息（Message), 消息的
作用类似于面向对象语言中的方法，但中间是以空格连接的。括号用来表示优先级。
括号内部的表达式被当成一个独立的表达式进行计算。

  Io> if(1 > 2) then("It is impossible" print) else("It is ok" print)
  Io> method("hello world" print)

Io 的语法极其简单，就好象 Lisp 一样，几乎所有的抽象都是用类似函数的
结构完成的。Io 称为 Block, method(..) 结构最接近方法的抽象，也是一种
Block. Block 和 method 的区别和 Ruby 中的 Lamda 和 方法的区别差不多，
Block 有自己的独立的参数，而 method 隐含的从调用的对象中继承对象自己。

### 数据结构

#### 列表 List

Io 所有的数据结构都是从 List 开始的。

  Io> array := List(1, "thanks", "Lobby", 0xff)

新建一个列表：

   a := List clone
   a = list(33, "a")

也可以用下面的语法，直接赋值:

   a := list(33, "a")

添加一个元素：

   a append("b")
   ---> list(33, a, b)

获取列表的大小：

   a size
   ---> 3

#### 散列 Map

Map 就好象 Perl/Ruby 中的散列：

  Io> map := Map clone
  Io> map atPut("key1", "value1")
  Io> map atPut("key2", "value2")
  Io> map keys
  --> list(key2, key1)

Io 中的 Map 是没有顺序的，插入数据的顺序不会被保存。初始化 Map 没有语法糖。
只能先 clone 一个对象后，用 atPut 的方法来添加键值对。

其他的数据结构还有，Sequence 

### 文件读取

文件读取的方法有：openForAppending, openForReading, openForUpdating.

  f := File with("foo.txt")
  f remove
  f openForUpdating
  f write("hello world!")
  f close

第一部分完
