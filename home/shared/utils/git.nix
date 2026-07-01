{ pkgs, ... }: let
	signkey =
		if pkgs.stdenv.isDarwin
		then "2E7FD19FA57EEAA4"
		else "198EA594738FED19";
in {
	programs.git = {
		enable = true;

		settings = {
			user = {
				name = "itsyunaya";
				# dont use actual email cuz i dont wanna dox myself yk
				email = "40719746+itsyunaya@users.noreply.github.com";
				signingKey = signkey;
			};
			commit.gpgsign = true;
			tag.gpgSign = true;
			init.defaultBranch = "main";
		};
	};
}
