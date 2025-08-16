return {
  "LintaoAmons/context-menu.nvim",

  keys = {
    -- Alt+l → ContextMenuTrigger 실행
    { "<leader>lm", ":ContextMenuTrigger<CR>", mode = { "n", "v" }, desc = "Context Menu" },
  },
  -- keys = {
  --   {
  --     "<M-l>",
  --     function()
  --       require("context-menu.picker.vim-ui").select()
  --     end,
  --     mode = { "n", "v" },
  --     desc = "Context Menu (vim-ui)",
  --   },
  --   -- 터미널/OS에서 Alt 전달이 안 될 때를 위한 대체
  --   -- { "<leader>m", "ContextMenuTrigger", mode = { "n", "v" }, desc = "Context Menu (fallback)" },
  -- },

  config = function(_, opts)
    require("context-menu").setup({
      -- Available predefined modules:
      -- "git"|"http"|"markdown"|"test"|"copy"|"json"
      modules = {
        "git", -- Module implementations can be found in `lua/context-menu/modules`
        -- To check the dependencies of the module, e.g. git module requires VGit.nvim
        "copy", -- Remove any predefined modules you don't need
        "markdown", -- Reference existing modules to learn how to create your own
        "http", -- http module requires kulala.nvim
        "json", -- jq
      },
    })

    -- Add custom menu items
    -- This method can be called from any location to modularize your configuration
    -- Items can be modified at runtime to simplify configuration and debugging
    require("context-menu").add_items({
      {
        order = 1, -- Lower numbers indicate higher priority
        name = "Code Action", -- Display name in the menu
        -- Additional filters are defined in `lua/context-menu/types.lua`
        -- Options include ft, not_ft, and filter_func
        not_ft = { "markdown", "toggleterm", "json", "http" }, -- Hide item for specified filetypes
        action = function(_) -- Function executed when item is selected
          vim.lsp.buf.code_action()
        end,
      },
    })
  end,
}
