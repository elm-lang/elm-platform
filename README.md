# Elm Platform

A bundle of all [Elm](http://elm-lang.org) tools, usable through the `elm` executable.

This bundles together a bunch of projects that make it nice to use Elm: [`elm-compiler`][compiler], [`elm-make`][make], [`elm-reactor`][reactor], [`elm-repl`][repl], and [`elm-package`][package].

[compiler]: https://github.com/elm-lang/elm-compiler
[make]: https://github.com/elm-lang/elm-make
[reactor]: https://github.com/elm-lang/elm-reactor
[repl]: https://github.com/elm-lang/elm-repl
[package]: https://github.com/elm-lang/elm-package


## Use it

Ideally you can follow [these directions](http://elm-lang.org/Install.elm) and use one of the many installers for Elm that can get you up in running in minutes.

## Build from Packages

The following instructions should work on any platform, from Windows to Ubuntu. It requires getting the Haskell compiler, but you can uninstall that after you have the executables you need.

If you have never used Haskell, first download the [Haskell Platform][hp].

[hp]: http://hackage.haskell.org/platform/

Once that is done, run the following commands:

```bash
cabal update
cabal install cabal-install
cabal install -j elm-compiler-0.15 elm-package-0.5 elm-make-0.1.2
cabal install -j elm-repl-0.4.1 elm-reactor-0.3.1
```

This will take some time, but when it is done, all of these executables should be on your PATH. If not, then they should be in `~/.cabal/bin` which you can [add to your PATH][add-path].

[add-path]: http://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path

## Build from Source

Again this should work on any platform and needs the Haskell compiler.

Make sure you have cabal 1.18 or higher, which will let you create a cabal sandbox.

Use [this install script][script] to clone the necessary repos, configure them so you can work on them, and build them in the right order.

[script]: https://github.com/elm-lang/elm-platform/blob/master/installers/BuildFromSource.hs
