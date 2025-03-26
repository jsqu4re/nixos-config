{ lib, pkgs, ... }: {

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.nixvim = {
    enable = true;
    plugins = {
      direnv.enable = true;
      lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
            settings.formatting.command = [ "nixfmt-rfc-style" ];
          };
          pylsp.enable = true;
          cmake.enable = true;
        };
        # capabilities = "";
      };
      cmp = {
        enable = true;
      };
      cmp-nvim-lsp.enable = true;
      aerial.enable = true;
      blink-cmp = {
        enable = true;
        settings.keymap = {
          preset = "super-tab";
        };
        settings.sources.providers = {
          buffer = {
            score_offset = -7;
          };
          lsp = {
            fallbacks = [ ];
          };
        };
      };
      mini.enable = true;
      render-markdown.enable = true;
      fzf-lua = {
        enable = false;
      };
      todo-comments.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          float_opts = {
            border = "curved";
            height = 30;
            width = 130;
          };
          open_mapping = "[[<c->]]";
        };
      };
      telescope = {
        enable = true;
        extensions = {
          file-browser.enable = true;
          frecency.enable = true;
          live-grep-args.enable = true;
          manix.enable = true;
          media-files = {
            enable = true;
            dependencies = {
              chafa.enable = true;
              epub-thumbnailer.enable = true;
              ffmpegthumbnailer.enable = true;
              pdftoppm.enable = true;
              imageMagick.enable = true;
            };
          };
          undo.enable = true;
        };
      };
      oil = {
        enable = true;
        settings.keymaps = {
          "-" = "actions.parent";
          "<C-c>" = "actions.close";
          "<C-h>" = "actions.select_split";
          "<C-r>" = "actions.refresh";
          "<C-p>" = "actions.preview";
          "<C-s>" = "actions.select_vsplit";
          "<C-t>" = "actions.select_tab";
          "<CR>" = "actions.select";
          _ = "actions.open_cwd";
          "`" = "actions.cd";
          "H" = "actions.toggle_hidden";
          "g?" = "actions.show_help";
          "g\\" = "actions.toggle_trash";
          gs = "actions.change_sort";
          gx = "actions.open_external";
          "~" = "actions.tcd";
        };
        settings.use_default_keymaps = false;
      };
      neo-tree = {
        enable = true;
        filesystem.window.mappings = {
          H = "toggle_hidden";
          "/" = "fuzzy_finder";
          D = "fuzzy_finder_directory";
          # "/" = "filter_as_you_type"; # this was the default until v1.28
          "#" = "fuzzy_sorter"; # fuzzy sorting using the fzy algorithm
          # D = "fuzzy_sorter_directory";
          f = "filter_on_submit";
          "<C-x>" = "clear_filter";
          "<bs>" = "navigate_up";
          "." = "set_root";
          "[g" = "prev_git_modified";
          "]g" = "next_git_modified";
          "<C-b>" = "close_window";
        };
        filesystem.followCurrentFile.enabled = true;
        buffers.followCurrentFile.enabled = true;
        documentSymbols.followCursor = true;
      };
      treesitter = {
        enable = true;
        settings.indent.enable = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
      };
      web-devicons.enable = true;
    };
    opts = {
      number = true;
      relativenumber = true;
      numberwidth = 2;
      ruler = false;
      smartcase = true;
      spelllang = lib.mkDefault [ "en_us" ];
      spell = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      softtabstop = 2;
    };
    keymaps = [
    {
      action = "<CMD>Telescope fd<CR>";
      key = "<C-l>";
      options = {
        silent = true;
      };
    }
    {
      action = "<CMD>Jumps<CR>";
      key = "<C-j>";
      options = {
        silent = true;
      };
    }
    {
      action = "<CMD>Telescope grep_string<CR>";
      key = "<C-f>";
      options = {
        silent = true;
      };
    }
    {
      action = "<CMD>Oil<CR>";
      key = "<C-g>";
      options = {
        silent = true;
      };
    }
    {
      action = "<CMD>Oil<CR>";
      key = "<->";
      options = {
        silent = true;
      };
    }
    {
      action = "<CMD>Neotree toggle<CR>";
      key = "<C-b>";
      options = {
        silent = true;
      };
    }
    {
      action = "<CMD>ToggleTerm<CR>";
      key = "<C-d>";
      options = {
        silent = true;
      };
    }
    ];
    userCommands = {
      Ag.command = "Telescope grep_string";
      Branches.command = "Telescope git_branches";
      Browser.command = "Telescope file_browser";
      Commands.command = "Telescope command_history";
      Commits.command = "Telescope git_bcommits";
      Files.command = "Telescope fd";
      GitFiles.command = "Telescope git_files";
      GitStatus.command = "Telescope git_status";
      History.command = "Telescope git_commits";
      Jumps.command = "Telescope jumplist";
      Repl.command = ''TermExec cmd="exec nix repl .\#" name="nix repl"'';
      Search.command = "Telescope live_grep";
      Term.command = "ToggleTerm";
      Tree.command = "Neotree toggle";
    };
};}
