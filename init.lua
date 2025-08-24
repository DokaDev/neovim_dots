vim.o.termguicolors = true
vim.o.showcmdloc = "statusline"

vim.o.mousemoveevent = true
vim.o.updatetime = 250 -- 멈춘 뒤 250ms에 CursorHold 발생

-- vim.lsp.enable("tsgo")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
