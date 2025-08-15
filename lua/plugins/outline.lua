return {
  {
    -- Fork: symbols-outline.nvim → outline.nvim
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = {
      "Outline",
      "OutlineOpen",
      "OutlineClose",
      "OutlineFocus",
      "OutlineStatus",
      "OutlineFollow",
      "OutlineRefresh",
    },
    keys = {
      { "<leader>cx", "<cmd>Outline<CR>", desc = "Toggle Outline" },
      { "<leader>cX", "<cmd>OutlineFocus<CR>", desc = "Focus Outline" },
    },
    opts = function()
      -- lspkind 있으면 아이콘 소스 붙여서 예쁘게
      local has_lspkind = pcall(require, "lspkind")
      return {
        outline_window = {
          position = "right",
          width = 24,
          relative_width = true,
          focus_on_open = false, -- 열어도 포커스는 코드 창에 유지
          auto_close = false, -- 점프해도 자동 닫지 않음
          center_on_jump = true,
          show_cursorline = true,
          hide_cursor = true, -- 커서라인이랑 자연스럽게 블렌드
          winhl = "", -- 테마 따르기
        },
        outline_items = {
          show_symbol_details = true,
          show_symbol_lineno = true, -- 라인 넘버 보이기(빠른 점프)
          highlight_hovered_item = true,
          auto_set_cursor = true,
          auto_update_events = {
            follow = { "CursorMoved" },
            items = { "InsertLeave", "WinEnter", "BufEnter", "BufWinEnter", "TabEnter", "BufWritePost" },
          },
        },
        guides = {
          enabled = true,
          markers = { bottom = "└", middle = "├", vertical = "│" },
        },
        symbol_folding = {
          autofold_depth = 1, -- 기본 1뎁스만 펴기(현재 호버는 자동 전개)
          auto_unfold = { hovered = true, only = true },
          markers = { "", "" },
        },
        preview_window = {
          auto_preview = false, -- ‘빠른 점프 패널’ 싫으면 false 유지
          open_hover_on_preview = false,
          width = 50,
          min_width = 50,
          relative_width = true,
          height = 50,
          min_height = 10,
          relative_height = true,
          border = "single",
          winhl = "NormalFloat:",
          winblend = 0,
          live = true, -- VSCode peek처럼 미리보기에서 바로 편집
        },
        -- 키맵: LazyVim의 <C-h/j/k/l> 창이동이랑 안 싸우게 변경
        keymaps = {
          show_help = "?",
          close = { "<Esc>", "q" },
          goto_location = "<CR>",
          peek_location = "o",
          goto_and_close = "<S-CR>",
          restore_location = "<C-g>",
          hover_symbol = "<C-Space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_toggle = "<Tab>",
          fold_toggle_all = "<S-Tab>",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
          -- 기본은 <C-k>/<C-j>인데 창 이동이랑 충돌하니 바꿔둠
          up_and_jump = "<C-p>",
          down_and_jump = "<C-n>",
        },
        providers = {
          priority = { "lsp", "markdown", "norg", "man" },
          lsp = { blacklist_clients = {} },
          markdown = { filetypes = { "markdown" } },
        },
        symbols = {
          -- 원하면 필터링 켜라. 예) 문자열·변수 빼고 다 보기:
          -- filter = { "String", "Variable", exclude = true },
          icon_source = has_lspkind and "lspkind" or nil,
          -- 필요시 아이콘 직접 바꾸고 싶으면 여기서 변경
          -- icons = { Function = { icon = "", hl = "Function" }, ... }
        },
      }
    end,
    init = function()
      -- symbols-outline.nvim 깔려있으면 충돌 방지용으로 비활성 힌트
      if package.loaded["symbols-outline"] or package.loaded["symbols-outline.nvim"] then
        vim.schedule(function()
          vim.notify(
            "[outline.nvim] 기존 symbols-outline.nvim과 중복 로드 주의. 하나만 쓰자.",
            vim.log.levels.WARN
          )
        end)
      end
    end,
  },
}
