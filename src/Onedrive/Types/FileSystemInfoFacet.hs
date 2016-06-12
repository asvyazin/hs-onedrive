{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.FileSystemInfoFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:))
import Data.Text (Text)


data FileSystemInfoFacet =
  FileSystemInfoFacet
  { fileSystemInfoFacetCreatedDateTime :: Text
  , fileSystemInfoFacetLastModifiedDateTime :: Text
  } deriving (Show)


instance FromJSON FileSystemInfoFacet where
  parseJSON (Object o) =
    FileSystemInfoFacet <$> o .: "createdDateTime" <*> o .: "lastModifiedDateTime"
  parseJSON _ =
    error "Invalid FileSystemInfoFacet JSON"


makeLensesWith camelCaseFields ''FileSystemInfoFacet
