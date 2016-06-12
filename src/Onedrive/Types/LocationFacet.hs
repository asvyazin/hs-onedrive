{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.LocationFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:))


data LocationFacet =
  LocationFacet
  { locationFacetAttitude :: Double
  , locationFacetLatitude :: Double
  , locationFacetLongitude :: Double
  } deriving (Show)


instance FromJSON LocationFacet where
  parseJSON (Object o) =
    LocationFacet <$> o .: "attitude" <*> o .: "latitude" <*> o .: "longitude"
  parseJSON _ =
    error "Invalid LocationFacet JSON"


makeLensesWith camelCaseFields ''LocationFacet
