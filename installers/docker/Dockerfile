# To build: docker build --rm -t elm-server .
# To run Elm: docker run -i -t -p 8000:8000 -v $(pwd):/source elm-server
FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y haskell-platform
RUN apt-get install -y libgc-dev llvm-3.3-dev libghc-terminfo-dev pkg-config

# Install elm and friends
RUN cabal update
RUN cabal install cabal-install
RUN cabal install -j elm-compiler-0.14.1 elm-package-0.4 elm-make-0.1.1
RUN cabal install -j elm-repl-0.4 elm-reactor-0.3

# Install git so elm-package can pull dependencies
RUN apt-get update
RUN apt-get install -y git

# Install nodejs for repl
RUN apt-get install -y node

# Symlink all elm binaries
RUN bash -c "ln -s /root/.cabal/bin/elm* /usr/local/bin/"

# Set default WORKDIR
WORKDIR /source
CMD elm-reactor
