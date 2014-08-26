#!/bin/sh

set -e

echo "Warning: You are about to remove all Elm executables!"

installdir=/usr/local/bin

for bin in elm elm-compiler elm-get elm-reactor elm-repl elm-doc
do
	if [ -f $installdir/$bin ]; then
		sudo rm -f $installdir/$bin
	fi
done

sharedir=/usr/local/share/elm
sudo rm -rf $sharedir
