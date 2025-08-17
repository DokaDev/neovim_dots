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
        -- mode = "tabs",
        mode = "buffers",
        -- always_show_bufferline = true,
        -- indicator = { style = "underline" }, -- 선택 버퍼 밑줄 인디케이터 표시

        always_show_bufferline = true,
        show_tab_indicators = true,

        tab_size = 18,

        separator_style = "thin",
        themable = true,

        indicator = {
          style = "underline",
        },
        -- hover = {
        --   enabled = true,
        --   delay = 200,
        --   reveal = { "close" },
        -- },
        buffer_close_icon = "󰅖",
        modified_icon = "● ",
        close_icon = " ",
        left_trunc_marker = " ",
        right_trunc_marker = " ",

        -- offsets = {
        --   {
        --     text_align = "center",
        --     separator = true,
        --   },
        -- },

        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and "  " or (e == "warning" and "  " or "  ")
            s = s .. n .. sym
          end
          return s
        end,
      },

      -- highlights = {
      --   tab_separator_selected = {
      --     underline = true,
      --     sp = "#ff5f87",
      --   },
      -- },
    },
  },
}
