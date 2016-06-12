{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.ItemReference where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:), (.:?))
import Data.Text (Text)


data ItemReference =
  ItemReference
  { itemReferenceDriveId :: Text
  , itemReferenceId_ :: Text
  , itemReferencePath :: Maybe Text
  } deriving (Show)


instance FromJSON ItemReference where
  parseJSON (Object o) =
    ItemReference <$> o .: "driveId" <*> o .: "id" <*> o .:? "path"
  parseJSON _ =
    error "Invalid ItemReference JSON"


makeLensesWith camelCaseFields ''ItemReference
