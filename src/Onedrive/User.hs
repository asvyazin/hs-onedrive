module Onedrive.User (me) where


import Control.Concurrent.STM.TVar (TVar)
import Control.Monad.Catch (MonadThrow)
import Control.Monad.IO.Class (MonadIO)
import Data.Text (Text)
import Network.HTTP.Simple (parseRequest)
import Onedrive.Internal.Response (json)
import Onedrive.Session (Session)
import Onedrive.Types.UserInfo (UserInfo)


me :: (MonadThrow m, MonadIO m) => Session -> m UserInfo
me session = do
  initReq <- parseRequest "https://apis.live.net/v5.0/me"
  json session initReq
