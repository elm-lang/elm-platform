#!/usr/bin/env bash

set -e

cabal update

cabal sandbox init

git clone https://github.com/elm-lang/elm-compiler.git
cd elm-compiler
git checkout tags/0.15.1 --quiet
cabal sandbox init --sandbox ../.cabal-sandbox
cp ../cabal.config .
cabal install -j
cd ..


git clone https://github.com/elm-lang/elm-package.git
cd elm-package
git checkout tags/0.5.1 --quiet
cabal sandbox init --sandbox ../.cabal-sandbox
cp ../cabal.config .
cabal install -j
cd ..


git clone https://github.com/elm-lang/elm-make.git
cd elm-make
git checkout tags/0.2 --quiet
cabal sandbox init --sandbox ../.cabal-sandbox
cp ../cabal.config .
cabal install -j
cd ..


git clone https://github.com/elm-lang/elm-reactor.git
cd elm-reactor
git checkout tags/0.3.2 --quiet
cabal sandbox init --sandbox ../.cabal-sandbox
cp ../cabal.config .
cabal install -j
cd ..


git clone https://github.com/elm-lang/elm-repl.git
cd elm-repl
git checkout tags/0.4.2 --quiet
cabal sandbox init --sandbox ../.cabal-sandbox
cp ../cabal.config .
cabal install -j
cd ..
