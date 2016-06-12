{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.Identity where


import Control.Lens (makeLensesWith, camelCaseFields)
import Onedrive.Types.ThumbnailSet (ThumbnailSet)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:), (.:?))
import Data.Text (Text)


data Identity =
  Identity
  { identityId_ :: Text
  , identityDisplayName :: Maybe Text
  , identityThumbnails :: Maybe ThumbnailSet
  } deriving (Show)


instance FromJSON Identity where
  parseJSON (Object o) =
    Identity <$> o .: "id" <*> o .:? "displayName" <*> o .:? "thumbnails"
  parseJSON _ =
    error "Invalid Identity JSON"


makeLensesWith camelCaseFields ''Identity
