return {
  "Isrothy/neominimap.nvim",
  version = "v3.x.x",
  lazy = false, -- NOTE: NO NEED to Lazy load
  -- Optional. You can alse set your own keybindings
  keys = {
    -- Main minimap toggle (most used)
    { "<leader>m", "<cmd>Neominimap Toggle<cr>", desc = "Toggle minimap" },

    -- Focus controls (second most used)
    { "<leader>mf", "<cmd>Neominimap Focus<cr>", desc = "Focus minimap" },
    { "<leader>mu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus minimap" },

    -- Quick controls
    { "<leader>me", "<cmd>Neominimap Enable<cr>", desc = "Enable minimap" },
    { "<leader>md", "<cmd>Neominimap Disable<cr>", desc = "Disable minimap" },
    { "<leader>mr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh minimap" },

    -- Window-specific (for advanced users)
    { "<leader>mw", "<cmd>Neominimap WinToggle<cr>", desc = "Toggle minimap for window" },
    { "<leader>mb", "<cmd>Neominimap BufToggle<cr>", desc = "Toggle minimap for buffer" },
    { "<leader>mt", "<cmd>Neominimap TabToggle<cr>", desc = "Toggle minimap for tab" },
  },
  init = function()
    -- The following options are recommended when layout == "float"
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 36 -- Set a large value

    --- Put your configuration here
    ---@type Neominimap.UserConfig
    vim.g.neominimap = {
      auto_enable = true,
      click = {
        enabled = true, -- 마우스 클릭 활성화
        auto_switch_focus = true, -- 클릭시 자동으로 미니맵에 포커스
      },
    }
  end,
}
