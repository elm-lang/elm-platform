{-| This script builds any version of the Elm Platform from source.
Before you use it, make sure you have the Haskell Platform with a recent
version of cabal.

To install a released version of Elm, run something like this:

    runhaskell BuildFromSource.hs 0.15.1

Whatever directory you run this in, you will now have a new directory for the
Elm Platform, like this:

    Elm-Platform/0.15.1/
        bin/             -- all the relevant executables
        elm-make/        -- git repo for the build tool, ready to edit
        elm-repl/        -- git repo for the REPL, ready to edit
        ...

All of the executables you need are in bin/ so add
wherever/Elm-Platform/0.15.1/bin to your PATH to use them from anywhere.

You can build many versions of the Elm Platform, so it is possible to have
Elm-Platform/0.15.1/ and Elm-Platform/0.12.3/ with no problems. It is up to you
to manage your PATH variable or symlinks though.

To get set up with the master branch of all Elm Platform projects, run this:

    runhaskell BuildFromSource.hs master

From there you can start developing on any of the projects, switching branches
and testing interactions between projects.
-}
module Main where

import qualified Data.List as List
import qualified Data.Map as Map
import System.Directory (createDirectoryIfMissing, setCurrentDirectory, getCurrentDirectory)
import System.Environment (getArgs)
import System.Exit (ExitCode, exitFailure)
import System.FilePath ((</>))
import System.IO (hPutStrLn, stderr)
import System.Process (rawSystem)


(=:) = (,)

-- NOTE: The order of the dependencies is also the build order,
-- so do not just go alphebetizing things.
configs :: Map.Map String [(String, String)]
configs =
  Map.fromList
    [
      "master" =:
        [ "elm-compiler" =: "master"
        , "elm-package"  =: "master"
        , "elm-make"     =: "master"
        , "elm-reactor"  =: "master"
        , "elm-repl"     =: "master"
        ]
    ,
      "0.15.1" =:
        [ "elm-compiler" =: "0.15.1"
        , "elm-package"  =: "0.5.1"
        , "elm-make"     =: "0.2"
        , "elm-reactor"  =: "0.3.2"
        , "elm-repl"     =: "0.4.2"
        ]
    ,
      "0.15" =:
        [ "elm-compiler" =: "0.15"
        , "elm-package"  =: "0.5"
        , "elm-make"     =: "0.1.2"
        , "elm-reactor"  =: "0.3.1"
        , "elm-repl"     =: "0.4.1"
        ]
    ,
      "0.14.1" =:
        [ "elm-compiler" =: "0.14.1"
        , "elm-package"  =: "0.4"
        , "elm-make"     =: "0.1.1"
        , "elm-reactor"  =: "0.3"
        , "elm-repl"     =: "0.4"
        ]
    ,
      "0.14" =:
        [ "elm-compiler" =: "0.14"
        , "elm-package"  =: "0.2"
        , "elm-make"     =: "0.1"
        , "elm-reactor"  =: "0.2"
        , "elm-repl"     =: "0.4"
        ]
    ,
      "0.13" =:
        [ "Elm"         =: "0.13"
        , "elm-reactor" =: "0.1"
        , "elm-repl"    =: "0.3"
        , "elm-get"     =: "0.1.3"
        ]
    ,
      "0.12.3" =:
        [ "Elm"        =: "0.12.3"
        , "elm-server" =: "0.11.0.1"
        , "elm-repl"   =: "0.2.2.1"
        , "elm-get"    =: "0.1.2"
        ]
    ]


main :: IO ()
main =
 do args <- getArgs
    case args of
      [version] | Map.member version configs ->
          let artifactDirectory = "Elm-Platform" </> version
              repos = configs Map.! version
          in
              makeRepos artifactDirectory repos

      _ ->
        do hPutStrLn stderr $
               "Expecting one of the following values as an argument:\n" ++
               "    " ++ List.intercalate ", " (Map.keys configs)
           exitFailure


makeRepos :: FilePath -> [(String, String)] -> IO ()
makeRepos artifactDirectory repos =
 do createDirectoryIfMissing True artifactDirectory
    setCurrentDirectory artifactDirectory
    root <- getCurrentDirectory
    mapM_ (uncurry (makeRepo root)) repos

    -- create a sandbox for installation
    cabal [ "sandbox", "init" ]

    -- add each of the sub-directories as a sandbox source
    cabal ([ "sandbox", "add-source" ] ++ map fst repos)
    
    -- install all of the packages together in order to resolve transient dependencies robustly
    -- (install the dependencies a bit more quietly than the elm packages)
    cabal ([ "install", "-j", "--only-dependencies", "--ghc-options=\"-w\"" ] ++ map fst repos)
    cabal ([ "install", "-j", "--bindir=../", "--ghc-options=\"-XFlexibleContexts\"" ] ++ map fst repos)

    return ()

makeRepo :: FilePath -> String -> String -> IO ()
makeRepo root projectName version =
  do  -- get the right version of the repo
    git [ "clone", "https://github.com/elm-lang/" ++ projectName ++ ".git", "--quiet" ]
    setCurrentDirectory projectName
    git [ "checkout", version ]
    git [ "pull" ]

    -- move back into the root
    setCurrentDirectory root


-- HELPER FUNCTIONS

cabal :: [String] -> IO ExitCode
cabal = rawSystem "cabal"

git :: [String] -> IO ExitCode
git = rawSystem "git"
