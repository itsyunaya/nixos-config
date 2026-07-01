_: {
	programs.keychain = {
		enable = true;
		enableZshIntegration = true;

		extraFlags = [ "--quiet" "--noask" ];
		keys = [
			"id_ed25519"
			"id_ed25519_cl"
			"ceres_key"
		];

	};
}
