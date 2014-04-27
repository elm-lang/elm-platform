#!/bin/sh

set -e

project=$1

mkdir -p projects
cd projects

# Clone the project if necessary
if [ ! -d $project ]; then
    git clone https://github.com/elm-lang/$project.git
fi

cd $project

# Build the project if necessary.
# "git describe" may report a fatal error, but it does not matter if that happens.
tag=$(git describe --exact-match HEAD || echo "failure")
if [ $tag != $2 ]; then
    git checkout master
    git pull
    git checkout tags/$2
fi

cabal install
