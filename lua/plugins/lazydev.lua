return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      "~/projects/my-awesome-lib",
      "lazy.nvim",
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      "LazyVim",
      { path = "LazyVim", words = { "LazyVim" } },
      { path = "wezterm-types", mods = { "wezterm" } },
      { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
    },
    enabled = function(root_dir)
      -- 0) 강제 토글이 있으면 그걸 최우선
      if vim.g.lazydev_force ~= nil then
        return vim.g.lazydev_force
      end
      -- 1) 프로젝트에 .luarc.json 있으면 비활성 (프로젝트 설정 존중)
      if vim.uv.fs_stat(root_dir .. "/.luarc.json") then
        return false
      end
      -- 2) 전역 토글이 지정돼 있으면 그걸 따름
      if vim.g.lazydev_enabled ~= nil then
        return vim.g.lazydev_enabled
      end
      -- 3) 기본값: 켜짐
      return true
    end,
  },
}
