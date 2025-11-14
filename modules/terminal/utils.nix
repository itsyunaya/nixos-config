{ pkgs, ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  
  programs.git = {
    enable = true;

    settings = {
      user.name = "Xanover";
      user.email = "40719746+Xanover@users.noreply.github.com";
      # dont use actual email cuz i dont wanna dox myself yk
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };
}
