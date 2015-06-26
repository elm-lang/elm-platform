# Elm Platform

A bundle of all [Elm](http://elm-lang.org) tools, usable through the `elm` executable.

This bundles together a bunch of projects that make it nice to use Elm: [`elm-compiler`][compiler], [`elm-make`][make], [`elm-reactor`][reactor], [`elm-repl`][repl], and [`elm-package`][package].

[compiler]: https://github.com/elm-lang/elm-compiler
[make]: https://github.com/elm-lang/elm-make
[reactor]: https://github.com/elm-lang/elm-reactor
[repl]: https://github.com/elm-lang/elm-repl
[package]: https://github.com/elm-lang/elm-package


## Build from Source

First, are you sure you can't use [the npm installer](https://www.npmjs.com/package/elm)?

How about the Mac or Windows installers linked [here](http://elm-lang.org/install)?

Okay... But I recommend you read this whole section before you start running anything.

You will need Haskell to build this stuff. On some platforms the [Haskell Platform][hp] will work for you, but read the rest of this paragraph before making any moves. You need GHC to compile the code. Developers typically build with GHC 7.8 but as of 0.15.1 things should build with GHC 7.10 as well. You also need cabal 1.18 or higher. This will let you create a cabal sandbox which should make the build process much easier. Before getting Haskell Platform, make sure it is going to give you these things.

[hp]: http://hackage.haskell.org/platform/

> **Note:** Sometimes things go bad with cabal, so know that [you can always blow it all up](https://www.reddit.com/r/elm/comments/34np4m/how_to_uninstall_elm/). I sometimes do this after a fresh install of GHC and cabal to make sure there are no globaly installed packages that are going to make things suck for me later.

At this point you should be in a world where your cabal version is greater than 1.18. It probably sucked getting here, so thank you for sticking with this! Now find a directory on your machine where you want the Elm Platform to live. The following commands will download [a script][script] that will create a directory called `Elm-Platform/0.15/*` and build all the necessary things. It is best if you do not have to move `Elm-Platform/` so choose carefully before running:

[script]: https://github.com/elm-lang/elm-platform/blob/master/installers/BuildFromSource.hs

```bash
# if you are on windows, or some other place without curl, just download this file manually
curl https://raw.githubusercontent.com/elm-lang/elm-platform/master/installers/BuildFromSource.hs > BuildFromSource.hs

runhaskell BuildFromSource.hs 0.15
```

> **Note:** You can use the `BuildFromSource.hs` script to build any version of the compiler, so you can run the following to build all the latest versions of things: `runhaskell BuildFromSource.hs master`. Be aware, this is where active development happens, so not everything will be working at all times!

Once you are done with all this stuff you may want to [add to your PATH][add-path] the absolute path to `Elm-Platform/0.15/bin`. This will make it so all the Elm command line tools are easily available.

[add-path]: http://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path

We have had reports that some people need to set the `ELM_HOME` variable manually to get the debugger working in elm-reactor. If you are having issues like this, you may need to set `ELM_HOME` to something like this `Elm-Platform/0.15/share/x86_64-osx-ghc-7.8.3/elm-reactor-0.3.1/`. It won't be exactly that in your case probably, so go find the equivalent path for your OS and version of elm-reactor.
