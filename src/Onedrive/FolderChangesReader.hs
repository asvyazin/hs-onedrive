{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
module Onedrive.FolderChangesReader (FolderChangesReader, newFolderChangesReader, getCurrentEnumerationToken, enumerateChanges) where


import Control.Concurrent.STM (atomically)
import Control.Concurrent.STM.TVar (TVar, writeTVar, newTVar, readTVar)
import Control.Lens ((^.))
import Control.Monad.Catch (MonadThrow)
import Control.Monad.IO.Class (MonadIO(liftIO))
import Data.Conduit (Source, (=$=))
import qualified Data.Conduit.Combinators as DC (repeatM, concatMap)
import Data.Text (Text)
import Onedrive.Items (viewDelta)
import Onedrive.Types.FolderChangesBatch (token, value)
import Onedrive.Types.OnedriveItem (OnedriveItem)


data FolderChangesReader =
  FolderChangesReader
  { folderChangesReaderAccessToken :: Text
  , folderChangesReaderItemId :: Text
  , folderChangesReaderCurrentEnumerationToken :: TVar (Maybe Text)
  }


newFolderChangesReader :: (MonadIO m) => Text -> Text -> Maybe Text -> m FolderChangesReader
newFolderChangesReader accessToken itemId enumerationToken = do
  currentToken <- liftIO $ atomically $ newTVar enumerationToken
  return $ FolderChangesReader accessToken itemId currentToken


getCurrentEnumerationToken :: (MonadIO m) => FolderChangesReader -> m (Maybe Text)
getCurrentEnumerationToken reader =
  liftIO $ atomically $ readTVar $ folderChangesReaderCurrentEnumerationToken reader


enumerateChanges :: (MonadIO m, MonadThrow m) => FolderChangesReader -> Source m OnedriveItem
enumerateChanges changesReader =
  enumerateChangesBatches changesReader =$= DC.concatMap id


enumerateChangesBatches :: (MonadIO m, MonadThrow m) => FolderChangesReader -> Source m [OnedriveItem]
enumerateChangesBatches (FolderChangesReader accessToken itemId currentToken) =
  DC.repeatM getChangesBatch'
  where
    getChangesBatch' = do
      enumerationToken <- liftIO $ atomically $ readTVar currentToken
      batch <- viewDelta accessToken itemId enumerationToken
      liftIO $ atomically $ writeTVar currentToken $ Just $ batch ^. token
      return $ batch ^. value
