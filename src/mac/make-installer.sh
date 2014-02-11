#!/bin/sh

set -e

tmpdir=$(mktemp -d -t elm)

installerdir=$(pwd)

contentsdir=$tmpdir
scriptsdir=$contentsdir/Scripts
bindir=$contentsdir

mkdir -p $bindir
mkdir -p $scriptsdir

cp $installerdir/postinstall $scriptsdir
cp $installerdir/wrapper/elm $bindir

# This is not nice! You should download Elm and build everything from scratch
for bin in elm-compiler elm-get elm-server elm-repl elm-doc
do
	whichbin=$(which $bin) || echo ""
	if [ "$whichbin" = "" ]; then
		echo "File does not exist: $bin"
		exit 1
	fi
	if [ ! -f $whichbin ]; then
		echo "File does not exist: $bin"
		exit 1
	fi

 	cp $(which $bin) $bindir 
done

pkgbuild --identifier org.elm-lang.share.pkg --install-location /usr/local/share/elm --root ../share share.pkg
pkgbuild --identifier org.elm-lang.bin.pkg --install-location /usr/local/bin --scripts $scriptsdir --filter 'Scripts.*' --root $tmpdir bin.pkg

productbuild --distribution Distribution.xml --package-path . --resources Resources ElmInstaller.pkg

# Clean-up
rm bin.pkg
rm share.pkg

# rm -rf $tmpdir

