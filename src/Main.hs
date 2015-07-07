{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

import Control.Monad.Trans.Either (left)
import Data.Aeson
  ( ToJSON
  , toJSON
  , object
  , (.=)
  )
import qualified Data.ByteString.Lazy.Char8 as C
import qualified Data.Text as T
import qualified Data.Map as M
import Network.Wai (Application)
import Network.Wai.Handler.Warp (run)
import Servant
  ( (:<|>)((:<|>))
  , (:>)
  , Capture
  , Get
  , JSON
  , Proxy(Proxy)
  , Server
  , err404
  , errBody
  , serve
  )

import Euler.Lib.Solution (Solution)
import Euler.Problems (solvers)

instance ToJSON Solution where
  toJSON s = object ["solution" .= T.pack (show s)]

type EulerAPI = "solve" :> Capture "problem" Int :> Get '[JSON] Solution

server :: Server EulerAPI
server = solve
  where
  solve p = case M.lookup p solvers of
    Just result -> return result
    Nothing -> left err404 { errBody = C.pack ("no solution for problem " ++ show p) }

eulerAPI :: Proxy EulerAPI
eulerAPI = Proxy

app :: Application
app = serve eulerAPI server

main :: IO ()
main = run 8000 app
