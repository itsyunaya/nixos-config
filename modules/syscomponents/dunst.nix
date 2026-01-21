{ ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        frame_color = "#ffc8dd";
        separator_color = "frame";
        highlight = "#ffc8dd";
        transparency = 20;
        offset = 20;
        font = "JetbrainsMonoNL Nerd Font";
        corner_radius = 7;
      };

      urgency_low = {
        background = "#24273a";
        foreground = "#cad3f5";
      };

      urgency_normal = {
        background = "#24273a";
        foreground = "#cad3f5";
      };

      urgency_critical = {
        background = "#24273a";
        foreground = "#cad3f5";
        frame_color = "#f5a97f";
      };
    };
  };
}
