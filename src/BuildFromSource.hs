{-| This script builds any version of the Elm Platform from source.
Before you use it, make sure you have the Haskell Platform with a recent
version of cabal.

To install a released version of Elm, run something like this:

    runhaskell BuildFromSource.hs 0.13

Whatever directory you run this in, you will now have a new directory for the
Elm Platform, like this:

    Elm-Platform/0.13/
        bin/             -- all the relevant executables
        Elm/             -- git repo for the compiler, ready to edit
        elm-repl/        -- git repo for the REPL, ready to edit
        ...

All of the executables you need are in bin/ so add
wherever/Elm-Platform/0.13/bin to your PATH to use them from anywhere.

You can build many versions of the Elm Platform, so it is possible to have
Elm-Platform/0.13/ and Elm-Platform/0.12.3/ with no problems. It is up to you
to manage your PATH variable or symlinks though.

To get set up with the master branch of all Elm Platform projects, run this:

    runhaskell BuildFromSource.hs master

From there you can start developing on any of the projects, switching branches
and testing interactions between projects.
-}
module Main where

import qualified Data.List as List
import qualified Data.Map as Map
import System.Directory (createDirectoryIfMissing, setCurrentDirectory, getCurrentDirectory, doesFileExist)
import System.Environment (getArgs)
import System.Exit (ExitCode, exitFailure)
import System.FilePath ((</>))
import System.IO (hPutStrLn, stderr)
import System.Process (rawSystem)
import Control.Monad (when, void)


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
    cabal [ "sandbox", "init", "--sandbox=." ]
    mapM_ (uncurry (makeRepo root)) repos


makeRepo :: FilePath -> String -> String -> IO ()
makeRepo root projectName version =
 do  -- get the right version of the repo
    git [ "clone", "https://github.com/elm-lang/" ++ projectName ++ ".git" ]
    setCurrentDirectory projectName
    git [ "checkout", version ]
    git [ "pull" ]

    whenM (doesFileExist "elm-package.json") $ void $ elmPackage [ "install", "--yes" ]

    -- actually build things
    cabal [ "sandbox", "init", "--sandbox=" ++ root ]
    cabal [ "install", "-j" ]

    -- move back into the root
    setCurrentDirectory root


-- HELPER FUNCTIONS

whenM :: Monad m => m Bool -> m () -> m ()
whenM p s = flip when s =<< p

cabal :: [String] -> IO ExitCode
cabal = rawSystem "cabal"

git :: [String] -> IO ExitCode
git = rawSystem "git"

elmPackage :: [String] -> IO ExitCode
elmPackage = rawSystem "../bin/elm-package"
