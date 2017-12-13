module Web.XHR.Types
  ( XHR
  , XMLHttpRequest
  , XMLHttpRequestUpload
  , ReadyState(..)
  , ResponseType
  , FormData
  , string
  , blob
  , document
  , unsafeResponseType
  , xmlHttpRequestToEventTarget
  , xmlHttpRequestUploadToEventTarget
  ) where

import Prelude

import Control.Monad.Eff (kind Effect)
import DOM.Event.Types (EventTarget)
import DOM.File.Types (Blob)
import DOM.Node.Types (Document)
import Data.Enum (class BoundedEnum, class Enum, Cardinality(..), defaultPred, defaultSucc, fromEnum, toEnum)
import Data.Maybe (Maybe(..))
import Type.Proxy (Proxy)
import Unsafe.Coerce (unsafeCoerce)

foreign import data XHR :: Effect

-- | `XMLHttpRequest`s are indexed by their `ResponseType`
foreign import data XMLHttpRequest :: Type -> Type

foreign import data XMLHttpRequestUpload :: Type

foreign import data FormData :: Type

data ReadyState
  = ReadyStateUnsent
  | ReadyStateOpened
  | ReadyStateHeadersReceived
  | ReadyStateLoading
  | ReadyStateDone

derive instance eqReadyState :: Eq ReadyState
derive instance ordReadyState :: Ord ReadyState

instance boundedReadyState :: Bounded ReadyState where
  bottom = ReadyStateUnsent
  top = ReadyStateDone

instance enumReadyState :: Enum ReadyState where
  succ = defaultSucc toEnum fromEnum
  pred = defaultPred toEnum fromEnum

instance boundedEnumReadyState :: BoundedEnum ReadyState where
  cardinality = Cardinality 5
  toEnum = toEnumReadyState
  fromEnum = fromEnumReadyState

newtype ResponseType res = ResponseType String

string :: ResponseType String
string = ResponseType ""

blob :: ResponseType Blob
blob = ResponseType "blob"

document :: ResponseType Document
document = ResponseType "document"

unsafeResponseType :: forall res. Proxy res -> String -> ResponseType res
unsafeResponseType _ = ResponseType

xmlHttpRequestToEventTarget :: forall res. XMLHttpRequest res -> EventTarget
xmlHttpRequestToEventTarget = unsafeCoerce

xmlHttpRequestUploadToEventTarget :: XMLHttpRequestUpload -> EventTarget
xmlHttpRequestUploadToEventTarget = unsafeCoerce

toEnumReadyState :: Int -> Maybe ReadyState
toEnumReadyState = case _ of
  0 -> Just ReadyStateUnsent
  1 -> Just ReadyStateOpened
  2 -> Just ReadyStateHeadersReceived
  3 -> Just ReadyStateLoading
  4 -> Just ReadyStateDone
  _ -> Nothing

fromEnumReadyState :: ReadyState -> Int
fromEnumReadyState = case _ of
  ReadyStateUnsent -> 0
  ReadyStateOpened -> 1
  ReadyStateHeadersReceived -> 2
  ReadyStateLoading -> 3
  ReadyStateDone -> 4
