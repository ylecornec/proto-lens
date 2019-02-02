{- | An implementation of overloaded record fields.  This module
enables different types in the same module to have fields of the
same name.

To use instances from this class, either:

* Enable the @OverloadedLabels@ extension and
  @import Data.ProtoLens.Labels ()@;
* Use the 'field' function along with the @TypeApplications@ extension; or,
* Import the corresponding names from the autogenerated @*_Fields@ module.

For more information, see <https://google.github.io/proto-lens/tutorial.html#field-overloading>.
-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Data.ProtoLens.Field
    ( HasField(..)
    , field
    ) where

import GHC.Prim (Proxy#, proxy#)
import GHC.TypeLits (Symbol)

-- | A lens for a given field.  For example:
--
-- > view field@"abc" x
-- > set field@"abc" 42 x
field :: forall x s a f . (HasField s x a, Functor f) => (a -> f a) -> s -> f s
field = lensOf (proxy# :: Proxy# x)

-- | A type class for lens fields.
--
-- The instance @HasField s x a@ can be understood as "@s@ has a field named @x@
-- of type @a@".
class HasField s (x :: Symbol) a | s x -> a where
    lensOf :: Functor f => Proxy# x -> (a -> f a) -> s -> f s
