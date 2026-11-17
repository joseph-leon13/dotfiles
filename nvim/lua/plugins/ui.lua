return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = { { "mode", color = { bg = "#324C55", fg = "#FFFFFF", gui = "bold" } } },
      },
    },
  },
}
