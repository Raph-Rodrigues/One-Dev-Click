return {
  -- Configura o registro do Mason para encontrar o pacote do Roslyn
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry", -- Registro customizado da comunidade
      }
    end,
  },

  -- Adiciona e configura o plugin roslyn.nvim
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {},
  },
}
