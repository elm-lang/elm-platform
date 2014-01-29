#!/bin/sh

set -ex

installdir=/usr/local/bin

for bin in elm elm-get elm-server elm-repl elm-doc
do
	if [ -f $installdir/$bin ]; then
		sudo rm -f $installdir/$bin
	fi
done
