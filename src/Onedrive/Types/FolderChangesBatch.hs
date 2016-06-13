{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.FolderChangesBatch where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:), (.:?))
import Data.Text (Text)
import Onedrive.Types.OnedriveItem (OnedriveItem)


data FolderChangesBatch =
  FolderChangesBatch
  { folderChangesBatchValue :: [OnedriveItem]
  , folderChangesBatchNextLink :: Maybe Text
  , folderChangesBatchDeltaLink :: Maybe Text
  , folderChangesBatchToken :: Text
  } deriving (Show)


instance FromJSON FolderChangesBatch where
  parseJSON (Object o) =
    FolderChangesBatch <$> o .: "value" <*> o .:? "@odata.nextLink" <*> o .:? "@odata.deltaLink" <*> o .: "@delta.token"
  parseJSON _ =
    error "Invalid FolderChangesBatch JSON"


makeLensesWith camelCaseFields ''FolderChangesBatch
