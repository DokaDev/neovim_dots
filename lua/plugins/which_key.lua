return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  version = "^3",
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  -- config = function(_, opts)
  --   local wk = require("which-key")
  --   wk.setup(opts)
  --
  --   -- m prefix 비워서 예약
  --   vim.keymap.set("n", "m", "<Nop>", { silent = true })
  --
  --   -- which-key 그룹 등록
  --   wk.add({
  --     { "m", group = "Make / Create" },
  --   })
  -- end,
}
