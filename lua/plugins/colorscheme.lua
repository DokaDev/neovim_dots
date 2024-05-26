return {
  -- add dracula
  { "Mofiqul/dracula.nvim" },

  -- Configure LazyVim to load dracula
  {
    "LazyVim/LazyVim",
    priority = 1000,
    opts = {
      colorscheme = "dracula",
    },
  },
}
