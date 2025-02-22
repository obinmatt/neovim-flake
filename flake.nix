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
          cyberdream-nvim
          lualine-nvim
          undotree
          mini-nvim
          snacks-nvim
          trouble-nvim
          yazi-nvim
          nui-nvim
          noice-nvim
          plenary-nvim
          nvim-treesitter.withAllGrammars
          nvim-ts-context-commentstring
          nvim-ts-autotag
          nvim-lspconfig
          blink-cmp
          luasnip
          friendly-snippets
          nvim-lint
          conform-nvim
          grug-far-nvim
          gitsigns-nvim
          which-key-nvim
          todo-comments-nvim
          nvim-web-devicons
          vim-illuminate
          neogen
        ];

        dependencies = with pkgs; [
          fd
          jq
          git
          yazi
          lazygit
          ripgrep
          ast-grep
          vtsls
          nodePackages.prettier
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
