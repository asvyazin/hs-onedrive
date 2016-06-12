{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.ImageFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:))


data ImageFacet =
  ImageFacet
  { imageFacetWidth :: Int
  , imageFacetHeight :: Int
  } deriving (Show)


instance FromJSON ImageFacet where
  parseJSON (Object o) =
    ImageFacet <$> o .: "width" <*> o .: "height"
  parseJSON _ =
    error "Invalid ImageFacet JSON"


makeLensesWith camelCaseFields ''ImageFacet
