return {
  {
    -- "folke/snacks.nvim",
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
▓█████▄  ▒█████   ██ ▄█▀▄▄▄      ▓█████▄ ▓█████ ██▒   █▓
▒██▀ ██▌▒██▒  ██▒ ██▄█▒▒████▄    ▒██▀ ██▌▓█   ▀▓██░   █▒
░██   █▌▒██░  ██▒▓███▄░▒██  ▀█▄  ░██   █▌▒███   ▓██  █▒░
░▓█▄   ▌▒██   ██░▓██ █▄░██▄▄▄▄██ ░▓█▄   ▌▒▓█  ▄  ▒██ █░░
░▒████▓ ░ ████▓▒░▒██▒ █▄▓█   ▓██▒░▒████▓ ░▒████▒  ▒▀█░  
 ▒▒▓  ▒ ░ ▒░▒░▒░ ▒ ▒▒ ▓▒▒▒   ▓▒█░ ▒▒▓  ▒ ░░ ▒░ ░  ░ ▐░  
 ░ ▒  ▒   ░ ▒ ▒░ ░ ░▒ ▒░ ▒   ▒▒ ░ ░ ▒  ▒  ░ ░  ░  ░ ░░  
 ░ ░  ░ ░ ░ ░ ▒  ░ ░░ ░  ░   ▒    ░ ░  ░    ░       ░░  
   ░        ░ ░  ░  ░        ░  ░   ░       ░  ░     ░  
 ░                                ░                 ░   
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
--   {
--     "folke/snacks.nvim",
--     opts = {
--       dashboard = {
--         pick = function(cmd, opts)
--           return LazyVim.pick(cmd, opts)()
--         end,
--         header = [[
-- ▓█████▄  ▒█████   ██ ▄█▀▄▄▄      ▓█████▄ ▓█████ ██▒   █▓
-- ▒██▀ ██▌▒██▒  ██▒ ██▄█▒▒████▄    ▒██▀ ██▌▓█   ▀▓██░   █▒
-- ░██   █▌▒██░  ██▒▓███▄░▒██  ▀█▄  ░██   █▌▒███   ▓██  █▒░
-- ░▓█▄   ▌▒██   ██░▓██ █▄░██▄▄▄▄██ ░▓█▄   ▌▒▓█  ▄  ▒██ █░░
-- ░▒████▓ ░ ████▓▒░▒██▒ █▄▓█   ▓██▒░▒████▓ ░▒████▒  ▒▀█░  
--  ▒▒▓  ▒ ░ ▒░▒░▒░ ▒ ▒▒ ▓▒▒▒   ▓▒█░ ▒▒▓  ▒ ░░ ▒░ ░  ░ ▐░  
--  ░ ▒  ▒   ░ ▒ ▒░ ░ ░▒ ▒░ ▒   ▒▒ ░ ░ ▒  ▒  ░ ░  ░  ░ ░░  
--  ░ ░  ░ ░ ░ ░ ▒  ░ ░░ ░  ░   ▒    ░ ░  ░    ░       ░░  
--    ░        ░ ░  ░  ░        ░  ░   ░       ░  ░     ░  
--  ░                                ░                 ░  
--         ]]
--       }
--     }
--   },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        -- mode = "tabs",
        mode = "buffers",
        -- separator_style = "slant",
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_bufferline = true,
      },
    },
  },

  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 30,
        auto_expand_with = true,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {},
          never_show = {},
        },
      },
    },
  },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = {
  --     options = {
  --       icons_enabled = false,
  --       component_separators = { left = '>', right = '<' },
  --       section_separators = { left = '', right = '' },
  --       theme = 'auto',
  --     },
  --   },
  -- },
  -- 

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   -- dependencies = { 'nvim-tree/nvim-web-devicons' }
  --   opts = {
  --     options = {
  --       icons_enabled = true,
  --       theme = 'dracula',
  --       component_separators = { left = '', right = ''},
  --       section_separators = { left = '', right = ''},
  --       disabled_filetypes = {
  --         statusline = {},
  --         winbar = {},
  --       },
  --       ignore_focus = {},
  --       always_divide_middle = true,
  --       always_show_tabline = true,
  --       globalstatus = false,
  --       refresh = {
  --         statusline = 100,
  --         tabline = 100,
  --         winbar = 100,
  --       }
  --     },
  --     sections = {
  --       lualine_a = {'mode'},
  --       lualine_b = {'branch', 'diff', 'diagnostics'},
  --       lualine_c = {'filename'},
  --       lualine_x = {'encoding', 'fileformat', 'filetype'},
  --       lualine_y = {'progress'},
  --       lualine_z = {'location'}
  --     },
  --     inactive_sections = {
  --       lualine_a = {},
  --       lualine_b = {},
  --       lualine_c = {'filename'},
  --       lualine_x = {'location'},
  --       lualine_y = {},
  --       lualine_z = {}
  --     },
  --     tabline = {},
  --     winbar = {},
  --     inactive_winbar = {},
  --     extensions = {}
  --   },
  -- }
  {
    'nvim-tree/nvim-web-devicons'
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = {
  --     options = {
  --       theme = 'auto',
  --       section_separators = { left = '', right = '' },
  --       component_separators = { left = '', right = '' },
  --       icons_enabled = true,
  --     },

  --     sections = {
  --       lualine_a = { "mode" },
  --       lualine_b = { "branch" },

  --       lualine_c = {
  --         LazyVim.lualine.root_dir(),
  --         {
  --           "diagnostics",
  --           symbols = {
  --             error = icons.diagnostics.Error,
  --             warn = icons.diagnostics.Warn,
  --             info = icons.diagnostics.Info,
  --             hint = icons.diagnostics.Hint,
  --           },
  --         },
  --         { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
  --         { LazyVim.lualine.pretty_path() },
  --       },
  --       lualine_x = {
  --         -- stylua: ignore
  --         {
  --           function() return require("noice").api.status.command.get() end,
  --           cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
  --           color = function() return LazyVim.ui.fg("Statement") end,
  --         },
  --         -- stylua: ignore
  --         {
  --           function() return require("noice").api.status.mode.get() end,
  --           cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
  --           color = function() return LazyVim.ui.fg("Constant") end,
  --         },
  --         -- stylua: ignore
  --         {
  --           function() return "  " .. require("dap").status() end,
  --           cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
  --           color = function() return LazyVim.ui.fg("Debug") end,
  --         },
  --         -- stylua: ignore
  --         {
  --           require("lazy.status").updates,
  --           cond = require("lazy.status").has_updates,
  --           color = function() return LazyVim.ui.fg("Special") end,
  --         },
  --         {
  --           "diff",
  --           symbols = {
  --             added = icons.git.added,
  --             modified = icons.git.modified,
  --             removed = icons.git.removed,
  --           },
  --           source = function()
  --             local gitsigns = vim.b.gitsigns_status_dict
  --             if gitsigns then
  --               return {
  --                 added = gitsigns.added,
  --                 modified = gitsigns.changed,
  --                 removed = gitsigns.removed,
  --               }
  --             end
  --           end,
  --         },
  --       },
  --       lualine_y = {
  --         { "progress", separator = " ", padding = { left = 1, right = 0 } },
  --         { "location", padding = { left = 0, right = 1 } },
  --       },
  --       lualine_z = {
  --         function()
  --           return " " .. os.date("%R")
  --         end,
  --       },
  --     },
  --   }
  -- }

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   -- dependencies = { 'nvim-tree/nvim-web-devicons' }
  --   opts = {
  --     options = {
  --       icons_enabled = true,
  --       theme = 'auto',
  --       component_separators = { left = '', right = ''},
  --       section_separators = { left = '', right = ''},

  --     },
  --     sections = {
  --       lualine_a = {'mode'},
  --       lualine_b = {'branch', 'diff', 'diagnostics'},
  --       lualine_c = {
  --         LazyVim.lualine.root_dir(),
  --           {
  --             "diagnostics",
  --             symbols = {
  --               error = icons.diagnostics.Error,
  --               warn = icons.diagnostics.Warn,
  --               info = icons.diagnostics.Info,
  --               hint = icons.diagnostics.Hint,
  --             },
  --           },
  --           { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
  --           { LazyVim.lualine.pretty_path() },
  --       },
  --       lualine_x = {'encoding', 'fileformat', 'filetype'},
  --       lualine_y = {'progress', 'searchcount'},
  --       lualine_z = {'location'}
  --     },
  --     -- inactive_sections = {
  --     --   lualine_a = {},
  --     --   lualine_b = {},
  --     --   lualine_c = {'filename'},
  --     --   lualine_x = {'location'},
  --     --   lualine_y = {},
  --     --   lualine_z = {}
  --     -- }
  --   },
  -- }

  -- {
  --   'nvim-lualine/lualine.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' }
  -- }
  -- { "zbirenbaum/copilot.lua" },

  -- { 'AndreM222/copilot-lualine' ,
  --   -- opts ={
  --   --   options = {
  --   --     show_colors = true
  --   --   }
  --   -- }
  -- },
  {
    "jonahgoldwastaken/copilot-status.nvim",
  dependencies = { "copilot.lua" }, -- or "zbirenbaum/copilot.lua"
  lazy = true,
  event = "BufReadPost",
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      local git_blame = require('gitblame')
      -- This disables showing of the blame text next to the cursor
      vim.g.gitblame_display_virtual_text = 0

      vim.o.laststatus = vim.g.lualine_laststatus
      -- vim.g.gitblame_display_virtual_text = 0

      local opts = {
        options = {
          theme = "dracula",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },

          -- theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        icons_enabled = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },

          lualine_c = {
            -- LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
            "filesize",
            { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
            -- "searchcount",
            -- "tabs",
            -- "windows",
            {
              "harpoon2",
              icon = '♥',
              indicators = { "a", "s", "q", "w" },
              active_indicators = { "A", "S", "Q", "W" },
              color_active = { fg = "#00ff00" },
              _separator = " ",
              no_harpoon = "Harpoon not loaded",
            },
          },
          lualine_x = {
            'encoding', 'fileformat', 
            {
              function() return require("copilot_status").status_string() end,
            cnd = function() return require("copilot_status").enabled() end,
            }
            , 'diff',
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return LazyVim.ui.fg("Statement") end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return LazyVim.ui.fg("Constant") end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return LazyVim.ui.fg("Debug") end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return LazyVim.ui.fg("Special") end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          -- lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "neo-tree", "lazy" },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
    config = function()
      require("barbecue").setup({
        create_autocmd = false, -- prevent barbecue from updating itself automatically
      })

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        -- "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },

  -- lualine integration
    {
      "nvim-lualine/lualine.nvim",
      optional = true,
      opts = function(_, opts)
        table.remove(opts.sections.lualine_c)
        -- if not vim.g.trouble_lualine then
        --   -- table.insert(opts.sections.lualine_c, { "navic", color_correction = "dynamic" })
        --   table.insert(opts.sections.lualine_c, { "navic", enabled = false })
        -- end
        -- for i, section in ipairs(opts.sections.lualine_c) do
        --   if section[1] == "navic" then
        --     table.remove(opts.sections.lualine_c, i)
        --     break
        --   end
        -- end
        -- table.remove({ "navic", color_correction = "dynamic" })
      end,
    },

    {
      "letieu/harpoon-lualine",
      dependencies = {
        {
          "ThePrimeagen/harpoon",
          branch = "harpoon2",
        }
      },
    }
}