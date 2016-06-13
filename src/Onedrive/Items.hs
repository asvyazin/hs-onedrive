{-# LANGUAGE OverloadedStrings #-}
module Onedrive.Items where


import Control.Monad.Catch (MonadThrow)
import Control.Monad.IO.Class (MonadIO)
import Data.ByteString.Lazy (ByteString)
import Data.Maybe (maybeToList)
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Network.HTTP.Simple (getResponseBody, httpJSON, httpLBS, setRequestIgnoreStatus)
import Onedrive.Auth (authorizeRequest)
import Onedrive.Internal.Request (initRequest)
import Onedrive.Types.FolderChangesBatch (FolderChangesBatch)
import Onedrive.Types.OnedriveItem (OnedriveItem)


item :: (MonadThrow m, MonadIO m) => Text -> Text -> m OnedriveItem
item accessToken itemId = do
  initReq <- initRequest ["drive", "items", itemId] []
  getResponseBody <$> httpJSON (authorizeRequest accessToken initReq)


content :: (MonadThrow m, MonadIO m) => Text -> Text -> m ByteString
content accessToken itemId = do
  initReq <- initRequest ["drive", "items", itemId, "content"] []
  getResponseBody <$> httpLBS (authorizeRequest accessToken initReq)


viewDelta :: (MonadThrow m, MonadIO m) => Text -> Text -> Maybe Text -> m FolderChangesBatch
viewDelta accessToken itemId enumerationToken = do
  let
    tokenParam tok =
      ("token", Just (encodeUtf8 tok))
    qsParams = ("top", Just "100") :
      maybeToList (tokenParam <$> enumerationToken)
  initReq <- initRequest ["drive", "items", itemId, "view.delta"] qsParams
  getResponseBody <$> httpJSON (authorizeRequest accessToken initReq)
