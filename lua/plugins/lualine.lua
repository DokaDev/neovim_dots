return {
  {
    "nvim-lualine/lualine.nvim",

    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "dracula",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          icons_enabled = true,
        },

        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filetype",
              colored = true, -- Displays filetype icon in color if set to true
              icon_only = true, -- Display only an icon for filetype
              icon = { align = "right" }, -- Display filetype icon on the right hand side
              -- icon =    {'X', align='right'}
              -- Icon string ^ in table is ignored in filetype component
            },
            {
              "filename",
              path = 1, -- 0: 파일명만, 1: 상대경로, 2: 절대경로, 3: 절대경로+tilde, 4: 파일명(부모디렉토리 포함)
              file_status = true,
              newfile_status = false,
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                nofile = "[No File]",
              },
            },
            "harpoon2",
          },
          lualine_x = {
            -- "searchcount",        -- 검색 결과 개수 표시 (예: 3/10)
            -- "selectioncount", -- 비주얼 모드에서 선택된 문자/라인 수
            -- "hostname",           -- 현재 호스트명 표시
            -- "datetime", -- 현재 시간/날짜 표시
            -- "tabs",               -- 탭 개수와 현재 탭 번호 (예: [2/4])
            -- "windows", -- 윈도우 개수와 현재 윈도우 번호 (예: 1/3)
            "%S",

            {
              function()
                return require("copilot_status").status_string()
              end,
              cond = function()
                return require("copilot_status").enabled()
              end,
            },
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
