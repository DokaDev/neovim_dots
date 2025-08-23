return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = true, -- 강제 ON
    event = { "BufReadPre", "BufNewFile" }, -- 표준 로드 타이밍
    opts = {
      signcolumn = true, -- 삭제 마커용 (사인컬럼)
      numhl = true, -- 추가/변경은 줄번호 색으로
      linehl = false,
      -- show_deleted = false, -- 기본은 숨김

      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "▁" },
        topdelete = { text = "▔" },
        changedelete = { text = "┆" },
      },

      watch_gitdir = { interval = 1000 },

      -- 👇 행 단위 blame(작성자/커밋 요약) 표시
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- eol | overlay | right_align
        delay = 2000, -- 밀리초
        ignore_whitespace = false,
      },
      -- 예: "홍길동, 2025-08-16 - Fix: null check"
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    },

    init = function()
      vim.opt.signcolumn = "yes"
    end,

    keys = {
      {
        "<leader>gt",
        function()
          -- require("gitsigns").toggle_deleted()
          require("gitsigns").preview_hunk_inline()
        end,
        desc = "Toggle deleted lines",
      },
      {
        "<leader>gb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "Git blame current line (full)",
      },
      {
        "<leader>gB",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Toggle inline blame",
      },
    },
  },
}
