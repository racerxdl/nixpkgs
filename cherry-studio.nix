{
  lib,
  appimageTools,
  fetchurl,
}:
let
  version = "1.7.19";
  pname = "cherry-studio";
  src = fetchurl {
    url = "https://github.com/CherryHQ/cherry-studio/releases/download/v${version}/Cherry-Studio-${version}-x86_64.AppImage";
    # Keep the hash you calculated earlier
    hash = "sha256-z23Rqt0qAM0JtoMWwy2XCwnDjFo+3nB+706lK0ZrWaw=";
  };
  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;
  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/*.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/*.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
  '';
  meta = {
    description = "Cherry Studio AI Client";
    license = lib.licenses.asl20;
    platforms = [ "x86_64-linux" ];
  };
}
