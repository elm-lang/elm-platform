## Elm REPL [![Build Status](https://travis-ci.org/elm-lang/elm-repl.svg?branch=master)](https://travis-ci.org/elm-lang/elm-repl)

This tool lets you interact with values and functions directly.

### Install

Install [Elm Platform][platform] to get `elm-repl`. Then make sure you have
[node.js](https://nodejs.org/en/download/) installed because it is needed to
evaluate the generated JS.

[platform]: https://github.com/elm-lang/elm-platform#elm-platform

### Use

You can type in expressions, definitions, union types, and module imports
using normal Elm syntax. 

```elm
> 1 + 1
2 : number

> "hello" ++ "world"
"helloworld" : String
```

The same can be done with definitions and union types:

```elm
> fortyTwo = 42
42 : number

> f n = n + 1
<function> : number -> number

> f 41
42 : number

> factorial n = \
|   if n < 1 then 1 \
|            else n * factorial (n-1)
<function> : number -> number

> factorial 5   
120 : number

> type Either a b = Left a | Right b

> case Left 32 of \
|   Left n -> 2 * n \
|   Right m -> m + 1
64 : number
```

You can import standard libraries and any library
reachable from the directory where `elm-repl` is running:

```elm
> import String

> String.length "hello"
5 : Int

> String.reverse "flow"
"wolf" : String
```

You can import *your* modules too, so if you create a module named `MyThing` in
your project, you can say `import MyThing` in the REPL and get access to all the
values it exposes.
