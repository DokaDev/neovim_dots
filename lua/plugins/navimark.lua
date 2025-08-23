return {
  {
    "zongben/navimark.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("navimark").setup({
        --set "" to disable keymapping
        keymap = {
          base = {
            mark_toggle = "gm",
            mark_add = nil,
            mark_remove = nil,
            goto_next_mark = nil,
            goto_prev_mark = nil,
            open_mark_picker = "<leader>lk",
          },
          telescope = {
            n = {
              delete_mark = "d",
              clear_marks = "c",
              new_stack = "n",
              next_stack = "<Tab>",
              prev_stack = "<S-Tab>",
              rename_stack = "r",
              delete_stack = "D",
              -- open all marked files in current stack
              open_all_marked_files = "<C-o>",
            },
          },
        },
        sign = {
          text = "",
          color = "#FF80BF",
        },

        persist = true,

        --options: manual || auto
        --auto: when LSP attached, stack will be autoloaded and named based on the current repository
        --manual: manage stacks manually
        stack_mode = "manual",
      })

      vim.keymap.set("n", "<leader>lk", function()
        require("navimark.tele").open_mark_picker()
      end, { desc = "Open Navimark Picker" })
    end,
  },
}
