# Elm Platform

A bundle of all [Elm](http://elm-lang.org) tools:
[`elm`](https://github.com/elm-lang/Elm),
[`elm-server`](https://github.com/elm-lang/elm-server),
[`elm-repl`](https://github.com/elm-lang/elm-repl),
[`elm-get`](https://github.com/elm-lang/elm-get),
and `elm-doc`.

## Install

If you have any trouble installing at all, open an issue on this repo and then
continue to the Platform Agnostic instructions which work on any OS.

**Windows** &mdash; use [the installer][windows] and continue the [getting
started walkthrough for Windows](http://elm-lang.org/onboarding/Windows.elm).
If you run into issues compiling programs, you may need to manually set your `ELM_HOME`
environment variable to `C:/Program Files/Elm Platform/0.12.1/share` as reported
[here](https://github.com/elm-lang/elm-platform/issues/2).

 [windows]: http://0726e2be3f48a1ed0f90-ec3c2a753a12d2be9f23ba16873acc23.r35.cf2.rackcdn.com/Elm-Platform-0.12.1.exe

**Mac** &mdash; use [the installer][mac] and continue the [getting
started walkthrough for Mac](http://elm-lang.org/onboarding/Mac.elm).

 [mac]: http://0726e2be3f48a1ed0f90-ec3c2a753a12d2be9f23ba16873acc23.r35.cf2.rackcdn.com/Elm-Platform-0.12.1.pkg

**Arch Linux** &mdash; follow [these directions](https://github.com/elm-lang/Elm/wiki/Installing-Elm#arch-linux) and then
jump to the [My First Project](#my-first-project) section.

**Platform Agnostic** &mdash;
download the [Haskell Platform](http://hackage.haskell.org/platform/)
then run these commands:

```bash
cabal update
cabal install elm
cabal install elm-server   # Highly-Recommended
cabal install elm-repl     # Optional
cabal install elm-get      # Optional
```

Again, all this should work on any platform, from Windows to Ubuntu.

## Use

This installs five command line tools:
[`elm`](https://github.com/elm-lang/Elm),
[`elm-server`](https://github.com/elm-lang/elm-server),
[`elm-repl`](https://github.com/elm-lang/elm-repl),
[`elm-get`](https://github.com/elm-lang/elm-get),
and `elm-doc`. To be able to call them from the command line,
you may need to add them to your PATH.

## My First Project

Now we will create a simple Elm project.
The following commands will set-up a very basic project and start the Elm server.

    mkdir helloElm
    cd helloElm
    printf "import Mouse\n\nmain = lift asText Mouse.position" > Main.elm
    elm-server

The first two commands create a new directory and navigate into it. The `printf`
commands place a simple program into `Main.elm`. Do this manually if you do not
have `printf`. The final command starts the Elm server at
[localhost:8000](http://localhost:8000/), allowing you to navigate to
`Main.elm` and see your first program in action.

#### Final Notes

If you are stuck, check to see if anyone has had [a similar
issue](https://github.com/elm-lang/elm-platform/issues). If not,
open a new issue or email
[the list](https://groups.google.com/forum/?fromgroups#!forum/elm-discuss)
or ask a question in the
[#Elm IRC channel](http://webchat.freenode.net/?channels=elm). 
