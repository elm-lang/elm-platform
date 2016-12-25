# Experimental build system

## Getting the latest version of stack

To install the Elm platform from source you will need the latest version of
[stack](https://github.com/commercialhaskell/stack) from Git. The easiest way
of accomplishing this is to first:

1. [Install stack](https://github.com/commercialhaskell/stack#how-to-install).
2. Run `stack upgrade --git`.
3. Ensure that the old version of stack is no longer on `$PATH`. Running `stack
   --version` can help you determine this.

## Installing Elm

1. Download the desired `stack.yaml` into an empty directory:

   ```
   curl https://raw.githubusercontent.com/elm-lang/elm-platform/master/versions/0.15.1/stack.yaml > stack.yaml
   ```

2. Run the following:

   ```
   stack install elm-compiler elm-package elm-make elm-repl && stack install elm-reactor
   ```

   This will install the Elm platform into `~/.local/bin` or its equivalent
   location on your OS.

3. Optionally delete the directory when done; stack does all its work in a
   subdirectory named `.stack-work`.

