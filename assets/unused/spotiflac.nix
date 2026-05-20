{ lib, buildGoModule, fetchFromGitHub, pkg-config, wails, webkitgtk_4_1, libsoup_3, gtk3, pnpm, fetchPnpmDeps, pnpmConfigHook, wrapGAppsHook4, gsettings-desktop-schemas, makeDesktopItem }:

buildGoModule rec {
	pname = "spotiflac";
	version = "7.1.6";

	src = fetchFromGitHub {
		owner = "spotbye";
		repo = "SpotiFLAC";
		tag = "v${version}";
		hash = "sha256-iQBJS2IsOzamC1plkd9BGbSajY9UpomaXMJRJgQ36t4=";
	};

	pnpmDeps = fetchPnpmDeps {
		inherit pname version src;
		sourceRoot = "${src.name}/frontend";
		fetcherVersion = 3;
		hash = "sha256-mecNGWbUATjNl1uWByxE1W1b8tfNyPIRMndcZSBl+XM=";
	};

	vendorHash = "sha256-ZhrUZiG5T1Kz93Tcs3At1pTEMdaMYYLM4lPzyVqVfOs=";

	proxyVendor = true;

	nativeBuildInputs = [ pkg-config wails pnpm pnpmConfigHook wrapGAppsHook4 ];
	buildInputs = [ webkitgtk_4_1 libsoup_3 gtk3 gsettings-desktop-schemas ];

	desktopItems = [
		(makeDesktopItem {
			name = "SpotiFLAC";
			exec = "SpotiFLAC";
			icon = "spotiflac";
			comment = "Download Spotify tracks in FLAC";
			desktopName = "SpotiFLAC";
			categories = [ "AudioVideo" "Audio" ];
		})
	];

	pnpmRoot = "frontend";

	preBuild = ''
		export HOME=$(mktemp -d)

		mkdir -p frontend/dist
		touch frontend/dist/init

		wails generate module

		pnpm --prefix frontend run build
	'';

	buildPhase = ''
		runHook preBuild
		go build -tags desktop,production,webkit2_41 -o build/bin/SpotiFLAC .
		runHook postBuild
	'';

	installPhase = ''
		runHook preInstall
		install -Dm755 build/bin/SpotiFLAC $out/bin/SpotiFLAC
		install -Dm644 frontend/public/icon.svg $out/share/icons/hicolor/scalable/apps/spotiflac.svg

		mkdir -p $out/share/applications
		for item in $desktopItems; do
			cp -r "$item/share/applications/." $out/share/applications/
		done

		runHook postInstall
	'';

	meta = {
		description = "Get Spotify tracks in true FLAC from Tidal, Qobuz & Amazon Music";
		homepage = "https://github.com/spotbye/SpotiFLAC";
		license = lib.licenses.mit;
		mainProgram = "SpotiFLAC";
	};
}