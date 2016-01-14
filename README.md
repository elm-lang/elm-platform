# Elm Platform
The [Elm Platform](http://elm-lang.org) bundles together a bunch of tools that make it nicer to use Elm, including:

* [`elm-compiler`][compiler]
* [`elm-make`][make]
* [`elm-reactor`][reactor]
* [`elm-repl`][repl]
* [`elm-package`][package]

[compiler]: https://github.com/elm-lang/elm-compiler
[make]: https://github.com/elm-lang/elm-make
[reactor]: https://github.com/elm-lang/elm-reactor
[repl]: https://github.com/elm-lang/elm-repl
[package]: https://github.com/elm-lang/elm-package


## Building from Source vs Precompiled Installations
It is recommended that you do not build from source when possible. Should you decide to do so it is strongly suggested that you read through this document completely beforehand.

* ***Mac OSX & Windows***: Installers are available [here](http://elm-lang.org/install).
* ***Linux***: Installation via [npm](https://www.npmjs.com/package/elm).

#### Prerequisites
A few things are required prior to compiling elm:

* Haskell (On some platforms the [Haskell Platform](https://www.haskell.org/platform/) is sufficient)
* GHC (Elm versions older than 0.16 will build with GHC 7.8 but newer versions will only build with GHC 7.10)
* Cabal 1.18 or newer
* Build Script (Can be downloaded [here](https://raw.githubusercontent.com/elm-lang/elm-platform/master/installers/BuildFromSource.hs))

**Note:** In the event that you have problems during the build process, please see [here](https://www.reddit.com/r/elm/comments/34np4m/how_to_uninstall_elm/) for information on starting the process over.

Next, you'll need to decide where the Elm Platform installation directory is going to be and will need to add it to your ```PATH``` environment variable. Assuming you've selected ```~/Elm-Platform/``` as your target directory & you're wanting to install Elm 0.16:

```Bash
$ export PATH=$PATH:~/Elm-Platform/0.16/.cabal-sandbox/bin
```

Lastly, if you're building on Linux, you'll need to install libtinfo-dev (a dependency of ```elm-repl```). Assuming you're on a Debian-based distro:

```Bash
$ sudo apt-get install libtinfo-dev
```

#### Building Elm
Once all prerequisites have been met, simply run the build script:

```Bash
runhaskell BuildFromSource.hs 0.16
```

**Note:** You can use the `BuildFromSource.hs` script to build any version of the compiler, so you can run the following to build all the latest versions of things: `runhaskell BuildFromSource.hs master`. Be aware, this is where active development happens, so not everything will be working at all times! You will want to change your `PATH` to point to the right thing if you go down this road.

**Note:** We have had reports that some people need to set the `ELM_HOME` variable manually to get the debugger working in elm-reactor after building from source. If you are having issues like this, you may need to set `ELM_HOME` to something like `Elm-Platform/0.16/.cabal-sandbox/x86_64-osx-ghc-7.8.3/elm-reactor-0.3.2/`. It won't be exactly that in your case probably, so go find the equivalent path for your OS and version of elm-reactor.
