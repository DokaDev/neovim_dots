-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 스왑/백업/언두 경로 정리
local state = vim.fn.stdpath("state") -- ~/.local/state/nvim
vim.opt.directory = state .. "/swap//" -- swap
vim.opt.undodir = state .. "/undo//" -- undo
vim.opt.backupdir = state .. "/backup//" -- backup
vim.opt.swapfile = true

-- 7일 지난 스왑 자동 청소 (네오빔 종료 시)
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local dir = vim.o.directory
    if dir ~= "" then
      -- // 두 슬래시는 하위 디렉토리 구조 보존용이라 그대로 둬라
      vim.fn.system({ "find", dir, "-type", "f", "-name", "*.swp", "-mtime", "+7", "-delete" })
    end
  end,
})
