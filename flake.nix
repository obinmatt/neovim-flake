{
  description = "My neovim configuration";

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
          config = {allowUnfree = true;};
          overlays = [];
        };

        plugins = with pkgs.vimPlugins; [
          blink-cmp
          conform-nvim
          copilot-lua
          cyberdream-nvim
          friendly-snippets
          gitsigns-nvim
          grug-far-nvim
          guess-indent-nvim
          lazydev-nvim
          luasnip
          lualine-nvim
          mini-nvim
          noice-nvim
          nui-nvim
          nvim-lint
          nvim-lspconfig
          nvim-treesitter-context
          nvim-treesitter.withAllGrammars
          nvim-ts-autotag
          nvim-ts-context-commentstring
          nvim-web-devicons
          plenary-nvim
          snacks-nvim
          todo-comments-nvim
          trouble-nvim
          undotree
          vim-illuminate
          which-key-nvim
          yazi-nvim
        ];

        dependencies = with pkgs; [
          alejandra
          ast-grep
          eslint_d
          fd
          git
          imagemagick_light
          jq
          lazygit
          lua-language-server
          nil
          prettierd
          ripgrep
          stylua
          vtsls
          yazi
          zig
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
