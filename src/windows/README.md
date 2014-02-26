# Building Windows installer

You need to have Elm installed with the help of the [Haskell platform](https://github.com/evancz/Elm/blob/master/README.md#install). You also need `elm-get` and `elm-server` to be installed.

You will also need the [NSIS installer](http://nsis.sourceforge.net/Download) to be installed.

Once everything is installed, run this command:

    make_installer.cmd

It will build an installer called ElmPlatform-<version>-setup.exe.
