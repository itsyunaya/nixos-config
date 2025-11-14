{ pkgs }:

pkgs.appimageTools.wrapType1 {
        pname = "musicpresence";
        version = "2.3.4";

        src = pkgs.fetchurl {
                # need to MANUALLY update this every time since musicpresence is evil and not in nixpkgs
                url = "https://github.com/ungive/discord-music-presence/releases/download/v2.3.4/musicpresence-2.3.4-linux-x86_64.AppImage";
                sha256 = "sha256-S8VHs81wbVv5Z1lncSIYJDUHRfUBl40WU+P3QTQROp0=";
        };
}
