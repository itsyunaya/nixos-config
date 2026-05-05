{ pkgs, ... }:

{
	programs.eza = {
		enable = true;
		enableZshIntegration = true;
	};
	
	programs.git = {
		enable = true;

		settings = {
			user.name = "itsyunaya";
			# dont use actual email cuz i dont wanna dox myself yk
			user.email = "40719746+itsyunaya@users.noreply.github.com";
			user.signingKey = "198EA594738FED19";
			commit.gpgsign = true;
			tag.gpgSign = true;
		};
	};

	programs.yazi = {
		enable = true;
		enableZshIntegration = true;
		shellWrapperName = "y";
	};
}
