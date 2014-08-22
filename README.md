# Elm Platform

A bundle of all [Elm](http://elm-lang.org) tools: [`elm`][elm],
[`elm-reactor`][elm-reactor], [`elm-repl`][elm-repl], and [`elm-get`][elm-get].

[elm]: https://github.com/elm-lang/Elm
[elm-reactor]: https://github.com/elm-lang/elm-reactor
[elm-repl]: https://github.com/elm-lang/elm-repl
[elm-get]: https://github.com/elm-lang/elm-get


## Getting Started

After installing, use [this starter project][examples] to get comfortable using
Elm and all of its tools.

[examples]: https://github.com/michaelbjames/elm-examples

Be sure to try out the time-traveling debugger with `elm-reactor`!


## Installers

If you have any trouble installing, open an issue on this repo and then
continue to the Platform Agnostic instructions which work on any OS.

**Mac** &mdash; Use the [Mac installer][mac]. Run [this script][uninstall] if you ever want to uninstall.

[mac]: https://www.dropbox.com/s/qfz9n90jszcxa5q/Elm-Platform-0.12.3.pkg
[uninstall]: https://github.com/elm-lang/elm-platform/blob/master/src/mac/helper-scripts/uninstall.sh

**Windows** &mdash; Use the [Windows installer][windows].

[windows]: https://www.dropbox.com/s/qzcm9yyve54ss1l/Elm-Platform-0.12.3.exe

**Arch Linux** &mdash; Follow [these directions](https://github.com/elm-lang/Elm/wiki/Installing-Elm#arch-linux).

Update to a newer version of Elm by just running the installer again. They link
to the latest versions, and they will safely overwrite old executables and paths
so your machine is in a consistent state.


## Platform Agnostic Install

The following should work on any platform, from Windows to Ubuntu:

 1. Download the [Haskell Platform][hp]. We will use this to build the Elm Platform.
 2. Create a directory called `Elm-Platform/0.13/` to place everything Elm Platform related. You need to keep this directory around, so put it somewhere out of the way like ???
 3. Run the following commands:

[hp]: http://hackage.haskell.org/platform/

        cabal sandbox init
        cabal update
        cabal install elm-platform-0.13

 4. Add the absolute path to `Elm-Platform/0.13/bin` to your PATH. This makes it so you can run `elm-repl` or `elm-reactor` from anywhere on your computer.

This approach makes it easy to have multiple versions of Elm Platform installed. It is okay to have `Elm-Platform/0.12.3`, `Elm-Platform/0.13`, and many others. It is up to you to manage your PATH or any symlinks though.


## Help

If you are stuck, check to see if anyone has had [a similar
issue](https://github.com/elm-lang/elm-platform/issues). If not,
open a new issue or email
[the list](https://groups.google.com/forum/?fromgroups#!forum/elm-discuss)
or ask a question in the
[#Elm IRC channel](http://webchat.freenode.net/?channels=elm). 
