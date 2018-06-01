# elm-package

The package manager for Elm. The full catalog of community libraries
is located at [package.elm-lang.org](http://package.elm-lang.org/).


## Basic Usage

To install a library run:

```bash
elm-package install elm-lang/html         # Install latest version
elm-package install elm-lang/html 1.0.0   # Install version 1.0.0
```

`elm-package` is sandboxed by default, so the downloaded package will be placed
in your projects `elm-stuff/` directory. Sandboxing means it is easy for
different projects to have different dependencies.

Installing a package will also create a file called `elm-package.json` which
gives a structured overview of your project, including stuff like what license
you use, what packages you depend on, and which directories contain source
code. Take a look at this file and see if everything looks correct!


## Version Rules

Many people use version numbers in different ways, making it hard to give
reliable version bounds in your own package. With `elm-package` versions are
determined based on API changes. The rules are:

  * Versions all have exactly three parts: `MAJOR.MINOR.PATCH`

  * All packages start with initial version 1.0.0

  * Versions are incremented based on how the API changes:

      - `PATCH` - the API is the same, no risk of breaking code
      - `MINOR` - values have been added, existing values are unchanged
      - `MAJOR` - existing values have been changed or removed

  * `elm-package` will bump versions for you, automatically enforcing these rules

This means that if your package works with `elm-lang/html 1.0.0` it is very
likely to work with everything up until `2.0.0`. At that point, some breaking
change has occurred that might break your code. It is conceivable that things
break on a minor change if you are importing things unqualified and a newly
added value causes a name collision, but that is not extremely likely.


## Updating Dependencies

Say you know a new version of `elm-lang/core` has come out, but you are not
sure if you want to update. You can see how big of a change it is by running
the following command:

```bash
elm-package diff elm-lang/core 3.0.0 4.0.0
```

This will show you all of the changes from version `3.0.0` which you have and
version `4.0.0` which you would like to have. This gives you some real basis
for deciding if you should update right now.

If you like what you see, take the following steps.

  * Save a copy of `elm-stuff/exact-dependencies.json` so you can always come
    back to a working state.

  * Change your version bounds in `elm-package.json` to include the newest
    stuff.

  * Run `elm-package install elm-lang/core 4.0.0` and see how things go!


## Publishing Packages

This is a step by step discussion of how to make a nice package that will be
useful, easy to learn, and pleasant to use.


### Designing APIs

Before publishing, look through the [design guidelines][guidelines].
Some key takeaways are:

[guidelines]: http://package.elm-lang.org/help/design-guidelines

  * Design for a concrete use case
  * Always give functions human readable names
  * Avoid gratuitous abstraction


### Preparing for Publication

The information in `elm-package.json` determines what people will see when
they browse your package on [package.elm-lang.org](http://package.elm-lang.org/).
Here are some hints for filling in that information:

  * Keep the `summary` under 80 characters.

  * The recommended `license` is BSD3, but of course, you can use whatever
    license you want.

  * `exposed-modules` lets you expose some small set of modules. Use this to
    stop internal details from polluting your API and cluttering the docs with
    modules that are not meant for users.

You should also create a `README.md` for your project. It should explain the
use case of your library along with some examples to help people get situated
before deciding to use your library or diving into your documentation.

Finally, you should document all of the publicly exposed modules and functions
based on [this format][docs]. Examples are one of the most powerful ways to
learn new APIs so do not be lazy, make your users' lives easy!

[docs]: http://package.elm-lang.org/help/documentation-format


### Publishing for the First Time

When you have finished the API, tested everything, and written up docs, it is
time to share it with others!

All Elm packages start with version number `1.0.0` and then increase according
to automatically enforced rules. For now, all you need to know is that `1.0.0`
is where things start.

`elm-package` is currently backed by GitHub, so we use GitHub tags to refer to
specific version numbers. Add a version tag to your repo like this:

```bash
git tag -a 1.0.0 -m "initial release"
git push --tags
```

This will add a tag `1.0.0` which matches the version number you are
publishing. It also associates that tag with a message. You can make your
message more helpful than "initial release".

Once that is done, run the following command:

```bash
elm-package publish
```

This will send all the relevant information to the package catalog and verify
that everything is in order. You just published a package!


### Publishing Updates

Once you have published `1.0.0` you enter into the world of automatically
enforced versioning as described in the [version rules section](#version-rules).
`elm-package` provides a couple tools to make it easy to diff APIs and figure
out new version numbers.

First we have API diffing with the following commands:

```bash
elm-package diff        # diff current API with most recently published API
elm-package diff 1.0.0  # diff current API with version 1.0.0
```

Both of these will help you review your changes and make sure everything is
what you were expecting. From there, you can automatically bump your version
number by running this command:

```bash
elm-package bump
```

Based on the version number listed in your `elm-package.json` file, it will run
a diff and figure out the magnitude of the changes. It will then tell you your
new version number!

From here, everything is the same as publishing for the first time. Tag it on
GitHub and publish it.
