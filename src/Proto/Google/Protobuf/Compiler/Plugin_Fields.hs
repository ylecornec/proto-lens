{- This file was auto-generated from google/protobuf/compiler/plugin.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Google.Protobuf.Compiler.Plugin_Fields where
import qualified Prelude
import qualified Data.Int
import qualified Data.Word
import qualified Data.ProtoLens
import qualified Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Service.Types
import qualified Lens.Family2
import qualified Lens.Family2.Unchecked
import qualified Data.Default.Class
import qualified Data.Text
import qualified Data.Map
import qualified Data.ByteString
import qualified Data.ByteString.Char8
import qualified Lens.Labels
import qualified Text.Read
import qualified Proto.Google.Protobuf.Descriptor

content ::
        forall f s a .
          (Prelude.Functor f, Lens.Labels.HasLens' s "content" a) =>
          Lens.Family2.LensLike' f s a
content
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "content")
error ::
      forall f s a .
        (Prelude.Functor f, Lens.Labels.HasLens' s "error" a) =>
        Lens.Family2.LensLike' f s a
error
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "error")
file ::
     forall f s a .
       (Prelude.Functor f, Lens.Labels.HasLens' s "file" a) =>
       Lens.Family2.LensLike' f s a
file
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "file")
fileToGenerate ::
               forall f s a .
                 (Prelude.Functor f, Lens.Labels.HasLens' s "fileToGenerate" a) =>
                 Lens.Family2.LensLike' f s a
fileToGenerate
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fileToGenerate")
insertionPoint ::
               forall f s a .
                 (Prelude.Functor f, Lens.Labels.HasLens' s "insertionPoint" a) =>
                 Lens.Family2.LensLike' f s a
insertionPoint
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "insertionPoint")
maybe'content ::
              forall f s a .
                (Prelude.Functor f, Lens.Labels.HasLens' s "maybe'content" a) =>
                Lens.Family2.LensLike' f s a
maybe'content
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'content")
maybe'error ::
            forall f s a .
              (Prelude.Functor f, Lens.Labels.HasLens' s "maybe'error" a) =>
              Lens.Family2.LensLike' f s a
maybe'error
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'error")
maybe'insertionPoint ::
                     forall f s a .
                       (Prelude.Functor f,
                        Lens.Labels.HasLens' s "maybe'insertionPoint" a) =>
                       Lens.Family2.LensLike' f s a
maybe'insertionPoint
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "maybe'insertionPoint")
maybe'name ::
           forall f s a .
             (Prelude.Functor f, Lens.Labels.HasLens' s "maybe'name" a) =>
             Lens.Family2.LensLike' f s a
maybe'name
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'name")
maybe'parameter ::
                forall f s a .
                  (Prelude.Functor f, Lens.Labels.HasLens' s "maybe'parameter" a) =>
                  Lens.Family2.LensLike' f s a
maybe'parameter
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'parameter")
name ::
     forall f s a .
       (Prelude.Functor f, Lens.Labels.HasLens' s "name" a) =>
       Lens.Family2.LensLike' f s a
name
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "name")
parameter ::
          forall f s a .
            (Prelude.Functor f, Lens.Labels.HasLens' s "parameter" a) =>
            Lens.Family2.LensLike' f s a
parameter
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parameter")
protoFile ::
          forall f s a .
            (Prelude.Functor f, Lens.Labels.HasLens' s "protoFile" a) =>
            Lens.Family2.LensLike' f s a
protoFile
  = Lens.Labels.lensOf'
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "protoFile")