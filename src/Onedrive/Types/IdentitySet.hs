{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.IdentitySet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Onedrive.Types.Identity (Identity)
import Data.Aeson (FromJSON(parseJSON), Value(Object), (.:?))


data IdentitySet =
  IdentitySet
  { identitySetUser :: Maybe Identity
  , identitySetApplication :: Maybe Identity
  , identitySetDevice :: Maybe Identity
  , identitySetOrganization :: Maybe Identity
  } deriving (Show)


instance FromJSON IdentitySet where
  parseJSON (Object o) =
    IdentitySet <$> o .:? "user" <*> o .:? "application" <*> o .:? "device" <*> o .:? "organization"
  parseJSON _ =
    error "Invalid IdentitySet JSON"


makeLensesWith camelCaseFields ''IdentitySet
