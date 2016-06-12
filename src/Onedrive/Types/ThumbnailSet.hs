{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.ThumbnailSet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Onedrive.Types.Thumbnail (Thumbnail)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:), (.:?))
import Data.Text (Text)


data ThumbnailSet =
  ThumbnailSet
  { thumbnailSetId_ :: Text
  , thumbnailSmall :: Maybe Thumbnail
  , thumbnailMedium :: Maybe Thumbnail
  , thumbnailLarge :: Maybe Thumbnail
  , thumbnailSource :: Maybe Thumbnail
  } deriving (Show)


instance FromJSON ThumbnailSet where
  parseJSON (Object o) =
    ThumbnailSet <$> o .: "id" <*> o.:? "small" <*> o .:? "medium" <*> o .:? "large" <*> o .:? "source"
  parseJSON _ =
    error "Invalid ThumbnailSet JSON"


makeLensesWith camelCaseFields ''ThumbnailSet
