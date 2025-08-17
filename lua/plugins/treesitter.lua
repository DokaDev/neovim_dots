-- return {
--   {
--     "nvim-treesitter/playground",
--     cmd = "TSPlaygroundToggle",
--   },
--   {
--     "nvim-treesitter/nvim-treesitter",
--     -- branch = "master", -- ⚠️ README 권고: master 사용 (main은 앞으로 기본이 될 예정)
--     -- lazy = false, -- ⚠️ lazy-load 금지
--     -- build = ":TSUpdate", -- 플러그인/잠금파일과 파서 버전 동기화
--     build = ":TSUpdateSync", -- 플러그인/잠금파일과 파서 버전 동기화
--     opts = {
--       -- 꼭 설치할 파서들만 넣기. 너무 많이 박으면 컴파일/업데이트 느려짐
--       ensure_installed = {
--         "lua",
--         "vim",
--         "vimdoc",
--         "query",
--         "bash",
--         "json",
--         "yaml",
--         "toml",
--         "html",
--         "css",
--         "javascript",
--         "typescript",
--         "tsx",
--         "astro",
--         "cmake",
--         "prisma",
--         "cpp",
--         "fish",
--         "gitignore",
--         "go",
--         "graphql",
--         "http",
--         "java",
--         "php",
--         "rust",
--         "scss",
--         "sql",
--         "svelte",
--         "markdown",
--         "markdown_inline",
--         -- 필요에 따라: "go", "rust", "python", "cpp", ...
--       },

--       matchup = {
--       	enable = true,
--       },

--       -- ensure_installed에만 적용되는 동기 설치 플래그
--       sync_install = true,

--       -- 버퍼 들어갈 때 없는 파서 자동 설치 (tree-sitter CLI 없으면 false 권장)
--       auto_install = true,

--       -- 설치 제외 목록 (굳이 안 쓸 언어라면 명시해두는 것도 좋을듯)
--       ignore_install = {},

--       -- 파서 커스텀 경로 (고급). 쓰면 rtp prepend 필수. 아래 주석 참고.
--       -- parser_install_dir = "/some/path/to/parsers",

--       highlight = {
--         enable = true,
--         -- 특정 언어 끄기
--         -- disable = function(lang, buf)
--         --   -- 대형 파일에서 하이라이트 꺼서 렉 방지 (100KB 초과 시)
--         --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--         --   return ok and stats and stats.size > 100 * 1024
--         -- end,
--         -- regex 하이라이트와 트리시터 동시 사용 (중복/성능저하 위험)
--         additional_vim_regex_highlighting = false,
--       },

--       incremental_selection = {
--         enable = true,
--         keymaps = {
--           init_selection = "gnn",
--           node_incremental = "grn",
--           scope_incremental = "grc",
--           node_decremental = "grm",
--         },
--       },

--       -- https://github.com/nvim-treesitter/playground#query-linter
--       query_linter = {
--         enable = true,
--         use_virtual_text = true,
--         lint_events = { "BufWrite", "CursorHold" },
--       },

--       -- 인덴트 모듈 (실험적). 언어별 퀄리티 들쭉날쭉이라 필요시만 사용
--       indent = {
--         enable = true,
--         -- 필요 시 언어별 disable = {"python", ...}
--       },

--       playground = {
--         enable = true,
--         disable = {},
--         updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
--         persist_queries = true, -- Whether the query persists across vim sessions
--         keybindings = {
--           toggle_query_editor = "o",
--           toggle_hl_groups = "i",
--           toggle_injected_languages = "t",
--           toggle_anonymous_nodes = "a",
--           toggle_language_display = "I",
--           focus_language = "f",
--           unfocus_language = "F",
--           update = "R",
--           goto_node = "<cr>",
--           show_help = "?",
--         },
--       },

--       -- 폴딩은 모듈이 아니라 NVIM 내장 foldexpr 쓰기. 아래에 전역 설정 따로 넣음.
--     },
--     config = function(_, opts)
--       require("nvim-treesitter.configs").setup(opts)

--       -- 폴딩: 트리시터 기반
--       vim.wo.foldmethod = "expr"
--       vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--       -- 선택: 최소 폴딩 라인/최대 중첩 조정
--       -- vim.wo.foldminlines = 1
--       -- vim.wo.foldnestmax = 3

--       -- MDX: 복원된 부분
--       vim.filetype.add({
--         extension = {
--           mdx = "mdx",
--         },
--       })

--       -- 큰 파일에서 트리시터 자동 비활성처럼 더 강하게 제어하려면
--       -- autocmd로 파일 크기 감지해서 highlight/indent 비활성 처리도 가능.
--     end,
--   },
-- }

-- 안정화를 위해 이 위는 전부 비활성화 함.
return {
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  {
    "nvim-treesitter/nvim-treesitter",
    -- README 권고는 master지만, 기본 브랜치면 주석 OK
    -- branch = "master",
    -- lazy = false, -- (원하면 유지)
    build = ":TSUpdateSync", -- ★ 동기 업데이트로 교체

    opts = function()
      -- ★ 설치기 튜닝: 경합 줄이기
      local ts_install = require("nvim-treesitter.install")
      ts_install.prefer_git = true -- tarball보다 git 우선(안정)
      ts_install.compilers = { "clang", "gcc" }

      -- ★ 파서 전용 경로로 고정(섞임 방지)
      local parser_dir = vim.fn.stdpath("data") .. "/parsers"
      vim.opt.runtimepath:append(parser_dir)

      return {
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "bash",
          "json",
          "yaml",
          "toml",
          "html",
          "css",
          "javascript",
          "typescript",
          "tsx",
          "astro",
          "cmake",
          "prisma",
          "cpp",
          "fish",
          "gitignore",
          "go",
          "graphql",
          "http",
          "java",
          "php",
          "rust",
          "scss",
          "sql",
          "svelte",
          "markdown",
          "markdown_inline",
          -- 필요 시 추가: "go", "rust", "python", "cpp", ...
        },

        matchup = { enable = true }, -- andymass/vim-matchup 설치되어 있어야 작동

        sync_install = true, -- ★ 순차(동기) 설치
        auto_install = true, -- ★ 버퍼 열릴 때 자동 설치 금지

        ignore_install = {},

        parser_install_dir = parser_dir, -- ★ 전용 경로 지정

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          -- ★ 대형 파일 가드(100KB↑ 비활성)
          -- disable = function(lang, buf)
          --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          --   return ok and stats and stats.size > 100 * 1024
          -- end,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        -- https://github.com/nvim-treesitter/playground#query-linter
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },

        indent = { enable = true },

        playground = {
          enable = true,
          updatetime = 25,
          persist_queries = true,
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      }
    end,

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

      -- mdx 파일타입 등록
      vim.filetype.add({ extension = { mdx = "mdx" } })
    end,
  },

  -- matchup 본체(활성화했으면 같이 넣어야 함)
  { "andymass/vim-matchup" },
}

