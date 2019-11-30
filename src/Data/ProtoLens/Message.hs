-- Copyright 2016 Google Inc. All Rights Reserved.
--
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file or at
-- https://developers.google.com/open-source/licenses/bsd

{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PatternGuards #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeApplications #-}
-- | Datatypes for reflection of protocol buffer messages.
module Data.ProtoLens.Message (
    -- * Reflection of Messages
    Message(..),
    Tag(..),
    allFields,
    FieldDescriptor(..),
    fieldDescriptorName,
    isRequired,
    FieldAccessor(..),
    WireDefault(..),
    Packing(..),
    FieldTypeDescriptor(..),
    ScalarField(..),
    MessageOrGroup(..),
    FieldDefault(..),
    MessageEnum(..),
    -- * Constructing protocol buffers
    build,
    -- * Proto registries
    Registry,
    register,
    lookupRegistered,
    SomeMessageType(..),
    -- * Any messages
    matchAnyMessage,
    AnyMessageDescriptor(..),
    -- * Utilities for constructing protocol buffer lenses
    maybeLens,
    -- * Internal utilities for parsing protocol buffers
    reverseRepeatedFields,
    -- * Unknown fields
    FieldSet,
    TaggedValue(..),
    discardUnknownFields,
    ) where

import qualified Data.ByteString as B
import Data.Int
import qualified Data.Map as Map
import Data.Map (Map)
import Data.Maybe (fromMaybe)
import Data.Proxy (Proxy(..))
import qualified Data.Text as T
import Data.Word
import Lens.Family2 (Lens', over, set)
import Lens.Family2.Unchecked (lens)
import qualified Data.Semigroup as Semigroup

import Data.ProtoLens.Encoding.Bytes (Builder, Parser)
import Data.ProtoLens.Encoding.Wire
    ( Tag(..)
    , TaggedValue(..)
    )

-- | Every protocol buffer is an instance of 'Message'.  This class enables
-- serialization by providing reflection of all of the fields that may be used
-- by this type.
class Message msg where
    -- | A unique identifier for this type, of the format
    -- @"packagename.messagename"@.
    messageName :: Proxy msg -> T.Text

    -- | The serialized protobuffer message descriptor for this type.
    --
    -- For a friendlier version which returns the actual descriptor type,
    -- use @Data.ProtoLens.Descriptor.messageDescriptor@
    -- from the @proto-lens-protobuf-types@ package.
    packedMessageDescriptor :: Proxy msg -> B.ByteString

    -- | The serialized protobuffer file message descriptor containing this type.
    --
    -- For a friendlier version which returns the actual file descriptor type,
    -- use @Data.ProtoLens.Descriptor.fileDescriptor@
    -- from the @proto-lens-protobuf-types@ package.
    packedFileDescriptor :: Proxy msg -> B.ByteString

    -- | A message with all fields set to their default values.
    --
    -- Satisfies @encodeMessage defMessage == ""@ and @decodeMessage "" == Right defMessage@.
    defMessage :: msg

    -- | The fields of the proto, indexed by their (integer) tag.
    fieldsByTag :: Map Tag (FieldDescriptor msg)

    -- | This map is keyed by the name of the field used for text format protos.
    -- This is just the field name for every field except for group fields,
    -- which use their Message type name in text protos instead of their
    -- field name. For example, "optional group Foo" has the field name "foo"
    -- but in this map it is stored with the key "Foo".
    fieldsByTextFormatName :: Map String (FieldDescriptor msg)
    fieldsByTextFormatName =
        Map.fromList [(n, f) | f@(FieldDescriptor n _ _) <- allFields]

    -- | Access the unknown fields of a Message.
    unknownFields :: Lens' msg FieldSet

    -- | Decode a message value.
    --
    -- See also the functions in "Data.ProtoLens.Encoding".
    parseMessage :: Parser msg

    -- | Encode a message value.
    --
    -- See also the functions in "Data.ProtoLens.Encoding".
    buildMessage :: msg -> Builder

allFields :: Message msg => [FieldDescriptor msg]
allFields = Map.elems fieldsByTag

-- TODO: represent FieldSet as a Vector too.
type FieldSet = [TaggedValue]

-- | A description of a specific field of a protocol buffer.
--
-- The 'String' parameter is the name of the field from the .proto file,
-- as used in TextFormat, with the same behavior for groups as
-- 'fieldsByTextFormatName'.
-- (Haddock doesn't support per-argument docs for GADTs.)
data FieldDescriptor msg where
    FieldDescriptor :: String
                    -> FieldTypeDescriptor value -> FieldAccessor msg value
                    -> FieldDescriptor msg

-- | The original name of the field in the .proto file.
fieldDescriptorName :: FieldDescriptor msg -> String
fieldDescriptorName (FieldDescriptor name _ _) = name

-- | Whether the given field is required.  Specifically, if its 'FieldAccessor'
-- is a 'Required' 'PlainField'.
isRequired :: FieldDescriptor msg -> Bool
isRequired (FieldDescriptor _ _ (PlainField Required _)) = True
isRequired _ = False

-- | A Lens for accessing the value of an individual field in a protocol buffer
-- message.
data FieldAccessor msg value where
    -- A field which is stored in the proto as just a value.  Used for
    -- required fields and proto3 optional scalar fields.
    PlainField :: WireDefault value -> Lens' msg value
                     -> FieldAccessor msg value
    -- An optional field where the "unset" and "default" values are
    -- distinguishable.  In particular: proto2 optional fields, proto3
    -- messages, and "oneof" fields.
    OptionalField :: Lens' msg (Maybe value) -> FieldAccessor msg value
    RepeatedField :: Packing -> Lens' msg [value] -> FieldAccessor msg value
    -- A proto "map" field is serialized as a repeated field of an
    -- autogenerated "entry" type, where each entry contains a single key/value
    -- pair.  This constructor provides lenses for accessing the key and value
    -- of each entry, so that we can covert between a list of entries and a Map.
    MapField :: (Ord key, Message entry) => Lens' entry key -> Lens' entry value
                      -> Lens' msg (Map key value) -> FieldAccessor msg entry

-- | The default value (if any) for a 'PlainField' on the wire.
data WireDefault value where
    -- Required fields have no default.
    Required :: WireDefault value
    -- Corresponds to proto3 scalar fields.
    Optional :: (FieldDefault value, Eq value) => WireDefault value

-- | A proto3 field type with an implicit default value.
--
-- This is distinct from, say, 'Data.Default' to avoid orphan instances, and
-- because 'Bool' doesn't necessarily have a good Default instance for general
-- usage.
class FieldDefault value where
    fieldDefault :: value

instance FieldDefault Bool where
    fieldDefault = False

instance FieldDefault Int32 where
    fieldDefault = 0

instance FieldDefault Int64 where
    fieldDefault = 0

instance FieldDefault Word32 where
    fieldDefault = 0

instance FieldDefault Word64 where
    fieldDefault = 0

instance FieldDefault Float where
    fieldDefault = 0

instance FieldDefault Double where
    fieldDefault = 0

instance FieldDefault B.ByteString where
    fieldDefault = B.empty

instance FieldDefault T.Text where
    fieldDefault = T.empty

-- | How a given repeated field is transmitted on the wire format.
data Packing = Packed | Unpacked

-- | A description of the type of a given field value.
data FieldTypeDescriptor value where
    MessageField :: Message value => MessageOrGroup -> FieldTypeDescriptor value
    ScalarField :: ScalarField value -> FieldTypeDescriptor value

deriving instance Show (FieldTypeDescriptor value)

data MessageOrGroup = MessageType | GroupType
    deriving Show

data ScalarField t where
    EnumField :: MessageEnum value => ScalarField value
    Int32Field :: ScalarField Int32
    Int64Field :: ScalarField Int64
    UInt32Field :: ScalarField Word32
    UInt64Field :: ScalarField Word64
    SInt32Field :: ScalarField Int32
    SInt64Field :: ScalarField Int64
    Fixed32Field :: ScalarField Word32
    Fixed64Field :: ScalarField Word64
    SFixed32Field :: ScalarField Int32
    SFixed64Field :: ScalarField Int64
    FloatField :: ScalarField Float
    DoubleField :: ScalarField Double
    BoolField :: ScalarField Bool
    StringField :: ScalarField T.Text
    BytesField :: ScalarField B.ByteString

deriving instance Show (ScalarField value)

matchAnyMessage :: forall value . FieldTypeDescriptor value -> Maybe (AnyMessageDescriptor value)
matchAnyMessage (MessageField _)
    | messageName (Proxy @value) == "google.protobuf.Any"
    , Just (FieldDescriptor _ (ScalarField StringField) (PlainField Optional typeUrlLens))
        <- Map.lookup 1 (fieldsByTag @value)
    , Just (FieldDescriptor _ (ScalarField BytesField) (PlainField Optional valueLens))
        <- Map.lookup 2 (fieldsByTag @value)
        = Just $ AnyMessageDescriptor typeUrlLens valueLens
matchAnyMessage _ = Nothing

data AnyMessageDescriptor msg
    = AnyMessageDescriptor
        { anyTypeUrlLens :: Lens' msg T.Text
        , anyValueLens :: Lens' msg B.ByteString
        }

-- | A class for protocol buffer enums that enables safe decoding.
class (Enum a, Bounded a) => MessageEnum a where
    -- | Convert the given 'Int' to an enum value.  Returns 'Nothing' if
    -- no corresponding value was defined in the .proto file.
    maybeToEnum :: Int -> Maybe a
    -- | Get the name of this enum as defined in the .proto file.  Used
    -- for the human-readable output in @Data.ProtoLens.TextFormat@.
    showEnum :: a -> String
    -- | Convert the given 'String' to an enum value. Returns 'Nothing' if
    -- no corresponding value was defined in the .proto file.
    readEnum :: String -> Maybe a

-- | Utility function for building a message from a default value.
-- For example:
--
-- > instance Default A where ...
-- > x, y :: Lens' A Int
-- > m :: A
-- > m = build ((x .~ 5) . (y .~ 7))
build :: Message a => (a -> a) -> a
build = ($ defMessage)

-- | A helper lens for accessing optional fields.
-- This is used as part of code generation, and should generally not be needed
-- explicitly.
--
-- Note that 'maybeLens' does not satisfy the lens laws, which expect that @set
-- l (view l x) == x@.  For example,
--
-- > set (maybeLens 'a') (view (maybeLens 'a') Nothing) == Just 'a'
--
-- However, this is the behavior generally expected by users, and only matters
-- if we're explicitly checking whether a field is set.
maybeLens :: b -> Lens' (Maybe b) b
maybeLens x = lens (fromMaybe x) $ const Just
-- | Reverse every repeated (list) field in the message.
--
-- During parsing, we store fields temporarily in reverse order,
-- and then un-reverse them at the end.  This helps avoid the quadratic blowup
-- from repeatedly appending to lists.
-- TODO: Benchmark how much of a problem this is in practice,
-- and whether it's still a net win for small protobufs.
-- If we decide on it more permanently, consider moving it to a more internal
-- module.
reverseRepeatedFields :: Map k (FieldDescriptor msg) -> msg -> msg
reverseRepeatedFields fields x0
    -- TODO: if it becomes a bottleneck, consider forcing
    -- the full spine of each list.
    = Map.foldl' reverseListField x0 fields
  where
    reverseListField :: a -> FieldDescriptor a -> a
    reverseListField x (FieldDescriptor _ _ (RepeatedField _ f))
        = over f reverse x
    reverseListField x _ = x

-- | A set of known message types. Can help encode/decode protobufs containing
-- @Data.ProtoLens.Any@ values in a more human-readable text format.
--
-- Registries can be combined using their 'Monoid' instance.
--
-- See the @withRegistry@ functions in 'Data.ProtoLens.TextFormat'
newtype Registry = Registry (Map.Map T.Text SomeMessageType)
    deriving (Semigroup.Semigroup, Monoid)

-- | Build a 'Registry' containing a single proto type.
--
--   Example:
-- > register (Proxy :: Proxy Proto.My.Proto.Type)
register :: forall msg . Message msg => Proxy msg -> Registry
register p = Registry $ Map.singleton (messageName (Proxy @msg)) (SomeMessageType p)

-- | Look up a message type by name (e.g.,
-- @"type.googleapis.com/google.protobuf.FloatValue"@). The URL corresponds to
-- the field @google.protobuf.Any.type_url@.
lookupRegistered :: T.Text -> Registry -> Maybe SomeMessageType
lookupRegistered n (Registry m) = Map.lookup (snd $ T.breakOnEnd "/" n) m

data SomeMessageType where
    SomeMessageType :: Message msg => Proxy msg -> SomeMessageType

-- TODO: recursively
discardUnknownFields :: Message msg => msg -> msg
discardUnknownFields = set unknownFields []
