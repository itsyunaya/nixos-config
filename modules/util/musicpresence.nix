{ pkgs }:

pkgs.appimageTools.wrapType1 {
	pname = "musicpresence";
	version = "2.3.5";

	src = pkgs.fetchurl {
		# need to MANUALLY update this every time since musicpresence is evil and not in nixpkgs
		url = "https://github.com/ungive/discord-music-presence/releases/download/v2.3.5/musicpresence-2.3.5-linux-x86_64.AppImage";
		sha256 = "sha256-M7oDxVevspA3SGuHktS8ChQAYopgIqypiVlzyE4uyqI=";
	};
}
