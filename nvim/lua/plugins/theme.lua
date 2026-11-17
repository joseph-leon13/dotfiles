-- Theme configuration
--
-- Active theme: vscode.nvim + Spectral Ice overrides
-- Matches Kitty's near-black navy, icy cyan glow, and bright readable text.
--
-- Key palette:
--   bg transparent  fg #FFFFFF  keywords #5CE1E6  functions #FFD166
--   strings #C792EA  variables #82AAFF  fields/types #4FD6BE
--   numbers #FF7B9C  constants #FF9E64  comments #637777 italic
--
-- Toggle with `:colorscheme catppuccin-mocha` to switch back.
-- Also installed: catppuccin-mocha, tokyonight, rose-pine, kanagawa

local BG = "NONE"
local BG_FLOAT = "#0B141D"
local BG_SUBTLE = "#131E28"
local FG = "#FFFFFF"
local SPLIT = "#49656E"
local LINENR = "#618B95"

-- Syntax — Kitty's high-contrast icy ANSI palette
local KW = "#5CE1E6" -- vivid cyan   (keywords)
local FN = "#FFD166" -- gold         (functions)
local STR = "#C792EA" -- violet      (strings)
local NUM = "#FF7B9C" -- coral pink  (numbers)
local VAR = "#82AAFF" -- clear blue  (variables)
local PARAM = "#F2A9D0" -- rose         (parameters)
local PROP = "#7FDBCA" -- aqua mint   (properties/fields)
local TYPE = "#4FD6BE" -- green mint  (types)
local CONST = "#FF9E64" -- orange       (constants)
local CMT = "#637F89" -- smoky cyan  (comments)
local OP = "#89DDFF" -- bright cyan  (operators)
local PUNC = "#A6ACCD" -- blue-grey   (punctuation)
local SPECIAL = "#F78C6C" -- warm coral  (escapes/specials)

return {
  -- Tell LazyVim to use vscode instead of its default tokyonight
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },

  -- Spectral Ice — active
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        style = "dark",
        transparent = true,
        italic_comments = true,
        underline_links = true,
        group_overrides = {
          -- Core backgrounds
          Normal = { fg = FG, bg = BG },
          NormalNC = { fg = FG, bg = BG },
          SignColumn = { bg = BG },
          LineNr = { bg = BG, fg = LINENR },
          CursorLine = { bg = BG_SUBTLE },
          CursorLineNr = { bg = BG_SUBTLE, fg = FG, bold = true },
          EndOfBuffer = { bg = BG },
          Visual = { bg = "#324C55" },
          Search = { bg = "#49656E", fg = FG },
          IncSearch = { bg = "#77BBC6", fg = "#02070E" },

          -- Floats / separators
          WinSeparator = { fg = SPLIT, bg = BG },
          VertSplit = { fg = SPLIT, bg = BG },
          NormalFloat = { fg = FG, bg = BG_FLOAT },
          FloatBorder = { bg = BG_FLOAT, fg = "#77BBC6" },
          Pmenu = { fg = FG, bg = BG_FLOAT },
          PmenuSel = { fg = FG, bg = "#324C55", bold = true },
          LazyNormal = { fg = FG, bg = BG_FLOAT },
          NeoTreeNormal = { fg = FG, bg = BG },
          NeoTreeNormalNC = { fg = FG, bg = BG },
          NeoTreeEndOfBuffer = { bg = BG },
          AvanteNormal = { fg = FG, bg = BG_FLOAT },
          AvanteInput = { fg = FG, bg = BG_FLOAT },
          LspInlayHint = { fg = "#6E8B95", bg = BG, italic = true },
          LspReferenceText = { bg = "#243A45" },
          LspReferenceRead = { bg = "#243A45" },
          LspReferenceWrite = { bg = "#324C55", bold = true },

          -- Keywords → ice cyan
          Keyword = { fg = KW, bold = true },
          Statement = { fg = KW, bold = true },
          Conditional = { fg = KW },
          Repeat = { fg = KW },
          Exception = { fg = KW },
          StorageClass = { fg = KW },
          Include = { fg = KW },
          Define = { fg = KW },
          PreProc = { fg = KW },
          Label = { fg = KW },
          ["@keyword"] = { fg = KW, bold = true },
          ["@keyword.function"] = { fg = KW, bold = true },
          ["@keyword.operator"] = { fg = KW },
          ["@keyword.import"] = { fg = KW, bold = true },
          ["@keyword.conditional"] = { fg = KW, bold = true },
          ["@keyword.repeat"] = { fg = KW, bold = true },
          ["@keyword.return"] = { fg = KW, bold = true },
          ["@keyword.exception"] = { fg = KW, bold = true },
          ["@keyword.coroutine"] = { fg = KW, bold = true },
          ["@keyword.modifier"] = { fg = KW },
          ["@keyword.type"] = { fg = KW },
          ["@conditional"] = { fg = KW },
          ["@repeat"] = { fg = KW },
          ["@exception"] = { fg = KW },
          ["@storageclass"] = { fg = KW },
          ["@include"] = { fg = KW },

          -- Functions / types → warm amber
          Function = { fg = FN, bold = true },
          ["@function"] = { fg = FN, bold = true },
          ["@function.call"] = { fg = FN },
          ["@function.macro"] = { fg = FN },
          ["@function.builtin"] = { fg = FN },
          ["@function.method"] = { fg = FN },
          ["@function.method.call"] = { fg = FN },
          ["@method"] = { fg = FN },
          ["@method.call"] = { fg = FN },
          ["@constructor"] = { fg = FN },
          Type = { fg = TYPE },
          ["@type"] = { fg = TYPE },
          ["@type.builtin"] = { fg = TYPE, italic = true },
          ["@type.definition"] = { fg = TYPE, bold = true },
          ["@type.qualifier"] = { fg = KW },
          ["@module"] = { fg = PROP, italic = true },
          ["@module.builtin"] = { fg = KW },
          ["@namespace"] = { fg = FN },

          -- Strings → dusty violet
          String = { fg = STR },
          Character = { fg = STR },
          ["@string"] = { fg = STR },
          ["@string.documentation"] = { fg = STR },
          ["@string.regexp"] = { fg = SPECIAL },
          ["@string.escape"] = { fg = SPECIAL },
          ["@string.special"] = { fg = STR },
          ["@string.special.path"] = { fg = STR, underline = true },
          ["@string.special.url"] = { fg = "#91DCE7", underline = true },
          ["@character"] = { fg = STR },

          -- Numbers / constants → muted amber
          Number = { fg = NUM },
          Float = { fg = NUM },
          Constant = { fg = CONST },
          ["@number"] = { fg = NUM },
          ["@float"] = { fg = NUM },
          ["@number.float"] = { fg = NUM },
          ["@constant"] = { fg = CONST },
          ["@constant.builtin"] = { fg = CONST, italic = true },
          ["@constant.macro"] = { fg = CONST, bold = true },
          ["@boolean"] = { fg = CONST, bold = true },

          -- Comments → muted grey italic
          Comment = { fg = CMT, italic = true },
          ["@comment"] = { fg = CMT, italic = true },
          ["@comment.documentation"] = { fg = CMT, italic = true },

          -- Variables → frost blue; members → mint ice
          Identifier = { fg = VAR },
          ["@variable"] = { fg = VAR },
          ["@variable.builtin"] = { fg = KW },
          ["@variable.parameter"] = { fg = PARAM, italic = true },
          ["@variable.member"] = { fg = PROP },

          -- Properties / attributes → mint ice
          ["@property"] = { fg = PROP },
          ["@field"] = { fg = PROP },
          ["@attribute"] = { fg = PROP },

          -- Operators, punctuation, tags, and markup
          Operator = { fg = OP },
          Delimiter = { fg = PUNC },
          Special = { fg = SPECIAL },
          ["@operator"] = { fg = OP },
          ["@punctuation.bracket"] = { fg = PUNC },
          ["@punctuation.delimiter"] = { fg = PUNC },
          ["@punctuation.special"] = { fg = SPECIAL },
          ["@tag"] = { fg = KW },
          ["@tag.attribute"] = { fg = PROP },
          ["@tag.delimiter"] = { fg = PUNC },
          ["@markup.heading"] = { fg = FN, bold = true },
          ["@markup.link"] = { fg = KW, underline = true },
          ["@markup.raw"] = { fg = STR },

          -- Diagnostics keep their own unmistakable colors
          DiagnosticError = { fg = "#FF7B9C" },
          DiagnosticWarn = { fg = "#FFD166" },
          DiagnosticInfo = { fg = "#82AAFF" },
          DiagnosticHint = { fg = "#7FDBCA" },

          -- Legacy Tree-sitter aliases
          ["@parameter"] = { fg = PARAM, italic = true },
        },
      })
      vim.cmd.colorscheme("vscode")
    end,
  },

  -- Catppuccin Mocha (previous active — kept available)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 900,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      term_colors = true,
      no_italic = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = { enabled = true },
        mason = true,
        neotree = true,
        notify = true,
        which_key = true,
        lsp_trouble = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
      custom_highlights = function(colors)
        local nvim_bg = "#252528"
        return {
          Normal = { bg = nvim_bg },
          NormalNC = { bg = nvim_bg },
          NormalFloat = { bg = nvim_bg },
          FloatBorder = { bg = nvim_bg, fg = "#3a3a4a" },
          NeoTreeNormal = { bg = nvim_bg },
          NeoTreeNormalNC = { bg = nvim_bg },
          NeoTreeEndOfBuffer = { bg = nvim_bg },
          NeoTreeWinSeparator = { bg = nvim_bg, fg = "#3a3a4a" },
          WinSeparator = { fg = "#3a3a4a", bg = nvim_bg },
          VertSplit = { fg = "#3a3a4a", bg = nvim_bg },
          AvanteNormal = { bg = nvim_bg },
          AvanteInput = { bg = nvim_bg },
          SignColumn = { bg = nvim_bg },
          LineNr = { bg = nvim_bg },
          EndOfBuffer = { bg = nvim_bg },
        }
      end,
    },
  },

  -- Tokyo Night (installed for testing)
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Rose Pine (installed for testing)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      variant = "main",
      styles = {
        transparency = true,
        italic = true,
      },
    },
  },

  -- Kanagawa (previous theme — kept available for fallback)
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      transparent = true,
      theme = "dragon",
    },
  },

  -- mini.icons — outlined style for default/fallback icons
  {
    "nvim-mini/mini.icons",
    opts = {
      default = {
        directory = { glyph = "󰉖", hl = "MiniIconsAzure" }, -- folder-outline
        file = { glyph = "󰈤", hl = "MiniIconsGrey" }, -- file-outline
        extension = { glyph = "󰈤", hl = "MiniIconsGrey" }, -- file-outline
      },
    },
  },

  -- File icon colors — mapped to Spectral Ice palette
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      -- Reuse the active syntax colors so icons and editor highlights agree.
      require("nvim-web-devicons").setup({
        override_by_extension = {
          -- TypeScript
          ts = { icon = "", color = VAR, name = "Ts" },
          tsx = { icon = "", color = VAR, name = "Tsx" },
          -- JavaScript
          js = { icon = "", color = FN, name = "Js" },
          jsx = { icon = "", color = FN, name = "Jsx" },
          mjs = { icon = "", color = FN, name = "Mjs" },
          cjs = { icon = "", color = FN, name = "Cjs" },
          -- Python
          py = { icon = "", color = KW, name = "Py" },
          -- Lua
          lua = { icon = "", color = VAR, name = "Lua" },
          -- JSON / YAML / TOML
          json = { icon = "", color = FN, name = "Json" },
          yml = { icon = "", color = FN, name = "Yml" },
          yaml = { icon = "", color = FN, name = "Yaml" },
          toml = { icon = "", color = FN, name = "Toml" },
          -- Markdown / text
          md = { icon = "", color = FG, name = "Md" },
          mdx = { icon = "", color = FG, name = "Mdx" },
          txt = { icon = "󰈙", color = CMT, name = "Txt" },
          -- CSS / SCSS / HTML
          css = { icon = "", color = STR, name = "Css" },
          scss = { icon = "", color = STR, name = "Scss" },
          html = { icon = "", color = FN, name = "Html" },
          -- Shell
          sh = { icon = "", color = PROP, name = "Sh" },
          bash = { icon = "", color = PROP, name = "Bash" },
          zsh = { icon = "", color = PROP, name = "Zsh" },
          fish = { icon = "", color = PROP, name = "Fish" },
          -- Rust / Go
          rs = { icon = "", color = FN, name = "Rs" },
          go = { icon = "", color = KW, name = "Go" },
          -- Config / env
          env = { icon = "", color = NUM, name = "Env" },
          lock = { icon = "󰌾", color = CMT, name = "Lock" },
          gitignore = { icon = "", color = CMT, name = "Gitignore" },
          -- Docker
          dockerfile = { icon = "", color = VAR, name = "Dockerfile" },
          -- SQL
          sql = { icon = "", color = PROP, name = "Sql" },
        },
      })
    end,
  },
}
