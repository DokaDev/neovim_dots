-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- 버퍼를 수직 분할로 열기 위한 단축 명령 (버퍼 번호 또는 파일명)
vim.api.nvim_create_user_command("Vb", function(opts)
  if opts.args == "" then
    print("Usage: :Vb <buffer_number_or_filename>")
    return
  end
  -- 숫자인지 확인 (버퍼 번호)
  if string.match(opts.args, "^%d+$") then
    vim.cmd("vert sbuffer " .. opts.args)
  else
    -- 파일명으로 처리
    vim.cmd("vsplit " .. opts.args)
  end
end, {
  nargs = 1,
  desc = "Open buffer/file in vertical split",
  complete = function(arg_lead, cmd_line, cursor_pos)
    -- 버퍼 자동완성과 파일 자동완성 모두 제공
    local buffers = vim.fn.getcompletion(arg_lead, "buffer")
    local files = vim.fn.getcompletion(arg_lead, "file")
    -- 두 결과를 합치기
    local result = {}
    for _, buf in ipairs(buffers) do
      table.insert(result, buf)
    end
    for _, file in ipairs(files) do
      table.insert(result, file)
    end
    return result
  end,
})

-- 버퍼를 수평 분할로 열기 위한 단축 명령 (버퍼 번호 또는 파일명)
vim.api.nvim_create_user_command("Sb", function(opts)
  if opts.args == "" then
    print("Usage: :Sb <buffer_number_or_filename>")
    return
  end
  -- 숫자인지 확인 (버퍼 번호)
  if string.match(opts.args, "^%d+$") then
    vim.cmd("sbuffer " .. opts.args)
  else
    -- 파일명으로 처리
    vim.cmd("split " .. opts.args)
  end
end, {
  nargs = 1,
  desc = "Open buffer/file in horizontal split",
  complete = function(arg_lead, cmd_line, cursor_pos)
    -- 버퍼 자동완성과 파일 자동완성 모두 제공
    local buffers = vim.fn.getcompletion(arg_lead, "buffer")
    local files = vim.fn.getcompletion(arg_lead, "file")
    -- 두 결과를 합치기
    local result = {}
    for _, buf in ipairs(buffers) do
      table.insert(result, buf)
    end
    for _, file in ipairs(files) do
      table.insert(result, file)
    end
    return result
  end,
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
vim.keymap.set("n", "<Del>", '"_x', { desc = "Delete char under cursor (blackhole)" })
-- vim.keymap.set("n", "<C-Del>", '"_dw', { desc = "Delete word forward (blackhole)" })
--
-- Inc_Rename 플러그인 관련 키맵
-- vim.keymap.set("n", "<leader>rn", ":IncRename ")
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename" })

-- select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
