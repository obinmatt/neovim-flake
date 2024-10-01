{
  description = "My personal neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    yazi-nvim.url = "github:mikavilpas/yazi.nvim";
    yazi-nvim.flake = false;
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config = {};
          overlays = [
            (self: super: {
              vimPlugins =
                super.vimPlugins
                // {
                  yazi-nvim = super.vimUtils.buildVimPlugin {
                    name = "yazi-nvim";
                    pname = "yazi-nvim";
                    src = inputs.yazi-nvim;
                  };
                };
            })
          ];
        };

        plugins = with pkgs.vimPlugins; [
          cyberdream-nvim
          lualine-nvim
          undotree
          yazi-nvim
          mini-nvim
          nui-nvim
          nvim-notify
          noice-nvim
          plenary-nvim
          telescope-nvim
          telescope-fzf-native-nvim
          telescope-ui-select-nvim
          nvim-treesitter.withAllGrammars
          nvim-ts-context-commentstring
          nvim-ts-autotag
          nvim-lspconfig
          lspkind-nvim
          luasnip
          friendly-snippets
          nvim-cmp
          cmp-nvim-lsp
          cmp_luasnip
          cmp-buffer
          cmp-path
          conform-nvim
          lazygit-nvim
          gitsigns-nvim
          which-key-nvim
          inc-rename-nvim
          indent-blankline-nvim
          todo-comments-nvim
          nvim-colorizer-lua
          nvim-web-devicons
          vim-illuminate
          neogen
        ];

        dependencies = with pkgs; [
          jq
          fd
          fzf
          git
          yazi
          lazygit
          ripgrep
          nodePackages.typescript-language-server
          nodePackages.prettier
          vscode-langservers-extracted
          lua-language-server
          stylua
          nil
          alejandra
        ];

        defaultPlugin = {
          plugin = null;
          config = null;
          # if optional is true the plugin can be lazy loaded with :packadd! plugin
          optional = false;
          runtime = {};
        };

        # map plugins to an attrset { plugin = <plugin>; config = <config>; optional = <tf>; ... }
        normalizedPlugins = map (x:
          defaultPlugin
          // (
            if x ? plugin
            then x
            else {plugin = x;}
          ))
        plugins;

        neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
          viAlias = true;
          vimAlias = true;
          withNodeJs = false;
          withPython3 = false;
          withRuby = false;
          plugins = normalizedPlugins;
        };

        luaRcContent = ''
          package.path = "${self}/?.lua;" .. package.path
          ${pkgs.lib.readFile ./init.lua}
        '';

        wrapperArgs = pkgs.lib.escapeShellArgs neovimConfig.wrapperArgs + " " + ''--prefix PATH : "${pkgs.lib.makeBinPath dependencies}"'';
      in rec {
        packages.neovim-flake = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
          neovimConfig
          // {
            inherit luaRcContent;
            inherit wrapperArgs;
            wrapRc = true;
          }
        );

        apps.neovim-flake = flake-utils.lib.mkApp {
          drv = packages.neovim-flake;
          name = "neovim-flake";
          exePath = "/bin/nvim";
        };

        packages.default = packages.neovim-flake;
        apps.default = apps.neovim-flake;

        devShell = pkgs.mkShell {
          buildInputs = [packages.neovim-flake] ++ dependencies;
        };
      }
    );
}
