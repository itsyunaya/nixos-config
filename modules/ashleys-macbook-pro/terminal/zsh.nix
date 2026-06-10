{ lib, ... }:

{
	programs.zsh = {
		enable = true;

		autocd = true;

		autosuggestion.enable = true;
		syntaxHighlighting = {
			enable = true;

			# todo: move normal cfg here
		};

		shellAliases = {
			rb = "sudo darwin-rebuild switch --flake ~/.config/nix";
		};

		initContent = ''
			eval "$(/opt/homebrew/bin/brew shellenv)"
			PROMPT="%{%F{#c6a0f6}%}[%{%F{#fefefe}%}%n%{%F{#c6a0f6}%}@%{%F{#fefefe}%}%m%{%F{#c6a0f6}%}] (%{%F{#fefefe}%}%1~%{%F{#c6a0f6}%}) %{%f%}$ "
		'';
	};
}