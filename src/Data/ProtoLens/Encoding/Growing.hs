-- | A mutable vector that grows in size.
--
-- Example usage:
--
-- > import qualified Data.ProtoLens.Encoding.Growing as Growing
-- > import qualified Data.Vector.Unboxed as V
-- > test :: IO (V.Vector Int)
-- > test = do
-- >     v <- Growing.new
-- >     v' <- Growing.append v 1
-- >     v'' <- Growing.append v' 2
-- >     v''' <- Growing.append v'' 3
-- >     unsafeFreeze v'''
module Data.ProtoLens.Encoding.Growing (
    Growing,
    new,
    append,
    unsafeFreeze,
    RealWorld,
    ) where

import Control.Monad.Primitive (PrimMonad, PrimState, RealWorld)

import qualified Data.Vector.Generic as V
import qualified Data.Vector.Generic.Mutable as MV

-- | A mutable vector which can increase in capacity.
data Growing v s a = Growing
    {-# UNPACK #-} !Int
        -- The number of elements in the mutable vector
        -- that have already been set.
    !(V.Mutable v s a)
        -- TODOs for efficiency:
        -- - Try unpacking this.  It's difficult as-is because
        --   V.Mutable is a type function.
        -- - MVectors support slicing, but we're not using that
        --   functionality, so we're passing around an extra unnecessary
        --   Int.

-- | Create a new empty growing vector.
new :: (PrimMonad m, V.Vector v a) => m (Growing v (PrimState m) a)
new = Growing 0 <$> MV.new 0

-- | Unsafely convert a growing vector to an immutable one without
-- copying.  After this call, you may not use the growing vector
-- nor any other growing vectors that were used to produce this one.
unsafeFreeze
    :: (PrimMonad m, V.Vector v a)
    => Growing v (PrimState m) a -> m (v a)
unsafeFreeze (Growing len m) = V.unsafeFreeze (MV.take len m)

-- | Returns a new growing vector with a new element at the end.
-- Note that the return value may share storage with the input value.
-- Furthermore, calling @append@ twice on the same input may result
-- in two vectors that share the same storage.
append
    :: (PrimMonad m, V.Vector v a)
    => Growing v (PrimState m) a
    -> a
    -> m (Growing v (PrimState m) a)
append (Growing len v) x
    | len < MV.length v = do
        MV.unsafeWrite v len x
        return $ Growing (len + 1) v
    | otherwise = do
        let len' = 2 * len + 1
        v' <- MV.unsafeGrow v len'
        MV.unsafeWrite v' len x
        return $ Growing (len + 1) v'
{-# INLINE append #-}
