-- lua/plugins/enable-gitsigns.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,                                -- 강제 ON
    event = { "BufReadPre", "BufNewFile" },       -- 표준 로드 타이밍
    opts = {
      signcolumn = true,   -- 삭제 마커용 (사인컬럼)
      numhl      = true,   -- 추가/변경은 줄번호 색으로
      linehl     = false,
      show_deleted = false, -- 기본은 숨김

      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "┆" },
      },

      watch_gitdir = { interval = 1000 },
    },

    init = function()
      vim.opt.signcolumn = "yes"
    end,

    keys = {
      {
        "<leader>gt",
        function()
          require("gitsigns").toggle_deleted()
        end,
        desc = "Toggle deleted lines",
      },
    },
  },
}