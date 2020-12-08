{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "web-xhr"
, dependencies =
  [ "arraybuffer-types"
  , "datetime"
  , "http-methods"
  , "psci-support"
  , "web-dom"
  , "web-file"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
