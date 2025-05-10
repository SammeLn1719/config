return {
    plugins = {
      {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "gopls", 
            "delve",
            "gofumpt",
            "goimports-reviser",
          },
        },
      },
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          ensure_installed = { "go", "lua" },
        },
      },
    },
    polish = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'go',
        callback = function()
          vim.bo.tabstop = 4
          vim.bo.shiftwidth = 4
        end,
      })
    end,
  }