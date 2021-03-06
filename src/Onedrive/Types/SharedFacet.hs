{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
module Onedrive.Types.SharedFacet where


import Control.Lens (makeLensesWith, camelCaseFields)
import Onedrive.Types.IdentitySet (IdentitySet)
import Data.Aeson (FromJSON(parseJSON), Value(Object, String), (.:))


data SharedFacet =
  SharedFacet
  { sharedFacetOwner :: IdentitySet
  , sharedFacetScope :: SharedFacetScope
  } deriving (Show)


data SharedFacetScope =
  SharedFacetScopeAnonymous |
  SharedFacetScopeOrganization |
  SharedFacetScopeUsers
  deriving (Show)


instance FromJSON SharedFacet where
  parseJSON (Object o) =
    SharedFacet <$> o .: "owner" <*> o .: "scope"
  parseJSON _ =
    error "Invalid SharedFacet JSON"


instance FromJSON SharedFacetScope where
  parseJSON (String "anonymous") =
    return SharedFacetScopeAnonymous
  parseJSON (String "organization") =
    return SharedFacetScopeOrganization
  parseJSON (String "users") =
    return SharedFacetScopeUsers
  parseJSON _ =
    error "Invalid SharedFacetScope JSON"


makeLensesWith camelCaseFields ''SharedFacetScope
