#!/bin/sh

set -ex

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
cp $(which elm) $bindir
cp $(which elm-server) $bindir

pkgbuild --identifier org.elm-lang.pkg.app --install-location /Applications --root $tmpdir --scripts $scriptsdir Elm.pkg

echo $tmpdir
