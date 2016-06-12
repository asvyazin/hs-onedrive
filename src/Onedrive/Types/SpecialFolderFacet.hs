{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.SpecialFolderFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:))
import Data.Text (Text)


data SpecialFolderFacet =
  SpecialFolderFacet
  { specialFolderFacetName :: Text
  } deriving (Show)


instance FromJSON SpecialFolderFacet where
  parseJSON (Object o) =
    SpecialFolderFacet <$> o .: "name"
  parseJSON _ =
    error "Invalid SpecialFolderFacet JSON"


makeLensesWith camelCaseFields ''SpecialFolderFacet
