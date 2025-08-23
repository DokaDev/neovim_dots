return {
  {
    "VidocqH/lsp-lens.nvim",
    config = function()
      local SymbolKind = vim.lsp.protocol.SymbolKind
      require("lsp-lens").setup({
        enable = true,
        include_declaration = false,
        sections = {
          definition = function(count)
            return "Definitions: " .. count
          end,
          references = function(count)
            return "References: " .. count
          end,
          implements = function(count)
            return "Implementations: " .. count
          end,
          git_authors = function(latest_author, count)
            return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
          end,
        },
        ignore_filetype = {},

        target_symbol_kinds = {
          SymbolKind.Function,
          SymbolKind.Method,
          SymbolKind.Interface,
          SymbolKind.Module,
          SymbolKind.Property,
          SymbolKind.Constructor,
          SymbolKind.Enum,
          SymbolKind.Class,
          SymbolKind.Struct,
          SymbolKind.Field,
        },
        wrapper_symbol_kinds = {
          SymbolKind.Class,
          SymbolKind.Struct,
        },
      })
    end,
  },
}
