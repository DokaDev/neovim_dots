return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({

        ---------------------------------------------------------------------------
        -- 패널(panel): Copilot 제안을 별도의 분할창(Split window)에 표시하는 기능
        ---------------------------------------------------------------------------
        panel = {
          enabled = true, -- true면 패널 기능 사용
          auto_refresh = false, -- true면 버퍼 입력 시 패널 자동 갱신
          keymap = { -- 패널 조작용 키맵
            jump_prev = "[[", -- 이전 제안으로 이동
            jump_next = "]]", -- 다음 제안으로 이동
            accept = "<CR>", -- 현재 제안 수락
            refresh = "gr", -- 패널 강제 새로고침
            open = "<M-CR>", -- 패널 열기
          },
          layout = { -- 패널 배치 설정
            position = "bottom", -- top | left | right | bottom
            ratio = 0.4, -- 패널이 차지하는 비율 (0~1)
          },
        },

        ---------------------------------------------------------------------------
        -- 인라인 제안(suggestion): 버퍼 내에서 직접 표시되는 '고스트 텍스트'
        ---------------------------------------------------------------------------
        suggestion = {
          enabled = true, -- true면 인라인 제안 사용
          auto_trigger = false, -- true면 Insert 모드 진입 시 자동으로 제안 표시
          hide_during_completion = true, -- popupmenu-completion이 열릴 때 자동 숨김
          debounce = 75, -- 제안 요청 지연(ms)
          trigger_on_accept = true, -- true면 수락 시 다음 제안 자동 트리거
          keymap = { -- 인라인 제안 키맵
            accept = "<M-l>", -- 제안 수락
            accept_word = false, -- 단어 단위 수락 (키 지정 가능)
            accept_line = false, -- 라인 단위 수락 (키 지정 가능)
            next = "<M-]>", -- 다음 제안
            prev = "<M-[>", -- 이전 제안
            dismiss = "<C-]>", -- 제안 닫기
          },
        },

        ---------------------------------------------------------------------------
        -- filetypes: Copilot attach 여부를 파일 타입별로 제어
        ---------------------------------------------------------------------------
        filetypes = {
          yaml = true, -- yaml에서는 사용 안 함
          markdown = true, -- markdown에서는 사용 안 함
          help = false, -- Neovim 도움말 버퍼에서는 사용 안 함
          gitcommit = true, -- git commit 메시지 작성 시 사용 안 함
          gitrebase = true, -- git rebase 편집 시 사용 안 함
          hgcommit = false, -- Mercurial commit 메시지 작성 시 사용 안 함
          svn = false, -- SVN 메시지 작성 시 사용 안 함
          cvs = false, -- CVS 메시지 작성 시 사용 안 함
          ["."] = true, -- 이름이 '.'로 시작하는 버퍼 비활성화
          -- 커스텀 예시:
          -- sh = function()
          --   local name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
          --   if string.match(name, '^%.env.*') then
          --     return false -- .env 파일은 비활성화
          --   end
          --   return true
          -- end,
          -- ["*"] = false -- 기본 설정 무시하고 전부 비활성화 가능
        },

        ---------------------------------------------------------------------------
        -- auth_provider_url: 다른 GitHub 인스턴스를 사용할 경우 인증 URL 지정
        ---------------------------------------------------------------------------
        auth_provider_url = nil, -- 기본값: "https://github.com/"

        ---------------------------------------------------------------------------
        -- logger: Copilot 동작 로그 설정
        ---------------------------------------------------------------------------
        logger = {
          file = vim.fn.stdpath("log") .. "/copilot-lua.log", -- 로그 파일 경로
          file_log_level = vim.log.levels.OFF, -- 파일 로그 레벨 (TRACE, DEBUG, INFO, WARN, ERROR, OFF)
          print_log_level = vim.log.levels.WARN, -- 네오빔 알림창 로그 레벨
          trace_lsp = "off", -- LSP trace 로그 ("off" | "messages" | "verbose")
          trace_lsp_progress = false, -- LSP 진행 메시지 로그 여부
          log_lsp_messages = false, -- LSP logMessage 이벤트 로그 여부
        },

        ---------------------------------------------------------------------------
        -- copilot_node_command: Node.js 실행 경로 지정 (Node 20+ 필수)
        ---------------------------------------------------------------------------
        copilot_node_command = "node", -- 예: vim.fn.expand("$HOME") .. "/.nvm/versions/node/v20.0.1/bin/node"

        ---------------------------------------------------------------------------
        -- workspace_folders: Copilot이 참고할 워크스페이스 폴더 목록
        ---------------------------------------------------------------------------
        workspace_folders = {
          -- "/home/user/gits",
          -- "/home/user/projects",
        },

        ---------------------------------------------------------------------------
        -- copilot_model: 사용할 Copilot 모델 지정 (빈 문자열이면 기본값 사용)
        ---------------------------------------------------------------------------
        copilot_model = "",

        ---------------------------------------------------------------------------
        -- root_dir: 프로젝트 루트 디렉토리 판별 함수
        ---------------------------------------------------------------------------
        root_dir = function()
          return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
        end,

        ---------------------------------------------------------------------------
        -- should_attach: Copilot이 버퍼에 attach할지 여부 결정하는 함수
        ---------------------------------------------------------------------------
        should_attach = function(bufnr)
          -- buflisted 아님 → 붙이지 말 것
          if vim.fn.buflisted(bufnr) ~= 1 then
            -- vim.notify("copilot: skip (unlisted buffer)", vim.log.levels.DEBUG)
            return false
          end

          -- 특수 buftype이면 붙이지 말 것
          local bt = vim.bo[bufnr].buftype
          if bt ~= "" then
            -- vim.notify(("copilot: skip (buftype=%s)"):format(bt), vim.log.levels.DEBUG)
            return false
          end

          -- 필요하면 filetype 기준 필터도 여기서 추가
          -- local ft = vim.bo[bufnr].filetype
          -- if ft == "neo-tree" or ft == "TelescopePrompt" then return false end

          return true
        end,

        ---------------------------------------------------------------------------
        -- server: Copilot 서버 동작 방식 설정
        ---------------------------------------------------------------------------
        server = {
          type = "nodejs", -- "nodejs" 또는 "binary" (binary는 실험적)
          custom_server_filepath = nil, -- nodejs: js 파일 경로, binary: 바이너리 경로
        },

        ---------------------------------------------------------------------------
        -- server_opts_overrides: Copilot LSP 클라이언트 옵션 오버라이드
        ---------------------------------------------------------------------------
        server_opts_overrides = {
          -- trace = "verbose",
          -- settings = {
          --   advanced = {
          --     listCount = 10,        -- 패널 제안 개수
          --     inlineSuggestCount = 3,-- 인라인 제안 개수
          --   }
          -- },
          -- offset_encoding = "utf-16" -- LSP 오프셋 인코딩 설정
        },
      })
    end,
  },
  {
    "jonahgoldwastaken/copilot-status.nvim",
    dependencies = { "zbirenbaum/copilot.lua" },
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("copilot_status").setup({
        icons = {
          -- 
          -- 󰛑
          -- 
          -- 
          --
          -- idle = " ",
          -- error = " ",
          -- offline = " ",
          -- warning = "𥉉 ",
          -- loading = " ",

          idle = " ",
          error = " ",
          offline = "󰛑 ",
          warning = " ",
          loading = " ",
        },
        debug = false,
      })
    end,
  },
  -- 아래는 copilot-status와 겹치는 확장이라서 아래는 주석처리하여 제거함
  -- {
  --   "AndreM222/copilot-lualine",
  --   show_colors = true,
  -- },
}
