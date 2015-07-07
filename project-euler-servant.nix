{ mkDerivation, aeson, base, bytestring, containers, either
, project-euler, servant, servant-server, stdenv, text, time, wai
, warp
}:
mkDerivation {
  pname = "project-euler-servant";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    aeson base bytestring containers either project-euler servant
    servant-server text time wai warp
  ];
  license = stdenv.lib.licenses.unfree;
}
