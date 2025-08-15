-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- 버퍼를 수직 분할로 열기 위한 단축 명령
vim.api.nvim_create_user_command("Vb", function(opts)
  if opts.args == "" then
    print("Usage: :Vb <buffer_number>")
    return
  end
  vim.cmd("vert sbuffer " .. opts.args)
end, {
  nargs = 1,
  desc = "Open buffer in vertical split",
  complete = "buffer",
})

-- 버퍼를 수평 분할로 열기 위한 단축 명령
vim.api.nvim_create_user_command("Sb", function(opts)
  if opts.args == "" then
    print("Usage: :Sb <buffer_number>")
    return
  end
  vim.cmd("sbuffer " .. opts.args)
end, {
  nargs = 1,
  desc = "Open buffer in horizontal split",
  complete = "buffer",
})
