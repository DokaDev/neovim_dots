return {

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        -- 색상 투명화 관련 옵션들은 config/autocmds.lua 파일에 지정되어 있음
        -- indicator = { style = "underline" },
        -- separator_style = "slope",

        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " " or (e == "warning" and " " or " ")
            s = s .. n .. sym
          end
          return s
        end,
      },

      -- highlights = {
      --   tab_separator_selected = {
      --     underline = "#FF0000",
      --     fg = "#FFFF00",
      --   },
      -- },
    },
  },
}
