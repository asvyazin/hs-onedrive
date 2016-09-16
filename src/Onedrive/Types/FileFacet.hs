{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.FileFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Onedrive.Types.HashesType (HashesType)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:), (.:?))
import Data.Text (Text)


data FileFacet =
  FileFacet
  { fileFacetMimeType :: Maybe Text
  , fileFacetHashes :: HashesType
  } deriving (Show)


instance FromJSON FileFacet where
  parseJSON (Object o) =
    FileFacet <$> o .:? "mimeType" <*> o .: "hashes"
  parseJSON _ =
    error "Invalid FileFacet JSON"


makeLensesWith camelCaseFields ''FileFacet
