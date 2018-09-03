{- This file was auto-generated from google/protobuf/compiler/plugin.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Google.Protobuf.Compiler.Plugin
       (CodeGeneratorRequest(), CodeGeneratorResponse(),
        CodeGeneratorResponse'File())
       where
import qualified Control.DeepSeq
import qualified Lens.Labels.Prism
import qualified Prelude
import qualified Data.Int
import qualified Data.Word
import qualified Data.ProtoLens
import qualified Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Service.Types
import qualified Lens.Family2
import qualified Lens.Family2.Unchecked
import qualified Data.Text
import qualified Data.Map
import qualified Data.ByteString
import qualified Data.ByteString.Char8
import qualified Lens.Labels
import qualified Text.Read
import qualified Proto.Google.Protobuf.Descriptor

{- | Fields :

    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.fileToGenerate' @:: Lens' CodeGeneratorRequest [Data.Text.Text]@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.parameter' @:: Lens' CodeGeneratorRequest Data.Text.Text@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.maybe'parameter' @:: Lens' CodeGeneratorRequest (Prelude.Maybe Data.Text.Text)@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.protoFile' @:: Lens' CodeGeneratorRequest
  [Proto.Google.Protobuf.Descriptor.FileDescriptorProto]@
 -}
data CodeGeneratorRequest = CodeGeneratorRequest{_CodeGeneratorRequest'fileToGenerate
                                                 :: ![Data.Text.Text],
                                                 _CodeGeneratorRequest'parameter ::
                                                 !(Prelude.Maybe Data.Text.Text),
                                                 _CodeGeneratorRequest'protoFile ::
                                                 ![Proto.Google.Protobuf.Descriptor.FileDescriptorProto],
                                                 _CodeGeneratorRequest'_unknownFields ::
                                                 !Data.ProtoLens.FieldSet}
                              deriving (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CodeGeneratorRequest where
        showsPrec _ __x __s
          = Prelude.showChar '{'
              (Prelude.showString (Data.ProtoLens.showMessageShort __x)
                 (Prelude.showChar '}' __s))
instance Lens.Labels.HasLens' CodeGeneratorRequest "fileToGenerate"
           ([Data.Text.Text])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorRequest'fileToGenerate
                 (\ x__ y__ -> x__{_CodeGeneratorRequest'fileToGenerate = y__}))
              Prelude.id
instance Lens.Labels.HasLens' CodeGeneratorRequest "parameter"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorRequest'parameter
                 (\ x__ y__ -> x__{_CodeGeneratorRequest'parameter = y__}))
              (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault)
instance Lens.Labels.HasLens' CodeGeneratorRequest
           "maybe'parameter"
           (Prelude.Maybe Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorRequest'parameter
                 (\ x__ y__ -> x__{_CodeGeneratorRequest'parameter = y__}))
              Prelude.id
instance Lens.Labels.HasLens' CodeGeneratorRequest "protoFile"
           ([Proto.Google.Protobuf.Descriptor.FileDescriptorProto])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorRequest'protoFile
                 (\ x__ y__ -> x__{_CodeGeneratorRequest'protoFile = y__}))
              Prelude.id
instance Data.ProtoLens.Message CodeGeneratorRequest where
        messageName _
          = Data.Text.pack "google.protobuf.compiler.CodeGeneratorRequest"
        fieldsByTag
          = let fileToGenerate__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "file_to_generate"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf'
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "fileToGenerate")))
                      :: Data.ProtoLens.FieldDescriptor CodeGeneratorRequest
                parameter__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parameter"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf'
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'parameter")))
                      :: Data.ProtoLens.FieldDescriptor CodeGeneratorRequest
                protoFile__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "proto_file"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Google.Protobuf.Descriptor.FileDescriptorProto)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf'
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "protoFile")))
                      :: Data.ProtoLens.FieldDescriptor CodeGeneratorRequest
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, fileToGenerate__field_descriptor),
                 (Data.ProtoLens.Tag 2, parameter__field_descriptor),
                 (Data.ProtoLens.Tag 15, protoFile__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _CodeGeneratorRequest'_unknownFields
              (\ x__ y__ -> x__{_CodeGeneratorRequest'_unknownFields = y__})
        defMessage
          = CodeGeneratorRequest{_CodeGeneratorRequest'fileToGenerate = [],
                                 _CodeGeneratorRequest'parameter = Prelude.Nothing,
                                 _CodeGeneratorRequest'protoFile = [],
                                 _CodeGeneratorRequest'_unknownFields = ([])}
instance Control.DeepSeq.NFData CodeGeneratorRequest where
        rnf
          = \ x__ ->
              Control.DeepSeq.deepseq (_CodeGeneratorRequest'_unknownFields x__)
                (Control.DeepSeq.deepseq (_CodeGeneratorRequest'fileToGenerate x__)
                   (Control.DeepSeq.deepseq (_CodeGeneratorRequest'parameter x__)
                      (Control.DeepSeq.deepseq (_CodeGeneratorRequest'protoFile x__)
                         (()))))
{- | Fields :

    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.error' @:: Lens' CodeGeneratorResponse Data.Text.Text@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.maybe'error' @:: Lens' CodeGeneratorResponse (Prelude.Maybe Data.Text.Text)@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.file' @:: Lens' CodeGeneratorResponse [CodeGeneratorResponse'File]@
 -}
data CodeGeneratorResponse = CodeGeneratorResponse{_CodeGeneratorResponse'error
                                                   :: !(Prelude.Maybe Data.Text.Text),
                                                   _CodeGeneratorResponse'file ::
                                                   ![CodeGeneratorResponse'File],
                                                   _CodeGeneratorResponse'_unknownFields ::
                                                   !Data.ProtoLens.FieldSet}
                               deriving (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CodeGeneratorResponse where
        showsPrec _ __x __s
          = Prelude.showChar '{'
              (Prelude.showString (Data.ProtoLens.showMessageShort __x)
                 (Prelude.showChar '}' __s))
instance Lens.Labels.HasLens' CodeGeneratorResponse "error"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorResponse'error
                 (\ x__ y__ -> x__{_CodeGeneratorResponse'error = y__}))
              (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault)
instance Lens.Labels.HasLens' CodeGeneratorResponse "maybe'error"
           (Prelude.Maybe Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorResponse'error
                 (\ x__ y__ -> x__{_CodeGeneratorResponse'error = y__}))
              Prelude.id
instance Lens.Labels.HasLens' CodeGeneratorResponse "file"
           ([CodeGeneratorResponse'File])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorResponse'file
                 (\ x__ y__ -> x__{_CodeGeneratorResponse'file = y__}))
              Prelude.id
instance Data.ProtoLens.Message CodeGeneratorResponse where
        messageName _
          = Data.Text.pack "google.protobuf.compiler.CodeGeneratorResponse"
        fieldsByTag
          = let error__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "error"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf'
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'error")))
                      :: Data.ProtoLens.FieldDescriptor CodeGeneratorResponse
                file__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "file"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor CodeGeneratorResponse'File)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf'
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "file")))
                      :: Data.ProtoLens.FieldDescriptor CodeGeneratorResponse
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, error__field_descriptor),
                 (Data.ProtoLens.Tag 15, file__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _CodeGeneratorResponse'_unknownFields
              (\ x__ y__ -> x__{_CodeGeneratorResponse'_unknownFields = y__})
        defMessage
          = CodeGeneratorResponse{_CodeGeneratorResponse'error =
                                    Prelude.Nothing,
                                  _CodeGeneratorResponse'file = [],
                                  _CodeGeneratorResponse'_unknownFields = ([])}
instance Control.DeepSeq.NFData CodeGeneratorResponse where
        rnf
          = \ x__ ->
              Control.DeepSeq.deepseq (_CodeGeneratorResponse'_unknownFields x__)
                (Control.DeepSeq.deepseq (_CodeGeneratorResponse'error x__)
                   (Control.DeepSeq.deepseq (_CodeGeneratorResponse'file x__) (())))
{- | Fields :

    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.name' @:: Lens' CodeGeneratorResponse'File Data.Text.Text@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.maybe'name' @:: Lens' CodeGeneratorResponse'File (Prelude.Maybe Data.Text.Text)@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.insertionPoint' @:: Lens' CodeGeneratorResponse'File Data.Text.Text@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.maybe'insertionPoint' @:: Lens' CodeGeneratorResponse'File (Prelude.Maybe Data.Text.Text)@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.content' @:: Lens' CodeGeneratorResponse'File Data.Text.Text@
    * 'Proto.Google.Protobuf.Compiler.Plugin_Fields.maybe'content' @:: Lens' CodeGeneratorResponse'File (Prelude.Maybe Data.Text.Text)@
 -}
data CodeGeneratorResponse'File = CodeGeneratorResponse'File{_CodeGeneratorResponse'File'name
                                                             :: !(Prelude.Maybe Data.Text.Text),
                                                             _CodeGeneratorResponse'File'insertionPoint
                                                             :: !(Prelude.Maybe Data.Text.Text),
                                                             _CodeGeneratorResponse'File'content ::
                                                             !(Prelude.Maybe Data.Text.Text),
                                                             _CodeGeneratorResponse'File'_unknownFields
                                                             :: !Data.ProtoLens.FieldSet}
                                    deriving (Prelude.Eq, Prelude.Ord)
instance Prelude.Show CodeGeneratorResponse'File where
        showsPrec _ __x __s
          = Prelude.showChar '{'
              (Prelude.showString (Data.ProtoLens.showMessageShort __x)
                 (Prelude.showChar '}' __s))
instance Lens.Labels.HasLens' CodeGeneratorResponse'File "name"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorResponse'File'name
                 (\ x__ y__ -> x__{_CodeGeneratorResponse'File'name = y__}))
              (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault)
instance Lens.Labels.HasLens' CodeGeneratorResponse'File
           "maybe'name"
           (Prelude.Maybe Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorResponse'File'name
                 (\ x__ y__ -> x__{_CodeGeneratorResponse'File'name = y__}))
              Prelude.id
instance Lens.Labels.HasLens' CodeGeneratorResponse'File
           "insertionPoint"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _CodeGeneratorResponse'File'insertionPoint
                 (\ x__ y__ ->
                    x__{_CodeGeneratorResponse'File'insertionPoint = y__}))
              (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault)
instance Lens.Labels.HasLens' CodeGeneratorResponse'File
           "maybe'insertionPoint"
           (Prelude.Maybe Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _CodeGeneratorResponse'File'insertionPoint
                 (\ x__ y__ ->
                    x__{_CodeGeneratorResponse'File'insertionPoint = y__}))
              Prelude.id
instance Lens.Labels.HasLens' CodeGeneratorResponse'File "content"
           (Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorResponse'File'content
                 (\ x__ y__ -> x__{_CodeGeneratorResponse'File'content = y__}))
              (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault)
instance Lens.Labels.HasLens' CodeGeneratorResponse'File
           "maybe'content"
           (Prelude.Maybe Data.Text.Text)
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CodeGeneratorResponse'File'content
                 (\ x__ y__ -> x__{_CodeGeneratorResponse'File'content = y__}))
              Prelude.id
instance Data.ProtoLens.Message CodeGeneratorResponse'File where
        messageName _
          = Data.Text.pack
              "google.protobuf.compiler.CodeGeneratorResponse.File"
        fieldsByTag
          = let name__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "name"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf'
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'name")))
                      :: Data.ProtoLens.FieldDescriptor CodeGeneratorResponse'File
                insertionPoint__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "insertion_point"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf'
                            ((Lens.Labels.proxy#) ::
                               (Lens.Labels.Proxy#) "maybe'insertionPoint")))
                      :: Data.ProtoLens.FieldDescriptor CodeGeneratorResponse'File
                content__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content"
                      (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.OptionalField
                         (Lens.Labels.lensOf'
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'content")))
                      :: Data.ProtoLens.FieldDescriptor CodeGeneratorResponse'File
              in
              Data.Map.fromList
                [(Data.ProtoLens.Tag 1, name__field_descriptor),
                 (Data.ProtoLens.Tag 2, insertionPoint__field_descriptor),
                 (Data.ProtoLens.Tag 15, content__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens
              _CodeGeneratorResponse'File'_unknownFields
              (\ x__ y__ ->
                 x__{_CodeGeneratorResponse'File'_unknownFields = y__})
        defMessage
          = CodeGeneratorResponse'File{_CodeGeneratorResponse'File'name =
                                         Prelude.Nothing,
                                       _CodeGeneratorResponse'File'insertionPoint = Prelude.Nothing,
                                       _CodeGeneratorResponse'File'content = Prelude.Nothing,
                                       _CodeGeneratorResponse'File'_unknownFields = ([])}
instance Control.DeepSeq.NFData CodeGeneratorResponse'File where
        rnf
          = \ x__ ->
              Control.DeepSeq.deepseq
                (_CodeGeneratorResponse'File'_unknownFields x__)
                (Control.DeepSeq.deepseq (_CodeGeneratorResponse'File'name x__)
                   (Control.DeepSeq.deepseq
                      (_CodeGeneratorResponse'File'insertionPoint x__)
                      (Control.DeepSeq.deepseq (_CodeGeneratorResponse'File'content x__)
                         (()))))