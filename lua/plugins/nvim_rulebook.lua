return {
  {
    "chrisgrieser/nvim-rulebook",
    opts = {},
    config = function(_, opts)
      require("rulebook").setup(opts)

      -- 키맵 등록
      vim.keymap.set("n", "<leader>ri", function()
        require("rulebook").ignoreRule()
      end, { desc = "Ignore Rule" })

      vim.keymap.set("n", "<leader>rl", function()
        require("rulebook").lookupRule()
      end, { desc = "Lookup Rule" })

      vim.keymap.set("n", "<leader>ry", function()
        require("rulebook").yankDiagnosticCode()
      end, { desc = "Yank Diagnostic Code" })

      vim.keymap.set({ "n", "x" }, "<leader>rf", function()
        require("rulebook").suppressFormatter()
      end, { desc = "Suppress Formatter" })
    end,
  },
}
