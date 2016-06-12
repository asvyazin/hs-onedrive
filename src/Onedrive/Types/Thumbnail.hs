{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.Thumbnail where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), (.:), Value(Object))
import Data.Text (Text)


data Thumbnail =
  Thumbnail
  { thumbnailWidth :: Int
  , thumbnailHeight :: Int
  , thumbnailUrl :: Text
  } deriving (Show)


instance FromJSON Thumbnail where
  parseJSON (Object o) =
    Thumbnail <$> o .: "width" <*> o .: "height" <*> o .: "url"
  parseJSON _ =
    error "Invalid Thumbnail JSON"


makeLensesWith camelCaseFields ''Thumbnail
