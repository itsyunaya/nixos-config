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
			user.email = "40719746+itsyunaya@users.noreply.github.com";
			# dont use actual email cuz i dont wanna dox myself yk
			user.signingKey = "B3EE0ADBEDC6F44F";
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
