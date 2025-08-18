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
              "filename",
              path = 1, -- 0: 파일명만, 1: 상대경로, 2: 절대경로, 3: 절대경로+tilde, 4: 파일명(부모디렉토리 포함)
            },
            "harpoon2" 
          },
          lualine_x = {
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
