module Onedrive.Internal.Response (json, lbs) where


import Control.Monad (void)
import Control.Monad.Catch (MonadThrow(throwM))
import Control.Monad.IO.Class (MonadIO(liftIO))
import Data.Aeson (FromJSON)
import Data.ByteString (empty)
import Data.ByteString.Lazy (ByteString)
import Network.HTTP.Conduit (HttpExceptionContent(StatusCodeException))
import Network.HTTP.Simple (HttpException(HttpExceptionRequest), Request, Response, httpJSONEither, httpLBS, getResponseStatus, getResponseBody)
import Network.HTTP.Types.Status (unauthorized401, ok200)
import Onedrive.Auth (authorizeRequest)
import Onedrive.Session (Session, tryRenewToken)


json :: (MonadThrow m, MonadIO m, FromJSON a) => Session -> Request -> m a
json session req =
  doRequest True session req httpJSONEither processBody
  where
    processBody (Left e) = throwM e
    processBody (Right res) = return res


lbs :: (MonadThrow m, MonadIO m) => Session -> Request -> m ByteString
lbs session req =
  doRequest True session req httpLBS return


doRequest :: (MonadThrow m, MonadIO m) => Bool -> Session -> Request -> (Request -> m (Response b)) -> (b -> m a) -> m a
doRequest allowRenew session req getResponse processBody = do
  authReq <- liftIO $ authorizeRequest session req
  resp <- getResponse authReq
  let
    responseStatus =
      getResponseStatus resp
    throwException =
      throwM $ HttpExceptionRequest req $ StatusCodeException (void resp) empty
  if responseStatus == ok200
    then
    processBody $ getResponseBody resp
    else
    if responseStatus == unauthorized401 && allowRenew
    then do
      newAccessToken <- liftIO $ tryRenewToken session
      case newAccessToken of
        Nothing ->
          throwException
        Just _ ->
          doRequest False session req getResponse processBody
    else
      throwException
