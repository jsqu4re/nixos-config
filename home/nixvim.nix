{ lib, pkgs, ... }:
{

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.nixvim = {
    enable = true;
    plugins = {
      aerial.enable = true;
      arrow.enable = true;
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-treesitter.enable = true;
      cmp.enable = true;
      dap.enable = true;
      direnv.enable = true;
      lspkind.cmp.enable = true;
      lspkind.enable = true;
      luasnip.enable = true;
      mini.enable = true;
      spectre.enable = true;
      todo-comments.enable = true;
      web-devicons.enable = true;
      trouble = {
        enable = true;
        settings = {};
      };
      lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
            settings.formatting.command = [ "nixfmt-rfc-style" ];
          };
          bashls.enable = true;
          clangd.enable = true;
          cmake.enable = true;
          cssls.enable = true;
          gleam.enable = true;
          html.enable = true;
          jsonls.enable = true;
          lemminx = {
            enable = true;
            settings.filetypes = [
              "xml"
              "launch"
              "test"
            ];
          };
          lua_ls.enable = true;
          markdown_oxide.enable = true;
          pylsp.enable = true;
          statix.enable = true;
          yamlls.enable = true;
        };
        # capabilities = "";
      };
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
          path = {};
        };
      };
      # instant = {
      #   enable = true;
      #   username = "Johannes";
      # };
      # render-markdown.enable = true;
      # fzf-lua = {
      #   enable = false;
      # };
      toggleterm = {
        enable = true;
        settings = {
          start_in_insert = false;
          direction = "float";
          persist_mode = false;
          float_opts.border = "curved";
          open_mapping = "[[<c-d>]]";
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
        # grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
      };
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
    autoCmd = [
      {
        command = ":startinsert";
        event = [
          "BufEnter"
          "TermOpen"
        ];
        pattern = [
          "term://*"
        ];
      }
    ];
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
        action = "<CMD>Telescope live_grep<CR>";
        key = "<C-f>";
        options = {
          silent = true;
        };
      }
      {
        action = "<CMD>Spectre<CR>";
        key = "<C-M-f>";
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
      {
        action = "<C-\\><C-n>";
        key = "<esc>";
        mode = [ "t" ];
        options = {
          silent = true;
        };
      }
      {
        action = "<CMD>Arrow open<CR>";
        key = "<C-a>";
        options = {
          silent = true;
        };
      }
      {
        action = "<CMD>Arrow toggle_current_line_for_buffer<CR>";
        key = "<C-q>";
        options = {
          silent = true;
        };
      }
      {
        action = "<CMD>Arrow next_buffer_bookmark<CR>";
        key = "<Tab>";
        options = {
          silent = true;
        };
      }
      {
        action = "<CMD>Arrow prev_buffer_bookmark<CR>";
        key = "<S-Tab>";
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
  };
}
