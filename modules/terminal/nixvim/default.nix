{ theme, ... }:

{
	programs.nixvim = {
		# temporary workaround until transparent.nvim has free license
		# https://github.com/xiyaowong/transparent.nvim/issues/87
		nixpkgs.config.allowUnfree = true;

		enable = true;
		defaultEditor = true;

		plugins = {
			lualine.enable = true;
			telescope.enable = true;
			cmp-luasnip.enable = true;

			web-devicons.enable = true;

			treesitter = {
				enable = true;

				settings.ensure_installed = [ "python" ];
			};

			transparent = {
				enable = true;

				settings.extra_groups = [
					"StartupFoldedSection"
					"Startupheader"
				];
			};

			startup = {
				enable = true;

				settings = {
					header = {
						type = "text";
						align = "center";
						fold_section = false;
						title = "Header";
						margin = 5;
						content = [
							"    ___         __    __                 _         "
							"   /   |  _____/ /_  / /__  __  ___   __(_)___ ___ "
							"  / /| | / ___/ __ \\/ / _ \\/ / / / | / / / __ `__ \\"
							" / ___ |(__  ) / / / /  __/ /_/ /| |/ / / / / / / /"
							"/_/  |_/____/_/ /_/_/\\___/\\__, / |___/_/_/ /_/ /_/ "
							"                         /____/                    "
						];
						highlight = "";
						default_color = "#${theme.colours.accent-pink}";
						oldfiles_amount = 0;
					};

					body = {
						type = "mapping";
						align = "center";
						fold_section = false;
						title = "meow meow meoww meow meoww meow meow";
						margin = 5;
						content = [
							[ "  Find File" "Telescope find_files" "<leader>ff" ]
							[ "  Recent Files" "Telescope oldfiles" "<leader>of" ]
							[ "  Find Word" "Telescope live_grep" "<leader>lg" ]
							[ "  New File" "lua require'startup'.new_file()" "<leader>nf" ]
						];
						highlight = "Statement";
						default_color = "";
						oldfiles_amount = 0;
					};

					parts = [ "header" "body" ];
				};
			};

			vimtex = {
				enable = true;
				texlivePackage = null; # stupid
				settings = {
					view_method = "zathura";
				};
			};

			luasnip = {
				enable = true;
				settings = {
					enable_autosnippets = true;
					store_selection_keys = "<Tab>";
				};

				fromLua = [
					{ paths = ./luasnip; }
				];
			};

			lsp = {
				enable = true;
				servers = {
					texlab.enable = true;
					nil_ls.enable = true;
					pyright.enable = true;
				};
			};

			cmp = {
				enable = true;

				settings = {
					sources = [
						{ name = "luasnip"; priority = 1000; }
                    	{ name = "nvim_lsp"; priority = 750; }
                    	{ name = "vimtex"; priority = 500; }
                    	{ name = "path"; priority = 250; }
                    	{ name = "buffer"; priority = 250; }
                    ];

                    snippet.expand = ''
						function(args) require('luasnip').lsp_expand(args.body) end
                    '';

                    mapping = {
						"<CR>" = "cmp.mapping.confirm({ select = true })";
						"<C-Space>" = "cmp.mapping.complete()";
						"<C-e>" = "cmp.mapping.abort()";
						"<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
						"<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";
						"<Tab>" = ''
							cmp.mapping(function(fallback)
								local ls = require("luasnip")
								if cmp.visible() then
									cmp.select_next_item()
								elseif ls.expand_or_jumpable() then
									ls.expand_or_jump()
								else
									fallback()
								end
							end, { "i", "s" })
						'';
						"<S-Tab>" = ''
							cmp.mapping(function(fallback)
								local ls = require("luasnip")
								if cmp.visible() then
                                	cmp.select_prev_item()
								elseif ls.jumpable(-1) then
									ls.jump(-1)
								else
									fallback()
								end
							end, { "i", "s" })
						'';
                    };
				};

			};

		};

		globals = {
			mapleader = " ";
			maplocalleader = " ";
		};

		opts = {
			number = true;
			relativenumber = true;

			tabstop = 4;
			softtabstop = 4;
			shiftwidth = 4;
			smartindent = true;

			wildmenu = true;
			wildmode = "longest:full,full";
			wildignorecase = true;
			wildoptions = "pum";
		};

		autoCmd = [
			{
				event = "VimEnter";
				command = "TransparentEnable";
			}
		];

	};
}