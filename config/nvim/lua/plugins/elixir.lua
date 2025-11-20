return {
  -- Keep treesitter support for Elixir
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "elixir", "heex", "eex" })
      vim.treesitter.language.register("markdown", "livebook")
    end,
  },
  -- Keep neotest support for Elixir testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "jfpedroza/neotest-elixir",
    },
    opts = {
      adapters = {
        ["neotest-elixir"] = {},
      },
    },
  },
  -- Keep linting support with Credo
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.elixir = { "credo" }

      opts.linters = opts.linters or {}
      opts.linters.credo = {
        condition = function(ctx)
          return vim.fs.find({ ".credo.exs" }, { path = ctx.filename, upward = true })[1]
        end,
      }
    end,
  },
  -- Keep render-markdown support for livebooks
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = function(_, ft)
      vim.list_extend(ft, { "livebook" })
    end,
  },
}
