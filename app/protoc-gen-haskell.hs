-- Copyright 2016 Google Inc. All Rights Reserved.
--
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file or at
-- https://developers.google.com/open-source/licenses/bsd

{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PatternSynonyms #-}
module Main where

import qualified Data.ByteString as B
import Data.Map.Strict ((!))
import Data.Monoid ((<>))
import qualified Data.Set as Set
import qualified Data.Text as T
import Data.Text (Text, pack)
import Data.ProtoLens (defMessage, decodeMessage, encodeMessage)
-- Force the use of the Reflected API when decoding DescriptorProto
-- so that we can run the test suite against the Generated API.
-- TODO: switch back to Data.ProtoLens.Encoding once the Generated encoding is
-- good enough.
import Lens.Family2
import Proto.Google.Protobuf.Compiler.Plugin
    ( CodeGeneratorRequest
    , CodeGeneratorResponse
    )
import Proto.Google.Protobuf.Descriptor (FileDescriptorProto)
import System.Environment (getProgName)
import System.Exit (exitWith, ExitCode(..))
import System.IO as IO

import Data.ProtoLens.Compiler.Combinators
    ( prettyPrint
    , prettyPrintModule
    , getModuleName
    , Module
    )
import Data.ProtoLens.Compiler.Generate
import Data.ProtoLens.Compiler.Plugin

main :: IO ()
main = do
    contents <- B.getContents
    progName <- getProgName
    case decodeMessage contents of
        Left e -> IO.hPutStrLn stderr e >> exitWith (ExitFailure 1)
        Right x -> B.putStr $ encodeMessage $ makeResponse progName x

makeResponse :: String -> CodeGeneratorRequest -> CodeGeneratorResponse
makeResponse prog request = let
    useRuntime = case T.unpack $ request ^. #parameter of
                    "" -> reexported
                    "no-runtime" -> id
                    p -> error $ "Error reading parameter: " ++ show p
    outputFiles = generateFiles useRuntime header
                      (request ^. #protoFile)
                      (request ^. #fileToGenerate)
    header :: FileDescriptorProto -> Text
    header f = "{- This file was auto-generated from "
                <> (f ^. #name)
                <> " by the " <> pack prog <> " program. -}\n"
    in defMessage
           & #file .~ [ defMessage
                            & #name .~ outputName
                            & #content .~ outputContent
                     | (outputName, outputContent) <- outputFiles
                     ]


generateFiles :: ModifyImports -> (FileDescriptorProto -> Text)
              -> [FileDescriptorProto] -> [ProtoFileName] -> [(Text, Text)]
generateFiles modifyImports header files toGenerate = let
  modulePrefix = "Proto"
  filesByName = analyzeProtoFiles modulePrefix files
  -- The contents of the generated Haskell file for a given .proto file.
  modulesToBuild :: ProtoFile -> [Module]
  modulesToBuild f = let
      deps = descriptor f ^. #dependency
      imports = Set.toAscList $ Set.fromList
                  $ map (haskellModule . (filesByName !)) deps
      in generateModule (haskellModule f) imports
            (publicImports f)
             modifyImports
             (definitions f)
             (collectEnvFromDeps deps filesByName)
             (services f)
  in [ ( outputFilePath $ prettyPrint $ getModuleName modul
       , header (descriptor f) <> pack (prettyPrintModule modul)
       )
     | fileName <- toGenerate
     , let f = filesByName ! fileName
     , modul <- modulesToBuild f
     ]

