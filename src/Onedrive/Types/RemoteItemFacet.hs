{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.RemoteItemFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Onedrive.Types.FileFacet (FileFacet)
import Onedrive.Types.FileSystemInfoFacet (FileSystemInfoFacet)
import Onedrive.Types.FolderFacet (FolderFacet)
import Onedrive.Types.ItemReference (ItemReference)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:), (.:?))
import Data.Int (Int64)
import Data.Text (Text)


data RemoteItemFacet =
  RemoteItemFacet
  { remoteItemFacetId_ :: Text
  , remoteItemFacetParentReference :: Maybe ItemReference
  , remoteItemFacetFolder :: Maybe FolderFacet
  , remoteItemFacetFile :: Maybe FileFacet
  , remoteItemFacetFileSystemInfo :: Maybe FileSystemInfoFacet
  , remoteItemFacetSize :: Int64
  , remoteItemFacetWebUrl :: Text
  } deriving (Show)


instance FromJSON RemoteItemFacet where
  parseJSON (Object o) =
    RemoteItemFacet <$> o .: "id" <*> o .:? "parentReference" <*> o .:? "folder" <*> o .:? "file" <*> o .:? "fileSystemInfo" <*> o .: "size" <*> o .: "webUrl"
  parseJSON _ =
    error "Invalid RemoteItemFacet JSON"


makeLensesWith camelCaseFields ''RemoteItemFacet
