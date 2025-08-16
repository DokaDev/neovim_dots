-- ~/.config/nvim/lua/plugins/mason.lua
return {
    -- mason 본체
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        opts = {
          max_concurrent_installers = 2,  -- 기본보다 낮춰. 1~2가 제일 안정적.
          ui = { check_outdated_packages_on_open = false },
        },
      },
      {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
          ensure_installed = { "lua_ls", "ts_ls" }, -- 진짜 쓰는 최소만
          automatic_installation = true,            -- 자동설치 허용
        },
      },
  
    -- (선택) 포매터/린터 관리까지 하고 싶으면
    -- {
    --   "WhoIsSethDaniel/mason-tool-installer.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     ensure_installed = { "prettier", "eslint_d", "stylua" },
    --     auto_update = false,
    --     run_on_start = false,   -- 부팅 시 설치/업데이트 금지
    --   },
    -- },
  }