{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.DeletedFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:))
import Data.Text (Text)


data DeletedFacet =
  DeletedFacet
  { deletedFacetState :: Text
  } deriving (Show)


instance FromJSON DeletedFacet where
  parseJSON (Object o) =
    DeletedFacet <$> o .: "state"
  parseJSON _ =
    error "Invalid DeletedFacet JSON"


makeLensesWith camelCaseFields ''DeletedFacet
