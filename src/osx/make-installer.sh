#!/bin/sh

set -e


tmpdir=$(mktemp -d -t elm)

installerdir=$(pwd)

appdir=$tmpdir/Elm.app
contentsdir=$appdir/Contents
scriptsdir=$contentsdir/Scripts
bindir=$contentsdir/MacOS
resourcesdir=$contentsdir/Resources

mkdir -p $bindir
mkdir -p $resourcesdir
mkdir -p $scriptsdir

cp $installerdir/Info.plist $contentsdir
cp $installerdir/postinstall $scriptsdir

cp $installerdir/uninstall.sh $bindir
cp $installerdir/elm-startup.sh $bindir

for bin in elm elm-get elm-server elm-repl elm-doc
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

iconutil -c icns -o $resourcesdir/elm.icns elm.iconset

pkgbuild --identifier org.elm-lang.pkg.app --install-location /Applications --root $tmpdir --scripts $scriptsdir Elm.pkg

rm -rf $tmpdir

