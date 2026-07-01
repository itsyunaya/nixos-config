{ pkgs, ... }: {
	programs.anyrun = {
		enable = true;

		config = {
			x = { fraction = 0.5; };
			y = { fraction = 0.25; };
			width = { absolute = 800; };
			height = { absolute = 1; };
			layer = "overlay";
			closeOnClick = true;

			plugins = [
				"${pkgs.anyrun}/lib/libapplications.so"
				"${pkgs.anyrun}/lib/librink.so"
				"${pkgs.anyrun}/lib/libshell.so"
			];
		};

		extraCss = builtins.readFile ./style.css;
	};
}
