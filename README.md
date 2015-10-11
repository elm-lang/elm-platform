# Elm Platform

A bundle of all [Elm](http://elm-lang.org) tools, usable through the `elm` executable.

This bundles together a bunch of projects that make it nice to use Elm: [`elm-compiler`][compiler], [`elm-make`][make], [`elm-reactor`][reactor], [`elm-repl`][repl], and [`elm-package`][package].

[compiler]: https://github.com/elm-lang/elm-compiler
[make]: https://github.com/elm-lang/elm-make
[reactor]: https://github.com/elm-lang/elm-reactor
[repl]: https://github.com/elm-lang/elm-repl
[package]: https://github.com/elm-lang/elm-package


## Build from Source

First, **if you are on Mac or Windows** just looking to use Elm, definitely use the installers linked [here](http://elm-lang.org/install). Do not put yourself through this process if you do not have to!

Second, **if you are on some linux OS** and just want to use Elm, use [the npm installer](https://www.npmjs.com/package/elm) and be very very attentive to the README there. You need to do that `ELM_HOME` stuff or you will be confused!

Finally, **if you have made it this far**, you are in some unique position where the other options do not cover you for some reason. You are about to actually build from source. **I recommend you read this whole section before you start running anything.**


#### Get Haskell Working

You will need Haskell to build this stuff. On some platforms the [Haskell Platform][hp] will work for you, but read the rest of this paragraph before making any moves. You need GHC to compile the code. Developers typically build with GHC 7.8 but as of 0.15.1 things should build with GHC 7.10 as well. You also need cabal 1.18 or higher. This will let you create a cabal sandbox which should make the build process much easier. Before getting Haskell Platform, [make sure it is going to give you these things](https://www.haskell.org/platform/contents.html).

[hp]: http://hackage.haskell.org/platform/

> **Note:** Sometimes things go bad with cabal, so know that [you can always blow it all up](https://www.reddit.com/r/elm/comments/34np4m/how_to_uninstall_elm/). I sometimes do this after a fresh install of GHC and cabal to make sure there are no globaly installed packages that are going to make things suck for me later.

At this point you should be in a world where your cabal version is greater than 1.18. It probably sucked getting here, so thank you for sticking with this!


#### Actually Build Elm Things

Find a directory on your machine where you want the Elm Platform to live. We will soon run [a script][script] that creates a directory called `Elm-Platform/0.15.1/*` and builds all the necessary things. You should not move `Elm-Platform/` after it is created, so choose carefully before progressing.

Now that you have chosen a home for `Elm-Platform/`, add the absolute path to `Elm-Platform/0.15.1/.cabal-sandbox/bin` to your `PATH` ([like this][add-path]). This is necessary to successfully build `elm-reactor` which relies on `elm-make`. This will also mean you can use `elm` commands from anywhere!

Okay, now run these commands:

[script]: https://github.com/elm-lang/elm-platform/blob/master/installers/BuildFromSource.hs
[add-path]: http://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path

```bash
# If you are on LINUX, you need to install a dependency of elm-repl.
# Uncomment the following line and run it.
# sudo apt-get install libtinfo-dev

# if you are on windows, or some other place without curl, just download this file manually
curl https://raw.githubusercontent.com/elm-lang/elm-platform/master/installers/BuildFromSource.hs > BuildFromSource.hs

runhaskell BuildFromSource.hs 0.15.1
```

> **Note:** You can use the `BuildFromSource.hs` script to build any version of the compiler, so you can run the following to build all the latest versions of things: `runhaskell BuildFromSource.hs master`. Be aware, this is where active development happens, so not everything will be working at all times! You will want to change your `PATH` to point to the right thing if you go down this road.

We have had reports that some people need to set the `ELM_HOME` variable manually to get the debugger working in elm-reactor. If you are having issues like this, you may need to set `ELM_HOME` to something like `Elm-Platform/0.15.1/.cabal-sandbox/x86_64-osx-ghc-7.8.3/elm-reactor-0.3.2/`. It won't be exactly that in your case probably, so go find the equivalent path for your OS and version of elm-reactor.
