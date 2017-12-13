module Web.XHR
  ( xmlHttpRequest
  , abort
  , getAllResponseHeaders
  , getResponseHeader
  , open
  , open'
  , overrideMimeType
  , send
  , sendString
  , sendDocument
  , sendBlob
  , sendFormData
  , setRequestHeader
  , readyState
  , response
  , responseURL
  , status
  , statusText
  , timeout
  , setTimeout
  , upload
  , withCredentials
  , setWithCredentials
  ) where

import Prelude

import Control.Monad.Eff (kind Effect, Eff)
import Control.Monad.Eff.Uncurried as Fn
import DOM.File.Types (Blob)
import DOM.Node.Types (Document)
import Data.Enum (toEnum)
import Data.Foreign (Foreign, toForeign)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Nullable (Nullable, toMaybe, toNullable)
import Data.Time.Duration (Milliseconds(..))
import Unsafe.Coerce (unsafeCoerce)
import Web.XHR.Types (FormData, ReadyState(..), ResponseType, XHR, XMLHttpRequest, XMLHttpRequestUpload)

xmlHttpRequest :: forall res eff. ResponseType res -> Eff (xhr :: XHR | eff) (XMLHttpRequest res)
xmlHttpRequest = Fn.runEffFn1 _xmlHttpRequest

abort :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
abort = Fn.runEffFn1 _abort

getAllResponseHeaders :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) (Maybe String)
getAllResponseHeaders xhr = toMaybe <$> Fn.runEffFn1 _getAllResponseHeaders xhr

getResponseHeader :: forall res eff. String -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) (Maybe String)
getResponseHeader header xhr = toMaybe <$> Fn.runEffFn2 _getResponseHeader header xhr

open :: forall res eff. String -> String -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
open method url xhr = Fn.runEffFn5 _open method url (toNullable Nothing) (toNullable Nothing) xhr

open' :: forall res eff. { method :: String, url :: String, username :: Maybe String, password :: Maybe String } -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
open' options xhr = Fn.runEffFn5 _open options.method options.url (toNullable options.username) (toNullable options.password) xhr

overrideMimeType :: forall res eff. String -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
overrideMimeType = Fn.runEffFn2 _overrideMimeType

send :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
send = Fn.runEffFn2 _send (toForeign (toNullable Nothing))

sendString :: forall res eff. String -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
sendString payload xhr = Fn.runEffFn2 _send (toForeign payload) xhr

sendBlob :: forall res eff. Blob -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
sendBlob payload xhr = Fn.runEffFn2 _send (toForeign payload) xhr

sendFormData :: forall res eff. FormData -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
sendFormData payload xhr = Fn.runEffFn2 _send (toForeign payload) xhr

sendDocument :: forall res eff. Document -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
sendDocument payload xhr = Fn.runEffFn2 _send (toForeign payload) xhr

setRequestHeader :: forall res eff. String -> String -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
setRequestHeader = Fn.runEffFn3 _setRequestHeader

readyState :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) ReadyState
readyState xhr = toReadyState <$> Fn.runEffFn2 _getProperty "readyState" xhr
  where
  toReadyState :: Foreign -> ReadyState
  toReadyState rs = fromMaybe ReadyStateUnsent $ toEnum (unsafeCoerce rs :: Int)

response :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) (Maybe res)
response xhr = toResponse <$> Fn.runEffFn2 _getProperty "response" xhr
  where
  toResponse :: Foreign -> Maybe res
  toResponse r = toMaybe (unsafeCoerce r :: Nullable res)

responseURL :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) String
responseURL xhr = (unsafeCoerce :: Foreign -> String) <$> Fn.runEffFn2 _getProperty "responseURL" xhr

status :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) Int
status xhr = (unsafeCoerce :: Foreign -> Int) <$> Fn.runEffFn2 _getProperty "status" xhr

statusText :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) String
statusText xhr = (unsafeCoerce :: Foreign -> String) <$> Fn.runEffFn2 _getProperty "statusText" xhr

timeout :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) Milliseconds
timeout xhr = toMillis <$> Fn.runEffFn2 _getProperty "statusText" xhr
  where
  toMillis :: Foreign -> Milliseconds
  toMillis m = Milliseconds (unsafeCoerce m)

setTimeout :: forall res eff. Milliseconds -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
setTimeout (Milliseconds ms) xhr = Fn.runEffFn3 _setProperty "timeout" (toForeign ms) xhr

upload :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) XMLHttpRequestUpload
upload xhr = (unsafeCoerce :: Foreign -> XMLHttpRequestUpload) <$> Fn.runEffFn2 _getProperty "upload" xhr

withCredentials :: forall res eff. XMLHttpRequest res -> Eff (xhr :: XHR | eff) Boolean
withCredentials xhr = (unsafeCoerce :: Foreign -> Boolean) <$> Fn.runEffFn2 _getProperty "withCredentials" xhr

setWithCredentials :: forall res eff. Boolean -> XMLHttpRequest res -> Eff (xhr :: XHR | eff) Unit
setWithCredentials wc xhr = Fn.runEffFn3 _setProperty "withCredentials" (toForeign wc) xhr

foreign import _xmlHttpRequest
  :: forall res eff
   . Fn.EffFn1 (xhr :: XHR | eff) (ResponseType res) (XMLHttpRequest res)

foreign import _abort
  :: forall res eff
   . Fn.EffFn1 (xhr :: XHR | eff) (XMLHttpRequest res) Unit

foreign import _getAllResponseHeaders
  :: forall res eff
   . Fn.EffFn1 (xhr :: XHR | eff) (XMLHttpRequest res) (Nullable String)

foreign import _getResponseHeader
  :: forall res eff
   . Fn.EffFn2 (xhr :: XHR | eff) String (XMLHttpRequest res) (Nullable String)

foreign import _open
  :: forall res eff
   . Fn.EffFn5 (xhr :: XHR | eff) String String (Nullable String) (Nullable String) (XMLHttpRequest res) Unit

foreign import _overrideMimeType
  :: forall res eff
   . Fn.EffFn2 (xhr :: XHR | eff) String (XMLHttpRequest res) Unit

foreign import _send
  :: forall res eff
   . Fn.EffFn2 (xhr :: XHR | eff) Foreign (XMLHttpRequest res) Unit

foreign import _setRequestHeader
  :: forall res eff
   . Fn.EffFn3 (xhr :: XHR | eff) String String (XMLHttpRequest res) Unit

foreign import _setProperty
  :: forall res eff
   . Fn.EffFn3 (xhr :: XHR | eff) String Foreign (XMLHttpRequest res) Unit

foreign import _getProperty
  :: forall res eff
   . Fn.EffFn2 (xhr :: XHR | eff) String (XMLHttpRequest res) Foreign
