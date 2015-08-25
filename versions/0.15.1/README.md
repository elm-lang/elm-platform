# Building 0.15.1 from Source

### Get Haskell Set Up

The compiler and core tools are written in Haskell, so to build from source you need a Haskell compiler. This will be the hardest part of this process.

On some platforms the [Haskell Platform][hp] will work for you, but read the rest of this paragraph before making any moves. You need GHC to compile the code. Developers typically build with GHC 7.8 but as of 0.15.1 things should build with GHC 7.10 as well. You also need cabal 1.18 or higher. This will let you create a cabal sandbox which should make the build process much easier. Before getting Haskell Platform, make sure it is going to give you these things.

[hp]: http://hackage.haskell.org/platform/

> **Note:** Sometimes things go bad with cabal, so know that [you can always blow it all up](https://www.reddit.com/r/elm/comments/34np4m/how_to_uninstall_elm/). I sometimes do this after a fresh install of GHC and cabal to make sure there are no globaly installed packages that are going to make things suck for me later.


### Choose a Home

Find a folder on your machine where you want the Elm Platform to live. According to [people on the internet][folder], you probably want to choose `/opt` or `/usr/local`.

[folder]: http://unix.stackexchange.com/questions/20600/should-i-put-application-into-usr-local-or-usr-local-share

Whatever you choose, we will call the absolute path to this folder `<ROOT>` from now on. Whenever you see `<ROOT>` replace the whole thing with the absolute path you chose!


### Add Elm to your PATH

You need to [add the following entry to your `PATH`][path].

[path]: http://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path

```
<ROOT>/elm-platform/versions/0.15.1/.cabal-sandbox/bin
```

Where `<ROOT>` is expanded to `/usr/local` or whatever you chose.

It is crucial we set this up *before* building anything because we need to use `elm-make` in the build process. 

You can test that it has been added to your path with `echo $PATH`. If it is not there, you can open a fresh terminal session and try again. Be sure this works before moving on.


### Build Everything

In `<ROOT>` run the following commands:

```bash
git clone https://github.com/elm-lang/elm-platform.git
cd elm-platform/versions/0.15.1
bash build.sh
```

> **Note:** we are using [this bash file][bash] to set everything up. If you do not have `bash` for some reason, you can just run the commands in that file by hand.

[bash]: build.sh

This will kick off the entire build process. It will take a bit of time. When it is done, you should be all set to start using Elm locally!

At this point, you probably want to start going through [the architecture tutorial][arch] to see how to set up Elm projects locally.

[arch]: https://github.com/evancz/elm-architecture-tutorial/
