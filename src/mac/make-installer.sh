#!/bin/sh

set -e

# Set version numbers for everything we want to build from source
version_compiler="0.12.3"
version_server="0.11.0.1"
version_repl="0.2.2.1"
version_get="0.1.2"

# Clean-up old pkg files
rm -f Elm.pkg

# Create directory structure for new pkgs
installerdir=$(pwd)
helpdir=$installerdir/helper-scripts

tmpdir=$(mktemp -d -t elm)
contentsdir=$tmpdir
scriptsdir=$contentsdir/Scripts
targetdir=/usr/local/bin
bindir=$contentsdir

mkdir -p $bindir
mkdir -p $scriptsdir

# Build Elm compiler and copy required resources to the correct places
bash $helpdir/build.sh Elm        $version_compiler
datafilesdir=projects/Elm/data

cp $installerdir/postinstall $scriptsdir

# Grab pre-built versions of other executables
# Probably should build these from source as well
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
 	cp $(which $bin) $bindir/$bin-unwrapped

	cat << EOF > $bindir/$bin
#!/bin/sh

set -e

export ELM_HOME=/usr/local/share/elm
$targetdir/$bin-unwrapped \$*
EOF
	chmod +x $bindir/$bin
done

pkgbuild --identifier org.elm-lang.share.pkg --install-location /usr/local/share/elm --root $datafilesdir share.pkg
pkgbuild --identifier org.elm-lang.bin.pkg --install-location /usr/local/bin --scripts $scriptsdir --filter 'Scripts.*' --root $tmpdir bin.pkg

productbuild --distribution Distribution.xml --package-path . --resources Resources Elm.pkg

# Clean-up
rm bin.pkg
rm share.pkg
rm -rf $tmpdir
