-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
  require("craftzdog.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
  require("craftzdog.lsp").toggleInlayHints()
end)

-- 탭 전환 (tabnext/tabprev)
-- vim.keymap.set("n", "<C-PageDown>", ":tabnext<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-PageUp>", ":tabprev<CR>", { noremap = true, silent = true })

-- 버퍼 전환 (bnext/bprev)_vscode의 탭 같은 느낌
-- nvim 개념의 탭이 따로 있기는 함
vim.keymap.set("n", "<Leader>.", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>,", ":bprev<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

-- NeoTree 단축키 설정
-- Neo-tree 토글
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
-- Neo-tree 갱신 (파일 구조 새로고침)
vim.keymap.set("n", "<leader>r", ":Neotree refresh<CR>", { noremap = true, silent = true })
-- 루트 디렉토리 변경: 현재 파일의 디렉토리로 이동
-- vim.keymap.set("n", "<leader>cd", ":Neotree focus reveal<CR>", { noremap = true, silent = true })

-- nvim 글로벌 설정(leader 키 설정)
vim.g.mapleader = " " -- 리더 키를 <Space>로 설정

-- 마우스 휠 좌우 스크롤 매핑
vim.api.nvim_set_keymap("n", "<ScrollWheelLeft>", "zl", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<ScrollWheelRight>", "zh", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>wa", ":qa<CR>", { desc = "모든 패널 닫기" })
