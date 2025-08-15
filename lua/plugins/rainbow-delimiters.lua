return {
    {
      "HiPhish/rainbow-delimiters.nvim",
      lazy = true,
      event = { "BufReadPost", "BufNewFile" }, -- 편집 시 자동 로드
      config = function()
        local rd = require("rainbow-delimiters")
        vim.g.rainbow_delimiters = {
          strategy = {
            [""]  = rd.strategy["global"],  -- 기본: 전역
            vim   = rd.strategy["local"],   -- vimscript는 로컬 전략
          },
          query = {
            [""]  = "rainbow-delimiters",
            lua   = "rainbow-blocks",       -- 언어별 커스텀 가능
          },
          -- 하이라이트 그룹 이름 순서대로 중첩에 매핑
          highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
          },
        }
  
        -- 드라큘라 팔레트에 맞춘 색 지정 (컬러스킴 바뀔 때도 유지)
        vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
          callback = function()
            vim.api.nvim_set_hl(0, "RainbowDelimiterRed",    { fg = "#FF5555" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#F1FA8C" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterBlue",   { fg = "#8BE9FD" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#FFB86C" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterGreen",  { fg = "#50FA7B" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#BD93F9" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterCyan",   { fg = "#A4FFFF" })
          end,
        })
      end,
    },
  }