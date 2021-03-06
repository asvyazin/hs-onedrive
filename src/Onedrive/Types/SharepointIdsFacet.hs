{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.SharepointIdsFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:))
import Data.Int (Int64)
import Data.Text (Text)


data SharepointIdsFacet =
  SharepointIdsFacet
  { sharepointIdsFacetSiteId :: Text
  , sharepointIdsFacetWebId :: Text
  , sharepointIdsFacetListId :: Text
  , sharepointIdsFacetListItemId :: Int64
  , sharepointIdsFacetListItemUniqueId :: Text
  } deriving (Show)


instance FromJSON SharepointIdsFacet where
  parseJSON (Object o) =
    SharepointIdsFacet <$> o .: "siteId" <*> o .: "webId" <*> o .: "listId" <*> o .: "listItemId" <*> o .: "listItemUniqueId"
  parseJSON _ =
    error "Invalid SharepointIdsFacet JSON"


makeLensesWith camelCaseFields ''SharepointIdsFacet
