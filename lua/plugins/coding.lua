return {
  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    config = function()
      vim.g.lazygit_floating_window_winblend = 0 -- 창 투명도 설정
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 창 크기 비율
      vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
      vim.g.lazygit_use_neovim_remote = 1 -- lazygit을 Neovim 내에서 실행
    end,
  },
}

