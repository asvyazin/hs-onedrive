{-# LANGUAGE OverloadedStrings #-}
module Onedrive.Items where


import Control.Concurrent.STM.TVar (TVar)
import Control.Monad.Catch (MonadThrow)
import Control.Monad.IO.Class (MonadIO)
import Data.ByteString.Lazy (ByteString)
import Data.Maybe (maybeToList)
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Onedrive.Internal.Request (initRequest)
import Onedrive.Internal.Response (json, lbs)
import Onedrive.Session (Session)
import Onedrive.Types.FolderChangesBatch (FolderChangesBatch)
import Onedrive.Types.OnedriveItem (OnedriveItem)


item :: (MonadThrow m, MonadIO m) => Session -> Text -> m OnedriveItem
item session itemId = do
  initReq <- initRequest ["drive", "items", itemId] []
  json session initReq


content :: (MonadThrow m, MonadIO m) => Session -> Text -> m ByteString
content session itemId = do
  initReq <- initRequest ["drive", "items", itemId, "content"] []
  lbs session initReq


viewDelta :: (MonadThrow m, MonadIO m) => Session -> Text -> Maybe Text -> m FolderChangesBatch
viewDelta session itemId enumerationToken = do
  let
    tokenParam tok =
      ("token", Just (encodeUtf8 tok))
    qsParams = ("top", Just "100") :
      maybeToList (tokenParam <$> enumerationToken)
  initReq <- initRequest ["drive", "items", itemId, "view.delta"] qsParams
  json session initReq
