{ pkgs, ... }:

{
    programs.nvf = {
      enable = true;

      settings = {

        vim = {
options = {
    tabstop = 4;
    shiftwidth = 4;
    softtabstop = 4;
    expandtab = true;
};
          diagnostics.enable = true;
          treesitter.enable = true;
          startPlugins = [
            pkgs.vimPlugins.vimtex
            pkgs.vimPlugins.transparent-nvim
          ];

          luaConfigRC.nvimConfigDir = ''
            vim.opt.clipboard = 'unnamedplus' 
          '';
          
          languages = {
            enableTreesitter = true;

            nix = {
              enable = true;
              format.enable = true;
            };
          };

          lsp = {
            enable = true;

            servers.nix.enable = true;
          };

          mini.pairs = {
            enable = true;

            setupOpts = {
              modes = { insert = true; command = true; terminal = false; };

              skip_next = "[=[[%w%%%'%[%\"%.%`%$]]=]";

              skip_ts = true;

              skin_unbalanced = true;
            };
          };

          statusline.lualine = {
            enable = true;
          };

          telescope = {
            enable = true;
          };
        };
      };
    };
}
