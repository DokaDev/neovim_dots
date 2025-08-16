return {
  {
    "DokaDev/lazysql.nvim",
    cmd = "LazyDocker",
    keys = {
      { "<leader>lq", "<cmd>lua LazySql.toggle()<CR>", desc = "Toggle LazySql" },
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
      require("lazysql").setup(opts)
    end,
  },
}
