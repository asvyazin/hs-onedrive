{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.OnedriveItem where


import Onedrive.Types.AudioFacet (AudioFacet)
import Onedrive.Types.DeletedFacet (DeletedFacet)
import Onedrive.Types.FileFacet (FileFacet)
import Onedrive.Types.FileSystemInfoFacet (FileSystemInfoFacet)
import Onedrive.Types.FolderFacet (FolderFacet)
import Onedrive.Types.IdentitySet (IdentitySet)
import Onedrive.Types.ImageFacet (ImageFacet)
import Onedrive.Types.ItemReference (ItemReference)
import Onedrive.Types.LocationFacet (LocationFacet)
import Onedrive.Types.PackageFacet (PackageFacet)
import Onedrive.Types.PhotoFacet (PhotoFacet)
import Onedrive.Types.RemoteItemFacet (RemoteItemFacet)
import Onedrive.Types.SearchResultFacet (SearchResultFacet)
import Onedrive.Types.SharedFacet (SharedFacet)
import Onedrive.Types.SharepointIdsFacet (SharepointIdsFacet)
import Onedrive.Types.SpecialFolderFacet (SpecialFolderFacet)
import Onedrive.Types.VideoFacet (VideoFacet)
import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:), (.:?))
import Data.Int (Int64)
import Data.Text (Text)


data OnedriveItem =
  OnedriveItem
  { onedriveItemId_ :: Text
  , onedriveItemAudio :: Maybe AudioFacet
  , onedriveItemCreatedBy :: IdentitySet
  , onedriveItemCreatedDateTime :: Text
  , onedriveItemCTag :: Text
  , onedriveItemDeleted :: Maybe DeletedFacet
  , onedriveItemDescription :: Maybe Text
  , onedriveItemETag :: Text
  , onedriveItemFile :: Maybe FileFacet
  , onedriveItemFileSystemInfo :: FileSystemInfoFacet
  , onedriveItemFolder :: Maybe FolderFacet
  , onedriveItemImage :: Maybe ImageFacet
  , onedriveItemLastModifiedBy :: IdentitySet
  , onedriveItemLastModifiedDateTime :: Text
  , onedriveItemLocation :: Maybe LocationFacet
  , onedriveItemName :: Text
  , onedriveItemPackage :: Maybe PackageFacet
  , onedriveItemParentReference :: Maybe ItemReference
  , onedriveItemPhoto :: Maybe PhotoFacet
  , onedriveItemRemoteItem :: Maybe RemoteItemFacet
  , onedriveItemSearchResult :: Maybe SearchResultFacet
  , onedriveItemShared :: Maybe SharedFacet
  , onedriveItemSharepointIds :: Maybe SharepointIdsFacet
  , onedriveItemSize :: Int64
  , onedriveItemSpecialFolder :: Maybe SpecialFolderFacet
  , onedriveItemVideo :: Maybe VideoFacet
  , onedriveItemWebDavUrl :: Maybe Text
  , onedriveItemWebUrl :: Text
  } deriving (Show)


instance FromJSON OnedriveItem where
  parseJSON (Object o) =
    OnedriveItem <$>
    o .: "id" <*>
    o .:? "audio" <*>
    o .: "createdBy" <*>
    o .: "createdDateTime" <*>
    o .: "cTag" <*>
    o .:? "deleted" <*>
    o .:? "description" <*>
    o .: "eTag" <*>
    o .:? "file" <*>
    o .: "fileSystemInfo" <*>
    o .:? "folder" <*>
    o .:? "image" <*>
    o .: "lastModifiedBy" <*>
    o .: "lastModifiedDateTime" <*>
    o .:? "location" <*>
    o .: "name" <*>
    o .:? "package" <*>
    o .:? "parentReference" <*>
    o .:? "photo" <*>
    o .:? "remoteItem" <*>
    o .:? "searchResult" <*>
    o .:? "shared" <*>
    o .:? "sharepointIds" <*>
    o .: "size" <*>
    o .:? "specialFolder" <*>
    o .:? "video" <*>
    o .:? "webDavUrl" <*>
    o .: "webUrl"
  parseJSON _ =
    error "Invalid OnedriveItem JSON"


makeLensesWith camelCaseFields ''OnedriveItem
