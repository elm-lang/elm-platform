# Elm Platform

A bundle of all [Elm](http://elm-lang.org) tools: [`elm`][elm],
[`elm-reactor`][elm-reactor], [`elm-repl`][elm-repl], and [`elm-package`][elm-package].

[elm]: https://github.com/elm-lang/Elm
[elm-reactor]: https://github.com/elm-lang/elm-reactor
[elm-repl]: https://github.com/elm-lang/elm-repl
[elm-package]: https://github.com/elm-lang/elm-package


## Getting Started

After installing, use [this starter project][examples] to get comfortable using
Elm and all of its tools.

[examples]: https://github.com/michaelbjames/elm-examples

Be sure to try out the time-traveling debugger with `elm-reactor`!


## Installers

Update to a newer version of Elm by just running the installer again. They link
to the latest versions, and they will safely overwrite old executables and paths
so your machine is in a consistent state.

If you have any trouble installing, open an issue on this repo and then
consider using the platform agnostic install path which works on any OS, but
will take a while longer.

#### Mac

Use the [Mac installer][mac]. Run [this script][uninstall] if you ever want to uninstall.

[mac]: http://install.elm-lang.org/Elm-Platform-0.14.pkg
[uninstall]: https://github.com/elm-lang/elm-platform/blob/master/src/mac/helper-scripts/uninstall.sh

#### Windows

Use the [Windows installer][windows].

[windows]: http://install.elm-lang.org/Elm-Platform-0.14.exe

#### Arch Linux

Follow [these directions](https://github.com/elm-lang/Elm/wiki/Installing-Elm#arch-linux).


## Platform Agnostic Install

The following instructions should work on any platform, from Windows to Ubuntu.
It builds the compiler from source in a relatively straight-forward way, but it
will still take some time to run.

 1. Download the [Haskell Platform][hp]. We will use this to build the Elm Platform.

 2. Choose a directory to build the Elm Platform. On Linux and Mac a good place
    is `/usr/local/`. On Windows a good place is `C:\Program Files\`. The rest
    of the instructions will assume you are using `/usr/local/` just to make
    things a bit simpler.

 3. In `/usr/local/` create a directory named `Elm-Platform/0.14/`

 4. Run the following commands from within `/usr/local/Elm-Platform/0.14/`

[hp]: http://hackage.haskell.org/platform/

        cabal sandbox init
        cabal update
        cabal install -j elm-compiler-0.14 elm-package-0.2 elm-make-0.1 elm-reactor-0.2 elm-repl-0.4

    This will take some time. Upon finishing successfull, it will place all of
    the executables you need in a directory called `bin/`.

 5. On Mac or Linux, add `/usr/local/Elm-Platform/0.14/bin` to your PATH. On
    Windows, add `C:\Program Files\Elm-Platform\0.14\bin` to your PATH. This
    makes it so you can run `elm-repl` or `elm-reactor` from anywhere on your
    computer.

This approach makes it easy to have multiple versions of Elm Platform
installed. It is okay to have `Elm-Platform/0.12.3`, `Elm-Platform/0.13`,
and many others. It is up to you to manage your PATH though.


## Help

If you are stuck, check to see if anyone has had [a similar
issue](https://github.com/elm-lang/elm-platform/issues). If not,
open a new issue or email
[the list](https://groups.google.com/forum/?fromgroups#!forum/elm-discuss)
or ask a question in the
[#Elm IRC channel](http://webchat.freenode.net/?channels=elm). 
