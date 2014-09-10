#!/bin/sh
# Run the following command to create an installer:
#
#     bash make-installer.sh 0.13
#
# This will work iff the version you give is defined in BuildFromSource.hs


#### SETUP ####

set -e

version=$1

# Create directory structure for new pkgs
pkg_root=$(mktemp -d -t package-artifacts)
pkg_binaries=$pkg_root
pkg_scripts=$pkg_root/Scripts

mkdir -p $pkg_binaries
mkdir -p $pkg_scripts

usr_binaries=/usr/local/bin
usr_assets=/usr/local/share/elm


#### BUILD ELM PLATFORM ####

runhaskell ../BuildFromSource.hs $version

platform=Elm-Platform/$version


#### COPY BINARIES ####

# Create a wrapper around an executable that sets ELM_HOME
function wrap {
     cat << EOF > $pkg_binaries/$1
#!/bin/sh

set -e

export ELM_HOME=$usr_assets
$usr_binaries/$1-unwrapped \$*
EOF
}  

# Copy executables into pkg_binaries directory
for exe in elm elm-get elm-reactor elm-repl elm-doc
do
	cp $platform/bin/$exe $pkg_binaries/$exe-unwrapped
    wrap $exe
	chmod +x $pkg_binaries/$exe
done

cp $(pwd)/preinstall $pkg_scripts
cp $(pwd)/postinstall $pkg_scripts

pkgbuild \
    --identifier org.elm-lang.binaries.pkg \
    --install-location $usr_binaries \
    --scripts $pkg_scripts \
    --filter 'Scripts.*' \
    --root $pkg_root \
    binaries.pkg


#### BUNDLE STATIC ASSETS ####

pkgbuild \
    --identifier org.elm-lang.compiler-assets.pkg \
    --install-location $usr_assets/compiler \
    --root $platform/Elm/data \
    compiler-assets.pkg

pkgbuild \
    --identifier org.elm-lang.reactor-assets.pkg \
    --install-location $usr_assets/reactor \
    --root $platform/elm-reactor/assets \
    reactor-assets.pkg


#### CREATE PACKAGE ####

rm -f Elm-Platform-$version.pkg

productbuild \
    --distribution Distribution.xml \
    --package-path . \
    --resources Resources \
    Elm-Platform-$version.pkg


#### CLEAN UP ####

rm binaries.pkg
rm compiler-assets.pkg
rm reactor-assets.pkg
rm -rf $pkg_root
