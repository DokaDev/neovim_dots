-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Snacks picker/explorer highlight mapping cheatsheet:
-- - GitStatus* groups colour the git status icon (right aligned) and can colour the filename
--   as well when `formatters.file.git_status_hl = true`.
--   * SnacksPickerGitStatusUntracked   -> created / new file
--   * SnacksPickerGitStatusModified    -> modified + unstaged
--   * SnacksPickerGitStatusIgnored     -> ignored (!!)
-- - Path* groups colour the filename/path text in the list:
--   * SnacksPickerPathHidden           -> dotfiles and other hidden entries
--   * SnacksPickerPathIgnored          -> entries ignored by git
-- Precedence in Snacks (format.lua):
--   if item.ignored then PathIgnored
--   elseif item.hidden then PathHidden
--   elseif item.filename_hl then GitStatus*
--   => 둘 다 건드려야 아이콘/텍스트가 동시에 원하는 색으로 나온다

-- ============================================================================
-- Snacks 전용 하이라이트 재정의 이유
-- - 컬러스킴을 바꾸면 모든 하이라이트가 리셋된다. 따라서 `ColorScheme` 오토커맨드로
--   매번 다시 칠해야 한다. 플러그인 옵션에 하드코딩해봤자 테마 변경 시 전부 날아간다.
-- - 전역 이벤트(하이라이트 재적용)는 `autocmds.lua`에서 한 군데 모아 관리하는 게 깔끔하다.
--   기능 옵션은 `lua/plugins/snacks.lua`, 색/테마는 여기. 역할 분리한다.
-- - 아래 색상 팔레트/오버라이드는 전부 Snacks picker/explorer 표시를 위한 것이다.
-- ============================================================================

-- git 상태 색 변수. 필요하면 여기서만 수정하기 (Snacks 전용)
local git_colours = {
  -- created / new (untracked)
  untracked = "#8AFF80",
  -- modified + unstaged
  modified = "#FFCA80",
  -- gitignored (!!)
  ignored = "#CC6699",
}

local misc_colours = {
  -- dotfiles / hidden entries
  hidden = "#7970A9",
  -- gitignored path text (filename)
  ignored_path = "#CC6699",
  -- directory segments in path (file path prefix)
  dir = "#FFAA99",
}

-- Bufferline 밑줄 색(선택 탭 인디케이터)
local bufferline_colours = {
  underline = "#FF6E96",
}

-- devicons 하이라이트도 선택 시 밑줄/색을 강제한다
local function underline_bufferline_devicons()
  local ok, groups = pcall(vim.fn.getcompletion, "", "highlight")
  if not ok or type(groups) ~= "table" or vim.tbl_isempty(groups) then
    return
  end
  for _, name in ipairs(groups) do
    if type(name) == "string" and name:match("^BufferLineDevIcon") and name:match("Selected$") then
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false }) or {}
      local new_hl = { underline = true, sp = bufferline_colours.underline }
      if hl.fg then new_hl.fg = hl.fg end
      vim.api.nvim_set_hl(0, name, new_hl)
    end
  end
end

-- brighten untracked file colour in Snacks picker/explorer
local aug = vim.api.nvim_create_augroup("custom_snacks_git_colours", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = aug,
  callback = function()
    -- Git status icon (and optional filename) colours
    vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = git_colours.untracked })
    -- 일부 버전에선 explorer가 별도 링크를 씀. 같이 묶어두기
    vim.api.nvim_set_hl(0, "SnacksExplorerGitStatusUntracked", { link = "SnacksPickerGitStatusUntracked" })
    vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified", { fg = git_colours.modified })
    vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = git_colours.ignored })
    -- Filename/path colours (우선순위가 더 높음)
    vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = misc_colours.hidden })
    vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = misc_colours.ignored_path })
    -- directory part colour in filename rendering
    vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = misc_colours.dir })
  end,
})

-- Bufferline 상단줄 배경 완전 제거(테마 링크/로딩 타이밍까지 대비)
local bufline_aug = vim.api.nvim_create_augroup("custom_bufferline_hl", { clear = true })

local function clear_bufferline_bg()
  -- 많은 테마가 BufferLineFill -> TabLineFill 로 링크한다. 둘 다 비워라.
  vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "TabLineFill",   { bg = "NONE", ctermbg = "NONE" })

  -- 선택: 줄 전체를 완전 투명하게 유지하고 싶으면 아래도 함께 비워라.
  vim.api.nvim_set_hl(0, "BufferLineBackground",        { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineSeparator",         { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator",   { bg = "NONE", ctermbg = "NONE" })

  -- 선택된 탭에서도 배경 비움(테마가 TabLineSel 배경을 강제하는 경우 차단)
  vim.api.nvim_set_hl(0, "BufferLineBufferSelected",    { bg = "NONE", ctermbg = "NONE", underline = true, sp = bufferline_colours.underline })
  vim.api.nvim_set_hl(0, "BufferLineTabSelected",       { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { bg = "NONE", ctermbg = "NONE", underline = true, sp = bufferline_colours.underline })
  vim.api.nvim_set_hl(0, "BufferLineModifiedSelected",  { bg = "NONE", ctermbg = "NONE", underline = true, sp = bufferline_colours.underline })
  vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { bg = "NONE", ctermbg = "NONE", underline = true, sp = bufferline_colours.underline })
  vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = "NONE", ctermbg = "NONE", underline = true, sp = bufferline_colours.underline })
  vim.api.nvim_set_hl(0, "BufferLineDiagnosticSelected", { bg = "NONE", ctermbg = "NONE", underline = true, sp = bufferline_colours.underline })
  vim.api.nvim_set_hl(0, "BufferLineNumbersSelected",   { bg = "NONE", ctermbg = "NONE", underline = true, sp = bufferline_colours.underline })
  underline_bufferline_devicons()
end

-- 일부 테마/버전은 DevIcons를 BufferLineDevIcon이 아닌 파일별 그룹으로 링크함
-- 가장 흔한 web-devicons 그룹도 강제로 맞춘다(선택 상태일 때만)
local function underline_web_devicons_selected()
  local ok, groups = pcall(vim.fn.getcompletion, "DevIcon", "highlight")
  if not ok or type(groups) ~= "table" then return end
  for _, name in ipairs(groups) do
    if type(name) == "string" and name:match("Selected$") then
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false }) or {}
      local new_hl = { underline = true, sp = bufferline_colours.underline }
      if hl.fg then new_hl.fg = hl.fg end
      vim.api.nvim_set_hl(0, name, new_hl)
    end
  end
end

-- ColorScheme 때 다시 칠해주기
vim.api.nvim_create_autocmd("ColorScheme", {
  group = bufline_aug,
  callback = function()
    underline_bufferline_devicons()
    underline_web_devicons_selected()
  end,
})

-- 테마 바꾸면 즉시 재적용
vim.api.nvim_create_autocmd("ColorScheme", {
  group = bufline_aug,
  callback = clear_bufferline_bg,
})

-- nvim 시작 후 플러그인들이 하이라이트를 덮어쓴 다음 한 번 더(타이밍 이겨야 함)
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter" }, {
  group = bufline_aug,
  callback = function()
    vim.schedule(clear_bufferline_bg)
    -- 드물게 더 늦게 덮는 테마까지 커버
    vim.defer_fn(clear_bufferline_bg, 80)
  end,
})

-- 현재 세션에도 즉시 반영
clear_bufferline_bg()

-- 즉시 적용(현재 colourscheme 상태에서도 반영)
vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })

-- Barbecue/WinBar 배경 완전 제거(테마 링크까지 방지)
local winbar_aug = vim.api.nvim_create_augroup("custom_winbar_hl", { clear = true })
local function clear_winbar_bg()
  vim.api.nvim_set_hl(0, "WinBar",   { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE", ctermbg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = winbar_aug,
  callback = clear_winbar_bg,
})

vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter" }, {
  group = winbar_aug,
  callback = function()
    vim.schedule(clear_winbar_bg)
    vim.defer_fn(clear_winbar_bg, 80)
  end,
})

clear_winbar_bg()
