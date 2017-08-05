{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, aeson, base, bytestring, conduit
      , conduit-combinators, exceptions, http-client, http-conduit
      , http-types, lens, mtl, stdenv, stm, text, transformers
      }:
      mkDerivation {
        pname = "hs-onedrive";
        version = "0.1.0.0";
        src = ./.;
        libraryHaskellDepends = [
          aeson base bytestring conduit conduit-combinators exceptions
          http-client http-conduit http-types lens mtl stm text transformers
        ];
        testHaskellDepends = [ base ];
        homepage = "https://github.com/asvyazin/hs-onedrive#readme";
        description = "Haskell bindings to the Onedrive API";
        license = stdenv.lib.licenses.bsd3;
        doHaddock = false;
        doCheck = false;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
