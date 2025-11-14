{ pkgs, ... }:

{
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


      extraCss = "
	  window {
 	    background: transparent;
	  }

	  box.main {
  	    padding: 5px;
  	    margin: 10px;
  	    border-radius: 10px;
  	    border: 2px solid @theme_selected_bg_color;
  	    background-color: @theme_bg_color;
  	    box-shadow: 0 0 5px black;
  	    font-family: \"JetBrainsMonoNL Nerd Font\", monospace;
  	    font-size: 18px;
	  }


	  text {
  	    min-height: 30px;
  	    padding: 5px;
  	    border-radius: 5px;
	  }

	  .matches {
  	    background-color: rgba(0, 0, 0, 0);
  	    border-radius: 10px;
	  }

	  box.plugin:first-child {
  	    margin-top: 5px;
	  }

	  box.plugin.info {
  	    min-width: 200px;
	  }

	  list.plugin {
  	    background-color: rgba(0, 0, 0, 0);
	  }

	  label.match.description {
  	    font-size: 14px;
	  }

	  label.plugin.info {
  	    font-size: 14px;
	  }

	  .match {
  	    background: transparent;
	  }

	  .match:selected {
  	    border-left: 4px solid @theme_selected_bg_color;
  	    background: transparent;
  	    animation: fade 0.1s linear;
	  }

	  @keyframes fade {
  	    0% {
    	    opacity: 0;
  	  }

  	  100% {
    	    opacity: 1;
  	  }
	}
	";
    };
}
