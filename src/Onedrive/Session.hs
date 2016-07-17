module Onedrive.Session (Session, newSessionWithToken, newSessionWithRenewableToken, getAccessToken, tryRenewToken) where


import Control.Concurrent.STM (atomically)
import Control.Concurrent.STM.TVar (TVar, newTVar, readTVar, writeTVar)
import Data.Text (Text)


data Session
  = SessionWithToken Text
  | SessionWithRenewableToken (TVar Text) (IO Text)


newSessionWithToken :: Text -> IO Session
newSessionWithToken accessToken =
  return $ SessionWithToken accessToken


newSessionWithRenewableToken :: Text -> IO Text -> IO Session
newSessionWithRenewableToken accessToken renewAccessToken = do
  tokenStore <- atomically $ newTVar accessToken
  return $ SessionWithRenewableToken tokenStore renewAccessToken


getAccessToken :: Session -> IO Text
getAccessToken (SessionWithToken accessToken) =
  return accessToken
getAccessToken (SessionWithRenewableToken accessToken _) =
  atomically $ readTVar accessToken


tryRenewToken :: Session -> IO (Maybe Text)
tryRenewToken (SessionWithToken _) =
  return Nothing
tryRenewToken (SessionWithRenewableToken accessToken renewAccessToken) = do
  newAccessToken <- renewAccessToken
  atomically $ writeTVar accessToken newAccessToken
  return $ Just newAccessToken
