vim.o.termguicolors = true
vim.o.showcmdloc = "statusline"
vim.o.mousemoveevent = true

-- vim.lsp.enable("tsgo")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
