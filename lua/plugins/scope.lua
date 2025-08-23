return {
  "tiagovla/scope.nvim",
  lazy = false,
  config = function()
    require("scope").setup({
      restore_state = false, -- 원하면 true로 켜도 됨
    })
  end,
}
