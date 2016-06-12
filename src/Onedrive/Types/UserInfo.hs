{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.UserInfo where


import Control.Lens (makeLensesWith, camelCaseFields)
import Data.Aeson (FromJSON(parseJSON), (.:), Value(Object))
import Data.Aeson.Types (typeMismatch)
import Data.Text (Text)


data UserInfo =
  UserInfo
  { userInfoId_ :: Text
  , userInfoDisplayName :: Text
  } deriving (Eq, Show)


instance FromJSON UserInfo where
  parseJSON (Object o) =
    UserInfo
    <$> o .: "id"
    <*> o .: "name"

  parseJSON invalid =
    typeMismatch "UserInfo" invalid


makeLensesWith camelCaseFields ''UserInfo
