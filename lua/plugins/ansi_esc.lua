-- return {
--   "powerman/vim-plugin-AnsiEsc",
--   lazy = true,
--   cmd = {
--     "AnsiEsc",
--   },
-- }

return {
  "powerman/vim-plugin-AnsiEsc",
  lazy = true,
  cmd = { "AnsiEsc" },
  init = function()
    -- 모든 파일에 적용
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = "*",
      command = "AnsiEsc",
    })

    -- 만약 *.log 같은 특정 확장자만 하고 싶으면
    -- vim.api.nvim_create_autocmd("BufReadPost", {
    --   pattern = "*.log",
    --   command = "AnsiEsc",
    -- })
  end,
}
