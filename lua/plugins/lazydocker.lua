return {
  {
    "crnvl96/lazydocker.nvim",
    cmd = "LazyDocker",
    keys = {
      { "<leader>ld", "<cmd>lua LazyDocker.toggle()<CR>", desc = "Toggle LazyDocker" },
    },

    opts = {
      window = {
        settings = {
          -- width = 0.618,
          -- height = 0.618,
          width = 0.9,
          height = 0.9,
          border = "rounded",
          relative = "editor",
        },
      },
    },

    config = function(_, opts)
      require("lazydocker").setup(opts)
    end,
  },
}
