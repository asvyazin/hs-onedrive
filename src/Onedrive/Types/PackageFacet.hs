{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.PackageFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:))
import Data.Text (Text)


data PackageFacet =
  PackageFacet
  { packageFacetType_ :: Text
  } deriving (Show)


instance FromJSON PackageFacet where
  parseJSON (Object o) =
    PackageFacet <$> o .: "type"
  parseJSON _ =
    error "Invalid PackageFacet JSON"


makeLensesWith camelCaseFields ''PackageFacet
