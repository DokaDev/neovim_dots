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

-- 1) d/dd/D는 기본 동작 유지 (아무 것도 안 건드림)

-- 2) NORMAL: xx → 현재 줄 삭제 (블랙홀, 클립보드 미점유)
vim.keymap.set("n", "xx", '"_dd', { desc = "Delete line (blackhole)" })

-- 3) VISUAL: x → 선택 영역 삭제 (블랙홀, 클립보드 미점유)
vim.keymap.set("x", "x", '"_d', { desc = "Delete selection (blackhole)" })

-- 4) NORMAL: Ctrl+x → 백스페이스 역할(커서 '앞' 문자 삭제), 블랙홀
--   - 진짜 백스페이스 감성: X와 동일 동작을 블랙홀로.
vim.keymap.set("n", "<C-x>", '"_X', { desc = "Backspace-like delete prev char (blackhole)" })

-- (옵션) NORMAL: Ctrl+Del → 커서 '아래' 문자 삭제, 블랙홀
-- vim.keymap.set("n", "<Del>", '"_x', { desc = "Delete char under cursor (blackhole)" })
-- vim.keymap.set("n", "<C-Del>", '"_dw', { desc = "Delete word forward (blackhole)" })
