{
  description = "My personal neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
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
          overlays = [];
        };

        plugins = with pkgs.vimPlugins; [
          catppuccin-nvim
          undotree
          oil-nvim
          mini-nvim
          fidget-nvim
          trouble-nvim
          plenary-nvim
          telescope-nvim
          telescope-fzf-native-nvim
          telescope-ui-select-nvim
          nvim-treesitter.withAllGrammars
          nvim-treesitter-context
          nvim-ts-context-commentstring
          nvim-lspconfig
          lspkind-nvim
          luasnip
          friendly-snippets
          nvim-cmp
          cmp-nvim-lsp
          cmp_luasnip
          cmp-buffer
          cmp-path
          nvim-lint
          conform-nvim
          lazygit-nvim
          gitsigns-nvim
          which-key-nvim
          dressing-nvim
          inc-rename-nvim
          indent-blankline-nvim
          todo-comments-nvim
          flash-nvim
          nvim-spectre
          nvim-colorizer-lua
          nvim-web-devicons
          vim-illuminate
          vim-be-good
        ];

        dependencies = with pkgs; [
          jq
          fd
          fzf
          git
          lazygit
          ripgrep
          nodePackages.typescript-language-server
          nodePackages.prettier
          biome
          eslint_d
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
