# Elm Reactor

Interactive development tool that makes it easier to develop Elm
programs. Key features include:

  * Automatically compile any Elm program
  * Compatible with any editor

This means you can get a great development experience whether you are using
Sublime Text, Emacs, vim, or whatever else to edit Elm code.


## Install

Install [Elm Platform][platform]. This will install Elm Reactor and everything
else it needs.

[platform]: http://elm-lang.org/install


## Use

Navigate to the Elm project you want to work on. A great project to get started
with is [elm-architecture-tutorial][] which contains some simple programs that should be fun
to debug.

[elm-architecture-tutorial]: https://github.com/evancz/elm-architecture-tutorial

In the root of your Elm project start the reactor with:

```bash
elm-reactor
```

Now open [http://localhost:8000](http://localhost:8000) in your browser. You
should see a navigation page for your project.

Click on any file to see what it looks like. For example, you can navigate to an Elm file like `examples/1-button.elm` and try it out. If you modify the file, you can just refresh that page and see the new version!


### Note About Time Travel

In 2013, Laszlo Pandy figured out how to make a reliable [Time Traveling Debugger](http://debug.elm-lang.org/) for Elm. It became part of `elm-reactor` [in 2014](http://elm-lang.org/blog/time-travel-made-easy) thanks to Michael James who adapted it for how we *thought* people would work with it in practice. Since then (1) the internal implementation of Elm has changed a decent amount and (2) we have learned a lot about what production users need to use this tool seriously. So time travel is not available in `elm-reactor` right now, but it will be coming back with a new design focused on real workflows. I think this will lead us to a tool that is both more reliable and more broadly useful whether you are making games or web apps.

For now, the [`Debug`](http://package.elm-lang.org/packages/elm-lang/core/latest/Debug) module still makes it easy to peek at values in your program.
