{-# LANGUAGE OverloadedStrings #-}
module Onedrive.Items where


import Control.Monad.Catch (MonadThrow)
import Control.Monad.IO.Class (MonadIO)
import Data.Maybe (maybeToList)
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Network.HTTP.Simple (getResponseBody, httpJSON)
import Onedrive.Auth (authorizeRequest)
import Onedrive.Internal.Request (initRequest)
import Onedrive.Types.FolderChangesBatch (FolderChangesBatch)


viewDelta :: (MonadThrow m, MonadIO m) => Text -> Text -> Maybe Text -> m FolderChangesBatch
viewDelta accessToken itemId enumerationToken = do
  let
    tokenParam tok =
      ("token", Just (encodeUtf8 tok))
    qsParams = ("top", Just "100") :
      maybeToList (tokenParam <$> enumerationToken)
  initReq <- initRequest ["drive", "items", itemId, "view.delta"] qsParams
  getResponseBody <$> httpJSON (authorizeRequest accessToken initReq)
