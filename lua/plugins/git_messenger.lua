return {
  {
    "rhysd/git-messenger.vim",
    keys = {
      {
        "<leader>gm",
        "<cmd>GitMessenger<CR>",
        desc = "Git message popup(line blame)",
      },
    },
    init = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.g.git_messenger_floating_win_opts = { border = "rounded" }
      vim.g.git_messenger_include_diff = "current"
    end,
  },
}
