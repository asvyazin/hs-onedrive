module Onedrive.User (me) where


import Control.Monad.Catch (MonadThrow)
import Control.Monad.IO.Class (MonadIO)
import Data.Text (Text)
import Network.HTTP.Simple (parseRequest, httpJSON, getResponseBody)
import Onedrive.Auth (authorizeRequest)
import Onedrive.Types.UserInfo (UserInfo)


me :: (MonadThrow m, MonadIO m) => Text -> m UserInfo
me token = do
  initReq <- parseRequest "https://apis.live.net/v5.0/me"
  getResponseBody <$> httpJSON (authorizeRequest token initReq)
