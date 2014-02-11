#!/bin/sh

set -e

project=$1

if [ ! -d $project ]; then
    git clone https://github.com/evancz/$project.git
fi

cd $project

# May report a "fatal" error, but that is okay.
tag=$(git describe --exact-match HEAD || echo "failure")
if [ $tag != $2 ]; then
    git checkout master
    git pull
    git checkout tags/$2
fi

cabal install
