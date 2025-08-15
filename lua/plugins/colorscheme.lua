return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        bg = "#22212C",
        fg = "#F8F8F2",

        selection = "#454158",
        comment = "#7970A9",
        red = "#FF9580",
        orange = "#FFCA80",
        yellow = "#FFFF80",
        green = "#8AFF80",
        purple = "#9580FF",
        cyan = "#80FFEA",
        pink = "#FF80BF",
        bright_red = "#FFAA99",
        bright_green = "#A2FF99",
        bright_yellow = "#FFFF99",
        bright_blue = "#AA99FF",
        bright_magenta = "#FF99CC",
        bright_cyan = "#99FFEE",
        bright_white = "#FFFFFF",

        menu = "#21222C",
        visual = "#3E4452",
        gutter_fg = "#4B5263",
        nontext = "#3B4048",
        white = "#ABB2BF",
        black = "#191A21",
      },
      show_end_of_buffer = true,
      transparent_bg = true,
      lualine_bg_color = "#44475a",
      italic_comment = true,
      -- 필요한 하이라이트 정리(투명 배경 쓸 때 필수로 건드리면 좋은 애들)
      overrides = {
        Normal = { bg = "NONE" },
        NormalFloat = { bg = "NONE" },
        SignColumn = { bg = "NONE" },
        LineNr = { bg = "NONE" },
        CursorLineNr = { bg = "NONE" },
        FloatBorder = { bg = "NONE" },
        WinSeparator = { fg = "#3E4452", bg = "NONE" }, -- 창 구분선
      },
    },
    config = function(_, opts)
      require("dracula").setup(opts) -- ★ setup 먼저 실행
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
