{-# LANGUAGE OverloadedStrings #-}
module Onedrive.Auth (requestToken, requestRefreshToken, me) where


import Control.Lens ((^.))
import Control.Monad.Catch (MonadThrow)
import Control.Monad.IO.Class (MonadIO)
import Data.ByteString (ByteString)
import Data.Monoid ((<>))
import Data.Text (Text)
import Data.Text.Encoding (encodeUtf8)
import Onedrive.Types.OauthTokenRequest (OauthTokenRequest, clientId, redirectUri, clientSecret)
import Onedrive.Types.OauthTokenResponse (OauthTokenResponse)
import Onedrive.Types.UserInfo (UserInfo)
import Network.HTTP.Simple (parseRequest, httpJSON, getResponseBody, setRequestHeaders, setRequestMethod, setRequestBodyURLEncoded)
import Network.HTTP.Types.Header (hAuthorization)


requestToken :: (MonadThrow m, MonadIO m) => OauthTokenRequest -> Text -> m OauthTokenResponse
requestToken req code = do
  initReq <- parseRequest "https://login.live.com/oauth20_token.srf"
  let
    initParams =
      serializeOauthTokenRequest req
    params =
      [ ("code", encodeUtf8 code)
      , ("grant_type", "authorization_code")
      ] ++ initParams
    httpReq =
      setRequestMethod "POST" $ setRequestBodyURLEncoded params initReq
  getResponseBody <$> httpJSON httpReq


requestRefreshToken :: (MonadThrow m, MonadIO m) => OauthTokenRequest -> Text -> m OauthTokenResponse
requestRefreshToken req tok = do
  initReq <- parseRequest "https://login.live.com/oauth20_token.srf"
  let
    initParams =
      serializeOauthTokenRequest req
    params =
      [ ("refresh_token", encodeUtf8 tok)
      , ("grant_type", "refresh_token")
      ] ++ initParams
    httpReq =
      setRequestMethod "POST" $ setRequestBodyURLEncoded params initReq
  getResponseBody <$> httpJSON httpReq


me :: (MonadThrow m, MonadIO m) => Text -> m UserInfo
me token = do
  initReq <- parseRequest "https://apis.live.net/v5.0/me"
  let
    httpReq =
      setRequestHeaders [(hAuthorization, encodeUtf8 ("Bearer " <> token))] initReq
  getResponseBody <$> httpJSON httpReq


serializeOauthTokenRequest :: OauthTokenRequest -> [(ByteString, ByteString)]
serializeOauthTokenRequest req =
  [ ("client_id",  encodeUtf8 $ req ^. clientId)
  , ("redirect_uri",  encodeUtf8 $ req ^. redirectUri)
  , ("client_secret",  encodeUtf8 $ req ^. clientSecret)
  ]
