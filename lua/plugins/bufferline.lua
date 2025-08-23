return {

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",

    keys = {
      { "<leader>lt", "<cmd>tabnew<cr>", desc = "Create new Tab" },
      -- { "<leader>lT", "<cmd>tabclose<cr>", desc = "Close current Tab" },
      vim.keymap.set("n", "<leader>lT", function()
        local bufs = vim.fn.tabpagebuflist() -- 현재 탭에 소속된 버퍼들
        for _, b in ipairs(bufs) do
          if vim.api.nvim_buf_is_valid(b) and vim.api.nvim_buf_is_loaded(b) then
            if vim.bo[b].modified then
              -- 수정중인 버퍼면 사용자에게 확인 요청
              local choice = vim.fn.confirm(
                "Buffer " .. vim.api.nvim_buf_get_name(b) .. " has unsaved changes. Save?",
                "&Yes\n&No\n&Cancel"
              )
              if choice == 1 then
                vim.api.nvim_buf_call(b, function()
                  vim.cmd("write")
                end)
              elseif choice == 2 then
                vim.cmd("bdelete! " .. b)
              else
                -- Cancel: 탭 닫기 자체 중단
                return
              end
            else
              -- 수정되지 않은 버퍼는 그냥 삭제
              vim.cmd("bdelete " .. b)
            end
          end
        end
        -- 모든 버퍼 정리 후 현재 탭 닫기
        vim.cmd("tabclose")
      end, { desc = "Close tab and cleanup buffers" }),
    },
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

        -- hover = {
        --   enabled = true,
        --   delay = 200,
        --   reveal = { "close" },
        -- },

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
