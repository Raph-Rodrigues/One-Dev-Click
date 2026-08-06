local Ayaka = {}

Ayaka.config = {
    italic_comments = true,
    italic_keywords = true,
    italic_functions = false,
    italic_variables = false,
    bold_keywords = false,
    underline_errors = true,
}

local c = {
    bg = "#262626",
    bg_alt = "#1a1a1a",
    fg = "#e6e6e6",
    fg_alt = "#808080",
    red = "#e65c5c",
    red_bright = "#ff8080",
    green = "#66cc66",
    green_bright = "#80cc80",
    yellow = "#ffcc66",
    yellow_bright = "#ffdd66",
    blue = "#6699ff",
    blue_bright = "#80b3ff",
    purple = "#cc99ff",
    purple_bright = "#d080ff",
    cyan = "#66cccc",
    cyan_bright = "#80d4d4",
    orange = "#ff9933",
    surface = "#404040",
    surface_alt = "#333333",
    muted = "#606060",
    border = "#404040",
    accent = "#e65c5c",
    error = "#e65c5c",
    warning = "#ffcc66",
    info = "#6699ff",
    hint = "#66cc66",
}

local function highlight(group, opts)
    local style = opts.style or {}
    local fg = opts.fg
    local bg = opts.bg
    local sp = opts.sp
    local link = opts.link

    if link then
        vim.api.nvim_set_hl(0, group, { link = link })
    else
        local hl = {}
        if fg and fg ~= "NONE" then hl.fg = fg end
        if bg and bg ~= "NONE" then hl.bg = bg end
        if sp and sp ~= "NONE" then hl.sp = sp end
        if type(style) == "string" and style ~= "NONE" then
            hl.style = style
        elseif type(style) == "table" and #style > 0 then
            hl.style = table.concat(style, ",")
        end
        vim.api.nvim_set_hl(0, group, hl)
    end
end

local function set_syntax(syntax)
    for group, opts in pairs(syntax) do
        highlight(group, opts)
    end
end

Ayaka.load = function()
    local syntax = {
        -- Base
        Normal = { fg = c.fg, bg = c.bg },
        NormalFloat = { fg = c.fg, bg = c.surface },
        FloatBorder = { fg = c.border, bg = c.surface },
        ColorColumn = { bg = c.bg_alt },
        Cursor = { fg = c.bg, bg = c.accent },
        CursorColumn = { bg = c.bg_alt },
        CursorLine = { bg = c.surface },
        CursorLineNr = { fg = c.fg, bg = c.surface },
        LineNr = { fg = c.muted },
        Conceal = { fg = c.muted },
        EndOfBuffer = { fg = c.fg_alt },
        FoldColumn = { fg = c.muted },
        Folded = { fg = c.fg_alt, bg = c.bg_alt },
        NonText = { fg = c.muted },
        NormalNC = { fg = c.fg, bg = c.bg },
        Pmenu = { fg = c.fg, bg = c.surface },
        PmenuSel = { fg = c.fg, bg = c.surface_alt },
        PmenuSbar = { bg = c.surface_alt },
        PmenuThumb = { bg = c.muted },
        SpecialKey = { fg = c.muted },
        StatusLine = { fg = c.fg, bg = c.surface },
        StatusLineNC = { fg = c.fg_alt, bg = c.surface },
        TabLine = { fg = c.fg_alt, bg = c.bg_alt },
        TabLineFill = { bg = c.bg_alt },
        TabLineSel = { fg = c.fg, bg = c.surface },
        Title = { fg = c.fg },
        Visual = { bg = c.surface },
        VisualNoselect = { bg = c.surface_alt },
        Whitespace = { fg = c.muted },
        WinBar = { fg = c.fg_alt, bg = c.bg },
        WinBarNC = { fg = c.fg_alt, bg = c.bg_alt },

        -- Syntax
        Comment = { fg = c.muted, style = Ayaka.config.italic_comments and "italic" or "NONE" },
        Constant = { fg = c.cyan },
        String = { fg = c.green },
        Number = { fg = c.orange },
        Float = { fg = c.orange },
        Boolean = { fg = c.orange },
        Character = { fg = c.green },
        Label = { fg = c.blue },
        Keyword = { fg = c.red, style = Ayaka.config.italic_keywords and "italic" or "NONE" },
        Statement = { fg = c.red },
        Conditional = { fg = c.red },
        Repeat = { fg = c.red },
        Exception = { fg = c.red },
        Operator = { fg = c.fg },
        PreProc = { fg = c.yellow },
        Include = { fg = c.blue },
        Define = { fg = c.yellow },
        Macro = { fg = c.yellow },
        PreCondit = { fg = c.yellow },
        Function = { fg = c.blue, style = Ayaka.config.italic_functions and "italic" or "NONE" },
        Identifier = { fg = c.fg },
        Structure = { fg = c.yellow },
        Typedef = { fg = c.yellow },
        Type = { fg = c.yellow },
        StorageClass = { fg = c.yellow },
        Structure = { fg = c.yellow },
        Field = { fg = c.fg },
        Property = { fg = c.blue },
        Method = { fg = c.blue },
        Namespace = { fg = c.purple },
        Variable = { fg = c.fg, style = Ayaka.config.italic_variables and "italic" or "NONE" },
        Constant = { fg = c.cyan },
        Parameter = { fg = c.orange },
        Enum = { fg = c.yellow },
        Event = { fg = c.red },
        Operator = { fg = c.red },
        Regex = { fg = c.orange },
        Escape = { fg = c.purple },

        -- LSP
        LspDiagnosticsError = { fg = c.error },
        LspDiagnosticsWarning = { fg = c.warning },
        LspDiagnosticsInformation = { fg = c.info },
        LspDiagnosticsHint = { fg = c.hint },
        LspDiagnosticsErrorSign = { fg = c.error },
        LspDiagnosticsWarningSign = { fg = c.warning },
        LspDiagnosticsInformationSign = { fg = c.info },
        LspDiagnosticsHintSign = { fg = c.hint },
        LspReferenceText = { bg = c.surface },
        LspReferenceRead = { bg = c.surface },
        LspReferenceWrite = { bg = c.surface },
        LspInlayHint = { fg = c.muted, bg = c.surface_alt },

        -- Diagnostics
        Error = { fg = c.error },
        Warning = { fg = c.warning },
        Hint = { fg = c.hint },
        Info = { fg = c.info },
        ErrorMsg = { fg = c.error },
        WarningMsg = { fg = c.warning },
        HintMsg = { fg = c.hint },
        InfoMsg = { fg = c.info },
        MoreMsg = { fg = c.blue },
        MsgArea = { fg = c.fg },
        MsgSeparator = { fg = c.muted },

        -- Treesitter
        ["@comment"] = { fg = c.muted, style = Ayaka.config.italic_comments and "italic" or "NONE" },
        ["@comment.documentation"] = { fg = c.blue },
        ["@keyword"] = { fg = c.red, style = Ayaka.config.italic_keywords and "italic" or "NONE" },
        ["@keyword.function"] = { fg = c.red },
        ["@keyword.operator"] = { fg = c.red },
        ["@keyword.repeat"] = { fg = c.red },
        ["@keyword.return"] = { fg = c.red },
        ["@literal"] = { fg = c.cyan },
        ["@string"] = { fg = c.green },
        ["@string.escape"] = { fg = c.purple },
        ["@string.regex"] = { fg = c.orange },
        ["@number"] = { fg = c.orange },
        ["@float"] = { fg = c.orange },
        ["@boolean"] = { fg = c.orange },
        ["@character"] = { fg = c.green },
        ["@type"] = { fg = c.yellow },
        ["@type.definition"] = { fg = c.yellow },
        ["@type.qualifier"] = { fg = c.yellow },
        ["@variable"] = { fg = c.fg, style = Ayaka.config.italic_variables and "italic" or "NONE" },
        ["@variable.builtin"] = { fg = c.cyan },
        ["@variable.parameter"] = { fg = c.orange },
        ["@variable.member"] = { fg = c.fg },
        ["@constant"] = { fg = c.cyan },
        ["@constant.builtin"] = { fg = c.cyan },
        ["@function"] = { fg = c.blue, style = Ayaka.config.italic_functions and "italic" or "NONE" },
        ["@function.builtin"] = { fg = c.blue },
        ["@function.macro"] = { fg = c.blue },
        ["@method"] = { fg = c.blue },
        ["@method.call"] = { fg = c.blue },
        ["@property"] = { fg = c.blue },
        ["@field"] = { fg = c.fg },
        ["@namespace"] = { fg = c.purple },
        ["@punctuation"] = { fg = c.fg_alt },
        ["@punctuation.bracket"] = { fg = c.fg_alt },
        ["@punctuation.delimiter"] = { fg = c.fg_alt },
        ["@tag"] = { fg = c.red },
        ["@tag.delimiter"] = { fg = c.fg_alt },
        ["@tag.attribute"] = { fg = c.blue },
        ["@label"] = { fg = c.blue },
        ["@operator"] = { fg = c.fg },
        ["@special"] = { fg = c.orange },
        ["@text"] = { fg = c.fg },
        ["@text.title"] = { fg = c.yellow, style = "bold" },
        ["@text.strong"] = { style = "bold" },
        ["@text.emphasis"] = { style = "italic" },
        ["@text.strikethrough"] = { style = "strikethrough" },
        ["@text.underline"] = { style = "underline" },
        ["@text.literal"] = { fg = c.green },
        ["@text.link"] = { fg = c.blue, style = "underline" },
        ["@text.uri"] = { fg = c.blue, style = "underline" },
        ["@text.math"] = { fg = c.orange },
        ["@text.environment"] = { fg = c.orange },
        ["@text.environment.name"] = { fg = c.blue },

        -- Git
        GitSignsAdd = { fg = c.green },
        GitSignsChange = { fg = c.yellow },
        GitSignsDelete = { fg = c.red },
        GitSignsAddLn = { bg = c.surface_alt },
        GitSignsChangeLn = { bg = c.surface_alt },
        GitSignsDeleteLn = { bg = c.surface_alt },
        GitSignsCurrentLineBlame = { fg = c.muted },

        -- Quickfix
        qfFileName = { fg = c.blue },
        qfLineNr = { fg = c.muted },
        qfError = { fg = c.error },

        -- Spell
        SpellBad = { sp = c.error, style = "undercurl" },
        SpellCap = { sp = c.warning, style = "undercurl" },
        SpellLocal = { sp = c.info, style = "undercurl" },
        SpellRare = { sp = c.hint, style = "undercurl" },

        -- Search
        IncSearch = { fg = c.bg, bg = c.accent },
        Search = { fg = c.bg, bg = c.accent },
        CurSearch = { fg = c.bg, bg = c.yellow },
        MatchParen = { bg = c.surface },

        -- Bufferline
        BufferLineIndicatorSelected = { fg = c.accent },
        BufferLineIndicator = { fg = c.muted },

        -- Telescope
        TelescopeSelection = { bg = c.surface },
        TelescopeSelectionCaret = { fg = c.accent },
        TelescopeBorder = { fg = c.border, bg = c.bg },
        TelescopeNormal = { bg = c.bg },
        TelescopePromptNormal = { bg = c.surface },
        TelescopePromptBorder = { fg = c.border, bg = c.surface },

        -- CMP
        CmpItemKind = { fg = c.fg },
        CmpItemKindText = { fg = c.fg_alt },
        CmpItemKindMethod = { fg = c.blue },
        CmpItemKindFunction = { fg = c.blue },
        CmpItemKindConstructor = { fg = c.yellow },
        CmpItemKindField = { fg = c.green },
        CmpItemKindVariable = { fg = c.cyan },
        CmpItemKindClass = { fg = c.yellow },
        CmpItemKindInterface = { fg = c.yellow },
        CmpItemKindModule = { fg = c.blue },
        CmpItemKindProperty = { fg = c.green },
        CmpItemKindOperator = { fg = c.fg },
        CmpItemKindConstant = { fg = c.orange },
        CmpItemKindReference = { fg = c.purple },
        CmpItemKindEnum = { fg = c.yellow },
        CmpItemKindSnippet = { fg = c.muted },

        -- WhichKey
        WhichKey = { fg = c.blue },
        WhichKeyGroup = { fg = c.blue },
        WhichKeyDesc = { fg = c.fg },
        WhichKeySeparator = { fg = c.muted },

        -- Notifications
        NotifyBody = { fg = c.fg },
        NotifyTitle = { fg = c.blue },
        NotifyIcon = { fg = c.accent },
        NotifyBorder = { fg = c.border },
        NotifyERROR = { fg = c.error },
        NotifyWARN = { fg = c.warning },
        NotifyINFO = { fg = c.info },
        NotifyDEBUG = { fg = c.muted },
        NotifyTRACE = { fg = c.purple },
    }

    if Ayaka.config.bold_keywords then
        syntax["Keyword"].style = "bold,italic"
    end

    set_syntax(syntax)

    -- Set terminal colors
    vim.g.terminal_color_0 = c.bg
    vim.g.terminal_color_1 = c.red
    vim.g.terminal_color_2 = c.green
    vim.g.terminal_color_3 = c.yellow
    vim.g.terminal_color_4 = c.blue
    vim.g.terminal_color_5 = c.purple
    vim.g.terminal_color_6 = c.cyan
    vim.g.terminal_color_7 = c.fg
    vim.g.terminal_color_8 = c.muted
    vim.g.terminal_color_9 = c.red_bright
    vim.g.terminal_color_10 = c.green_bright
    vim.g.terminal_color_11 = c.yellow_bright
    vim.g.terminal_color_12 = c.blue_bright
    vim.g.terminal_color_13 = c.purple_bright
    vim.g.terminal_color_14 = c.cyan_bright
    vim.g.terminal_color_15 = "#ffffff"
end

return Ayaka