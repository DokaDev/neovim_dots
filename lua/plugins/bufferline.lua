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

        show_duplicate_prefix = true,

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

        -- separator_style = { "", "" },

        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   if context.buffer:current() then
        --     return ""
        --   end
        --
        --   return ""
        -- end,

        -- custom_areas = {
        --   right = function()
        --     local result = {}
        --     local seve = vim.diagnostic.severity
        --     local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
        --     local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
        --     local info = #vim.diagnostic.get(0, { severity = seve.INFO })
        --     local hint = #vim.diagnostic.get(0, { severity = seve.HINT })
        --
        --     if error ~= 0 then
        --       table.insert(result, { text = "  " .. error, link = "DiagnosticError" })
        --     end
        --
        --     if warning ~= 0 then
        --       table.insert(result, { text = "  " .. warning, link = "DiagnosticWarn" })
        --     end
        --
        --     if hint ~= 0 then
        --       table.insert(result, { text = "  " .. hint, link = "DiagnosticHint" })
        --     end
        --
        --     if info ~= 0 then
        --       table.insert(result, { text = "  " .. info, link = "DiagnosticInfo" })
        --     end
        --     return result
        --   end,
        -- },
      },
    },
  },
}
