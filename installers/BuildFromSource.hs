{-| This script builds any version of the Elm Platform from source.
Before you use it, make sure you have the Haskell Platform with a recent
version of cabal.

To install a released version of Elm, you will run something like this:

    runhaskell BuildFromSource.hs 0.16

Before you do that, in some directory of your choosing, add
wherever/Elm-Platform/0.16/.cabal-sandbox/bin to your PATH.

Then, run the above. You will now actually have a new directory for the
Elm Platform, like this:

    Elm-Platform/0.16/
        elm-make/        -- git repo for the build tool, ready to edit
        elm-repl/        -- git repo for the REPL, ready to edit
        ...
        .cabal-sandbox/  -- various build files

All of the executables you need are in .cabal-sandbox/bin, which is on
your PATH and thus can be used from anywhere.

You can build many versions of the Elm Platform, so it is possible to have
Elm-Platform/0.16/ and Elm-Platform/0.13/ with no problems. It is up to you
to manage your PATH variable or symlinks though.

To get set up with the master branch of all Elm Platform projects, run this:

    runhaskell BuildFromSource.hs master

From there you can start developing on any of the projects, switching branches
and testing interactions between projects.
-}
module Main where

import qualified Data.List          as List
import qualified Data.Map           as Map
import           System.Directory   (createDirectoryIfMissing,
                                     getCurrentDirectory, setCurrentDirectory)
import           System.Environment (getArgs)
import           System.Exit        (ExitCode, exitFailure)
import           System.FilePath    ((</>))
import           System.IO          (hPutStrLn, stderr, stdout)
import           System.Process     (rawSystem, readProcess)
import           System.Info        (compilerVersion)
import           Data.Version       (makeVersion, parseVersion, showVersion)
import           System.Directory   (findExecutable)
import           Text.ParserCombinators.ReadP (readP_to_S)
import           Control.Monad      ()
import           Text.Printf        (hPrintf)

cabalMajor = 1
cabalMinor = 18
minCabalVersion = makeVersion [ cabalMajor, cabalMinor ]

data GHCVersion = AnyGHC | GHC Int Int

(=:) = (,)
withAtLeast = (,)

configs :: Map.Map String (GHCVersion, [(String, String)])
configs =
  Map.fromList
    [
      "master" =: withAtLeast (GHC 7 10)
        [ "elm-compiler" =: "master"
        , "elm-package"  =: "master"
        , "elm-make"     =: "master"
        , "elm-reactor"  =: "master"
        , "elm-repl"     =: "master"
        ]
    ,
      "0.16" =: withAtLeast (GHC 7 10)
        [ "elm-compiler" =: "0.16"
        , "elm-package"  =: "0.16"
        , "elm-make"     =: "0.16"
        , "elm-reactor"  =: "0.16"
        , "elm-repl"     =: "0.16"
        ]
    ,
      "0.15.1" =: withAtLeast (GHC 7 8)
        [ "elm-compiler" =: "0.15.1"
        , "elm-package"  =: "0.5.1"
        , "elm-make"     =: "0.2"
        , "elm-reactor"  =: "0.3.2"
        , "elm-repl"     =: "0.4.2"
        ]
    ,
      "0.15" =: withAtLeast (GHC 7 8)
        [ "elm-compiler" =: "0.15"
        , "elm-package"  =: "0.5"
        , "elm-make"     =: "0.1.2"
        , "elm-reactor"  =: "0.3.1"
        , "elm-repl"     =: "0.4.1"
        ]
    ,
      "0.14.1" =: withAtLeast AnyGHC
        [ "elm-compiler" =: "0.14.1"
        , "elm-package"  =: "0.4"
        , "elm-make"     =: "0.1.1"
        , "elm-reactor"  =: "0.3"
        , "elm-repl"     =: "0.4"
        ]
    ,
      "0.14" =: withAtLeast AnyGHC
        [ "elm-compiler" =: "0.14"
        , "elm-package"  =: "0.2"
        , "elm-make"     =: "0.1"
        , "elm-reactor"  =: "0.2"
        , "elm-repl"     =: "0.4"
        ]
    ,
      "0.13" =: withAtLeast AnyGHC
        [ "Elm"         =: "0.13"
        , "elm-reactor" =: "0.1"
        , "elm-repl"    =: "0.3"
        , "elm-get"     =: "0.1.3"
        ]
    ,
      "0.12.3" =: withAtLeast AnyGHC
        [ "Elm"        =: "0.12.3"
        , "elm-server" =: "0.11.0.1"
        , "elm-repl"   =: "0.2.2.1"
        , "elm-get"    =: "0.1.2"
        ]
    ]

checkGHCVersion AnyGHC = return ()
checkGHCVersion (GHC ghcMajor ghcMinor) =
  if compilerVersion < makeVersion [ghcMajor, ghcMinor] then
    do
      hPrintf stderr "You need at least GHC version %i.%i to build this version of Elm\n" ghcMajor ghcMinor
      exitFailure
  else
    hPrintf stdout "Using GHC version %s.\n" (showVersion compilerVersion)

checkCabalVersion =
  do
    path <- (findExecutable "cabal")
    case path of
      Nothing -> do ( hPutStrLn stderr "cabal is not installed" )
                    exitFailure
      Just path -> do
        versionString <- (readProcess path [ "--numeric-version" ] "" )
        version <- return ((fst. last . (readP_to_S parseVersion)) versionString)
        if (version < minCabalVersion) then
          do
            hPrintf stderr "You need at least cabal version %i.%i to build Elm\n" cabalMajor cabalMinor
            exitFailure
        else
          hPrintf stdout "Using cabal version %s.\n" (showVersion version)

main :: IO ()
main =
 do args <- getArgs
    case args of
      [version] | Map.member version configs ->
        do let (minGHCVersion, repos) = configs Map.! version
           checkGHCVersion minGHCVersion
           checkCabalVersion
           let artifactDirectory = "Elm-Platform" </> version
           makeRepos artifactDirectory version repos

      _ ->
        do hPutStrLn stderr $
               "Expecting one of the following values as an argument:\n" ++
               "    " ++ List.intercalate ", " (Map.keys configs)
           exitFailure


makeRepos :: FilePath -> String -> [(String, String)] -> IO ()
makeRepos artifactDirectory version repos =
 do createDirectoryIfMissing True artifactDirectory
    setCurrentDirectory artifactDirectory
    root <- getCurrentDirectory
    mapM_ (uncurry (makeRepo root)) repos

    cabal [ "update" ]

    -- create a sandbox for installation
    cabal [ "sandbox", "init" ]

    -- add each of the sub-directories as a sandbox source
    cabal ([ "sandbox", "add-source" ] ++ map fst repos)

    -- install all of the packages together in order to resolve transitive dependencies robustly
    -- (install the dependencies a bit more quietly than the elm packages)
    cabal ([ "install", "-j", "--only-dependencies", "--ghc-options=\"-w\"" ] ++ (if version <= "0.15.1" then [ "--constraint=fsnotify<0.2" ] else []) ++ map fst repos)
    cabal ([ "install", "-j", "--ghc-options=\"-XFlexibleContexts\"" ] ++ filter (/= "elm-reactor") (map fst repos))

    -- elm-reactor needs to be installed last because of a post-build dependency on elm-make
    cabal [ "install", "-j", "elm-reactor" ]

    return ()

makeRepo :: FilePath -> String -> String -> IO ()
makeRepo root projectName version =
  do  -- get the right version of the repo
    git [ "clone", "https://github.com/elm-lang/" ++ projectName ++ ".git" ]
    setCurrentDirectory projectName
    git [ "checkout", version, "--quiet" ]

    -- move back into the root
    setCurrentDirectory root


-- HELPER FUNCTIONS

cabal :: [String] -> IO ExitCode
cabal = rawSystem "cabal"

git :: [String] -> IO ExitCode
git = rawSystem "git"
