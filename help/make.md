# elm-make

`elm-make` is a build tool for Elm.

  * **Compile down to JS or HTML** &mdash; turn Elm files into artifacts that
    can be used with whatever backend you are already using.

  * **Build in parallel** &mdash; if you have four cores, `elm-make` will try to
    compile four files at all times.

  * **Build dependencies** &mdash; `elm-make` is designed to work with
    `elm-package` so if you use a bunch of 3rd party packages they will all
    work just fine.

  * **Build what you need** &mdash; if a module is not needed for your project it
    will not be built or appear in the resulting JS or HTML.


## Basic Usage

Your Elm projects should all have a root directory, like `project/` that all
of your Elm related stuff is going to live in. Lets imagine having the
following directory structure.

```
project/
    Main.elm
    SearchBox.elm
    SearchResults.elm
    Theme.elm
```

We have a couple Elm modules, maybe they depend on each other in some way. To
turn this into JavaScript, you can run the following command:

```bash
elm-make Main.elm --output=main.html
```

Before creating an HTML file called `main.html`, this will prompt you to
install `elm-lang/core` which contains all of the core modules needed to make
Elm programs work.

It will also create a file called `elm-package.json` which gives a structured
description of your project. `elm-make` uses this file to figure out what
directories it needs to look in and which packages are relevant.


## More Advanced Usage

A lot of the more advanced stuff involves fiddling with `elm-package.json` to
make your directory structure nicer or to make sure you are working with the
right dependencies.

### Directory Structure

In the Basic Usage section above, we saw a pretty boring directory structure.
As we actually used it, it would probably expand to look like this:

```
project/
    elm-package.json
    elm-stuff/...
    LICENSE
    Main.elm
    README.md
    SearchBox.elm
    SearchResults.elm
    Theme.elm
```

Pretty messy! There is a field in `elm-package.json` called `source-directories`
that allows you to list all the directories that contain Elm modules. By default
it only lists the root directory `.` but it is best to change that a bit. If you
are doing an Elm only project, this structure is pretty nice.

```
project/
    src/
        Main.elm
        SearchBox.elm
        SearchResults.elm
        Theme.elm
    elm-package.json
    LICENSE
    README.md
```

I would set `"source-directories": [ "src" ]` keeping the root of the project
as clean as possible.

If you have a project that has both frontend and backend components, I have
been experimenting with this directory structure.

```
project/
    backend/...
    frontend/
        Main.elm
        SearchBox.elm
        SearchResults.elm
        Theme.elm
    elm-package.json
    LICENSE
    README.md
```

In this world you set `"source-directories": [ "frontend" ]`. This pattern is
used for [the `package.elm-lang.org` project][src] and seems to work pretty
well.

[src]: https://github.com/elm-lang/package.elm-lang.org/

### Managing Dependencies

There are two general approaches to managing dependencies depending on what you
are trying to do. These rules may not apply in every case, but they are good
guidelines.

  1. If you are creating a package for others to use, you want to keep your
     dependency ranges as broad as possible. You also only want to extend
     ranges as far as you have tested. When you say "my library works with
     4.0.0 of this package" before that version has been released or before
     you have tested with it, you are likely to make life suck for your users.
     Do not do that!

  2. If you are creating an app or product, you want to keep your dependency
     ranges very specific. When you build, a file is generated called
     `elm-stuff/exact-dependencies.json` which lists all of the packages needed
     for your project and the exact versions you happen to be using right now.
     You may want to check this in to version control if you want the same
     exact thing every time.

If you are in camp #1 creating a package for others, we have plans to help
automate the process of expanding version bounds. If your project compiles
with the new stuff and your tests pass, it is conceivable that everything
just works. We will be experimenting with this!