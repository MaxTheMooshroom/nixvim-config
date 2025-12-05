{
  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      # url = /dev/null;
      # flake = false;
    };

    # nixpkgs = {
    #   url = "file+file:///dev/null";
    #   flake = false;
    # };

    user-preferences.url = ./users;
    user-preferences.inputs = {
      flake-parts.follows = "flake-parts";
    };

    environments.url = ./environments;
    environments.inputs = {
      flake-parts.follows = "flake-parts";
      # nixpkgs.follows = "nixpkgs";
    };

    default             = { url = ./default.nix;            flake = false; };
    colorscheme         = { url = ./colorscheme.nix;        flake = false; };
    # barbar              = { url = ./barbar.nix;             flake = false; };
    blink               = { url = ./blink.nix;              flake = false; };
    bufferline          = { url = ./bufferline.nix;         flake = false; };
    bufdelete           = { url = ./bufdelete.nix;          flake = false; };
    ccc                 = { url = ./ccc.nix;                flake = false; };
    # colorizer           = { url = ./colorizer.nix;          flake = false; };
    comment             = { url = ./comment.nix;            flake = false; };
    coverage            = { url = ./coverage.nix;           flake = false; };
    dap                 = { url = ./dap.nix;                flake = false; };
    diagram             = { url = ./diagram.nix;            flake = false; };
    femaco              = { url = ./femaco.nix;             flake = false; };
    gitsigns            = { url = ./gitsigns.nix;           flake = false; };
    indent-blankline    = { url = ./indent-blankline.nix;   flake = false; };
    lspsaga             = { url = ./lspsaga.nix;            flake = false; };
    lualine             = { url = ./lualine.nix;            flake = false; };
    # neotest             = { url = ./neotest.nix;            flake = false; };
    neogit              = { url = ./neogit.nix;             flake = false; };
    notify              = { url = ./notify.nix;             flake = false; };
    persisted           = { url = ./persisted.nix;          flake = false; };
    # precognition        = { url = ./precognition.nix;       flake = false; };
    rainbow-delimiters  = { url = ./rainbow-delimiters.nix; flake = false; };
    render-markdown     = { url = ./render-markdown.nix;    flake = false; };
    # tabby               = { url = ./tabby.nix;              flake = false; };
    telescope           = { url = ./telescope.nix;          flake = false; };
    transparent         = { url = ./transparent.nix;        flake = false; };
    treesitter          = { url = ./treesitter.nix;         flake = false; };
    trouble             = { url = ./trouble.nix;            flake = false; };
  };

  outputs = { self, flake-parts, nixpkgs, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { config, ... }: {
        flake.lib = {};

        flake.flakeModules.default =
          { config, pkgs, lib, ... }:
          let
            inherit (lib) mkOption types;
          in {
            imports = with inputs; [
              environments.flakeModules.default
              user-preferences.flakeModules.default
            ];

            options = {
              nixvimProfiles = mkOption {
                type = types.listOf types.path;
                # type =
                #   types.coercedTo
                #     (types.listOf types.path)
                #     (builtins.map builtins.import)
                #     (types.listOf types.deferredModule);
                default = [];
              };
            };

            config.nixvimProfiles = with inputs; map (item: item.outPath) [
              default

              colorscheme             # Configure personal colors
              # barbar                  # Tabbed buffers
              blink                   # Completions
              bufferline              # Tabbed buffers
              bufdelete               # Buffer deletion without losing layout
              ccc                     # Color code slider with color highlights
              # colorizer               # Color background highlights
              comment                 # Toggle comments
              coverage                # Code coverage
              dap                     # Debug Adapter Protocol client
              diagram                 # Image diagrams
              femaco                  # Edit code blocks in a floating window
              gitsigns                # Git status in the gutters
              indent-blankline        # Indentation guides
              lspsaga                 # LSP interface
              lualine                 # Fancy statusline
              # neotest                 # Framework for interacting with tests
              neogit                  # Interactive Git interface
              notify                  # Puts notifications in a little UI bubble
              persisted               # Session management
              # precognition            # Available motions as text and gutter signs
              rainbow-delimiters      # Colorize delimiters
              render-markdown         # Markdown in-editor rendering
              # tabby                   # Tabbed buffers
              telescope               # Fuzzy finder, file browser, etc.
              transparent             # Make the editor transparent
              treesitter              # Use treesitter for handling syntax
              trouble                 # LSP diagnostics
            ];
          };
      }
    );
}
