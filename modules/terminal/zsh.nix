{ ... }:

{
    programs.zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion = {
	enable = true;
      };

      shellAliases = {
        nr = "sudo nixos-rebuild switch --flake /home/ashley/sysflake\\#nixos";
      };

      syntaxHighlighting = {
	enable = true;

	styles = {
	 # Comments
          comment = "fg=#5b6078";

          # Functions / commands
          alias = "fg=#a6da95";
          suffix-alias = "fg=#a6da95";
          global-alias = "fg=#a6da95";
          function = "fg=#a6da95";
          command = "fg=#a6da95";
          precommand = "fg=#a6da95,italic";
          autodirectory = "fg=#f5a97f,italic";
          single-hyphen-option = "fg=#f5a97f";
          double-hyphen-option = "fg=#f5a97f";
          back-quoted-argument = "fg=#c6a0f6";

          # Builtins / keywords
          builtin = "fg=#a6da95";
          reserved-word = "fg=#a6da95";
          hashed-command = "fg=#a6da95";

          # Punctuation
          commandseparator = "fg=#ed8796";
          command-substitution-delimiter = "fg=#cad3f5";
          command-substitution-delimiter-unquoted = "fg=#cad3f5";
          process-substitution-delimiter = "fg=#cad3f5";
          back-quoted-argument-delimiter = "fg=#ed8796";
          back-double-quoted-argument = "fg=#ed8796";
          back-dollar-quoted-argument = "fg=#ed8796";

          # Strings
          command-substitution-quoted = "fg=#eed49f";
          command-substitution-delimiter-quoted = "fg=#eed49f";
          single-quoted-argument = "fg=#eed49f";
          single-quoted-argument-unclosed = "fg=#ee99a0";
          double-quoted-argument = "fg=#eed49f";
          double-quoted-argument-unclosed = "fg=#ee99a0";
          rc-quote = "fg=#eed49f";

          # Variables
          dollar-quoted-argument = "fg=#cad3f5";
          dollar-quoted-argument-unclosed = "fg=#ee99a0";
          dollar-double-quoted-argument = "fg=#cad3f5";
          assign = "fg=#cad3f5";
          named-fd = "fg=#cad3f5";
          numeric-fd = "fg=#cad3f5";

          # Misc
          unknown-token = "fg=#ee99a0";
          path = "fg=#cad3f5,underline";
          path_pathseparator = "fg=#ed8796,underline";
          path_prefix = "fg=#cad3f5,underline";
          path_prefix_pathseparator = "fg=#ed8796,underline";
          globbing = "fg=#cad3f5";
          history-expansion = "fg=#c6a0f6";
          back-quoted-argument-unclosed = "fg=#ee99a0";
          redirection = "fg=#cad3f5";
          arg0 = "fg=#cad3f5";
          default = "fg=#cad3f5";
          cursor = "fg=#cad3f5"; 
	};
      };

      oh-my-zsh = {
	enable = true;
	plugins = [
	  "git"
	  "eza"
	];
      };
    };
}
