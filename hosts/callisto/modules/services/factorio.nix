{ lib, pkgs, ... }: {
	services.factorio = {
		enable = true;
		openFirewall = true;
		loadLatestSave = true;
		description = "meow meow meow meow meow meow";

		admins = [ "itsyunaya" ];
		# allowedPlayers = [ "itsyunaya" "lei" ];
		requireUserVerification = false;

		game-name = "ashley factorio server";
		# TODO: secrets management
		game-password = "meow";

		/*mods = let
			modDir = /home/callisto/factorio-mods;

			modList = lib.pipe modDir [
				builtins.readDir
				(lib.filterAttrs (k: v: v == "regular"))
				(lib.mapAttrsToList (k: v: k))
				(builtins.filter (lib.hasSuffix ".zip"))
			];

			validPath = modFileName:
				builtins.path {
					path = modDir + "/${modFileName}";
					name = lib.strings.sanitizeDerivationName modFileName;
				};

			modToDrv = modFileName:
				pkgs.runCommand "copy-factorio-mods" {} ''
					mkdir $out
					ln -s '${validPath modFileName}' $out/'${modFileName}'
				''
				// { deps = []; };
		in
			map modToDrv modList;*/
	};
}
