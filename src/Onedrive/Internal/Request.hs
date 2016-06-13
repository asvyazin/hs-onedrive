{-# LANGUAGE OverloadedStrings #-}
module Onedrive.Internal.Request (initRequest) where


import Control.Monad.Catch (MonadThrow)
import Data.ByteString.Builder (toLazyByteString)
import Data.ByteString.Lazy.Char8 (unpack)
import Data.Monoid ((<>))
import Data.Text (Text)
import Network.HTTP.Simple (Request, parseRequest)
import Network.HTTP.Types.URI (Query, encodePath)


initRequest :: (MonadThrow m) => [Text] -> Query -> m Request
initRequest parts qs = do
  let path = encodePath parts qs
  parseRequest $ unpack $ toLazyByteString $ "https://api.onedrive.com/v1.0" <> path
