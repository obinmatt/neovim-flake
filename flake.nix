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

        customRC = ''
          lua << EOF
              package.path = "${self}/?.lua;" .. package.path
              ${pkgs.lib.readFile ./init.lua}
          EOF
        '';

        plugins = with pkgs.vimPlugins; [
          oil-nvim
          rose-pine
          lualine-nvim
          plenary-nvim
          telescope-nvim
          telescope-fzf-native-nvim
          nvim-treesitter.withAllGrammars
          nvim-ts-context-commentstring
          nvim-ts-autotag
          nvim-autopairs
          nvim-lspconfig
          lspkind-nvim
          luasnip
          friendly-snippets
          nvim-cmp
          cmp_luasnip
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp-cmdline
          undotree
          nvim-lint
          conform-nvim
          lazygit-nvim
          gitsigns-nvim
          which-key-nvim
          dressing-nvim
          comment-nvim
          todo-comments-nvim
          nvim-colorizer-lua
          nvim-web-devicons
          nvim-notify
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
          nodePackages.eslint_d
          lua-language-server
          stylua
          nil
          alejandra
        ];
      in rec {
        packages.neovim-flake =
          pkgs.wrapNeovim pkgs.neovim-unwrapped {
            viAlias = true;
            vimAlias = true;
            withNodeJs = false;
            withPython3 = false;
            withRuby = false;
            extraMakeWrapperArgs = ''--prefix PATH : "${pkgs.lib.makeBinPath dependencies}"'';
            configure = {
              inherit customRC;
              packages.myPlugins = {
                start = plugins;
                opt = [];
              };
            };
          }
          // {buildInputs = dependencies;};

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
