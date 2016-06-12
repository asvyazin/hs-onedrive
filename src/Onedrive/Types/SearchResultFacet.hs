{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.SearchResultFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:))
import Data.Text (Text)


data SearchResultFacet =
  SearchResultFacet
  { searchResultFacetOnClickTelemetryUrl :: Text
  } deriving (Show)


instance FromJSON SearchResultFacet where
  parseJSON (Object o) =
    SearchResultFacet <$> o .: "onClickTelemetryUrl"
  parseJSON _ =
    error "Invalid SearchResultFacet JSON"


makeLensesWith camelCaseFields ''SearchResultFacet
