{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.HashesType where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:?))
import Data.Text (Text)


data HashesType =
  HashesType
  { hashesTypeCrc32Hash :: Maybe Text
  , hashesTypeSha1Hash :: Maybe Text
  } deriving (Show)


instance FromJSON HashesType where
  parseJSON (Object o) =
    HashesType <$> o .:? "crc32Hash" <*> o .:? "sha1Hash"
  parseJSON _ =
    error "Invalid HashesType JSON"


makeLensesWith camelCaseFields ''HashesType
