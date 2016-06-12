{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.OauthTokenRequest where


import Control.Lens (makeLensesWith, camelCaseFields)
import qualified Data.Text as T


data OauthTokenRequest =
  OauthTokenRequest
  { oauthTokenRequestClientId :: T.Text
  , oauthTokenRequestRedirectUri :: T.Text
  , oauthTokenRequestClientSecret :: T.Text
  } deriving (Eq, Show)


makeLensesWith camelCaseFields ''OauthTokenRequest
