return {

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    -- 뉴버전 설정끝
    -- 아래는 원래 쓰던 버전 --
    opts = {
      options = {
        -- 색상 투명화 관련 옵션들은 config/autocmds.lua 파일에 지정되어 있음
        mode = "buffers",
        always_show_bufferline = true,
        show_tab_indicators = true,

        diagnostics = false,

        tab_size = 18,

        -- separator_style = "thin",
        -- themable = true,

        -- indicator = {
        --   style = "underline",
        -- },
        buffer_close_icon = "󰅖",
        modified_icon = "● ",
        close_icon = " ",
        -- left_trunc_marker = " ",
        -- right_trunc_marker = " ",

        left_trunc_marker = "",
        right_trunc_marker = "",

        numbers = function(opts)
          return string.format("%s", opts.raise(opts.id))
        end,
      },
    },
  },
}
