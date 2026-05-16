-- Zed One Dark — ported from github.com/zed-industries/zed (assets/themes/one/one.json)
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "zed-onedark"

-- ── Palette ────────────────────────────────────────────────────────────
local bg        = "#282c33"
local bg_dark   = "#22262d"
local bg_panel  = "#2f343e"
local bg_status = "#3b414d"
local bg_visual = "#3e4451"
local bg_search = "#3d5273"

local fg        = "#acb2be"
local fg_bright = "#dce0e5"
local fg_muted  = "#a9afbc"
local fg_dim    = "#878a98"

local ln        = "#4e5a5f"  -- line number
local ln_act    = "#d0d4da"  -- active line number
local border    = "#464b57"

-- syntax
local comment   = "#5d636f"
local doc       = "#878e98"
local keyword   = "#b477cf"
local func      = "#73ade9"
local string_   = "#a1c181"
local str_esc   = "#878e98"
local str_re    = "#bf956a"
local number    = "#bf956a"
local constant  = "#dfc184"
local type_     = "#6eb4bf"
local property  = "#d07277"
local variable  = "#acb2be"
local var_sp    = "#bf956a"
local operator  = "#6eb4bf"
local punct     = "#b2b9c6"
local punct_sp  = "#b1574b"
local attr      = "#74ade8"
local tag       = "#74ade8"
local preproc   = "#b477cf"
local namespace = "#dce0e5"

-- git / diff
local git_add   = "#27a657"
local git_mod   = "#d3b020"
local git_del   = "#e06c76"
local diff_add  = "#98c379"
local diff_del  = "#e06c75"

-- diagnostics
local d_error   = "#d07277"
local d_warn    = "#dec184"
local d_info    = "#74ade8"
local d_hint    = "#788ca6"

-- ── Helper ─────────────────────────────────────────────────────────────
local function h(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Editor UI ──────────────────────────────────────────────────────────
h("Normal",         { fg = fg,       bg = bg })
h("NormalNC",       { fg = fg,       bg = bg_dark })
h("NormalFloat",    { fg = fg,       bg = bg_panel })
h("FloatBorder",    { fg = border,   bg = bg_panel })
h("FloatTitle",     { fg = fg_bright,bg = bg_panel, bold = true })
h("FloatFooter",    { fg = fg_muted, bg = bg_panel })

h("Cursor",         { fg = bg,       bg = fg })
h("CursorLine",     { bg = bg_panel })
h("CursorColumn",   { bg = bg_panel })
h("ColorColumn",    { bg = bg_panel })

h("LineNr",         { fg = ln })
h("CursorLineNr",   { fg = ln_act,   bold = true })
h("SignColumn",     { fg = ln,       bg = bg })
h("FoldColumn",     { fg = border,   bg = bg })
h("Folded",         { fg = fg_muted, bg = bg_panel })

h("StatusLine",     { fg = fg,       bg = bg_status })
h("StatusLineNC",   { fg = fg_muted, bg = bg_panel })
h("TabLine",        { fg = fg_muted, bg = bg_panel })
h("TabLineFill",    { bg = bg_panel })
h("TabLineSel",     { fg = fg_bright,bg = bg,       bold = true })

h("WinBar",         { fg = fg,       bg = bg })
h("WinBarNC",       { fg = fg_muted, bg = bg_dark })
h("WinSeparator",   { fg = border })

h("Pmenu",          { fg = fg,       bg = bg_panel })
h("PmenuSel",       { fg = fg_bright,bg = bg_visual })
h("PmenuSbar",      { bg = bg_panel })
h("PmenuThumb",     { bg = border })

h("Visual",         { bg = bg_visual })
h("VisualNOS",      { bg = bg_visual })

h("Search",         { fg = fg_bright,bg = bg_search })
h("IncSearch",      { fg = bg,       bg = "#e8af74" })
h("CurSearch",      { fg = bg,       bg = "#e8af74" })
h("Substitute",     { fg = bg,       bg = diff_del })

h("MatchParen",     { fg = fg_bright,bg = "#3e4f6e", bold = true })

h("NonText",        { fg = border })
h("Whitespace",     { fg = border })
h("SpecialKey",     { fg = border })
h("EndOfBuffer",    { fg = bg })
h("Conceal",        { fg = fg_muted })
h("Directory",      { fg = func })
h("Title",          { fg = property, bold = true })
h("Question",       { fg = d_info })
h("MoreMsg",        { fg = diff_add })
h("ModeMsg",        { fg = fg_bright,bold = true })
h("WarningMsg",     { fg = d_warn })
h("ErrorMsg",       { fg = d_error })
h("QuickFixLine",   { bg = bg_panel })

h("DiffAdd",        { bg = "#2d3b2d" })
h("DiffChange",     { bg = "#2d3040" })
h("DiffDelete",     { bg = "#3b2d2d" })
h("DiffText",       { bg = "#3d4460" })

h("SpellBad",       { sp = d_error,  undercurl = true })
h("SpellCap",       { sp = d_info,   undercurl = true })
h("SpellRare",      { sp = d_warn,   undercurl = true })
h("SpellLocal",     { sp = d_hint,   undercurl = true })

-- ── Syntax (classic groups) ────────────────────────────────────────────
h("Comment",        { fg = comment,  italic = true })
h("Constant",       { fg = constant })
h("String",         { fg = string_ })
h("Character",      { fg = string_ })
h("Number",         { fg = number })
h("Boolean",        { fg = number })
h("Float",          { fg = number })
h("Identifier",     { fg = variable })
h("Function",       { fg = func })
h("Statement",      { fg = keyword })
h("Conditional",    { fg = keyword })
h("Repeat",         { fg = keyword })
h("Label",          { fg = attr })
h("Operator",       { fg = operator })
h("Keyword",        { fg = keyword })
h("Exception",      { fg = keyword })
h("PreProc",        { fg = preproc })
h("Include",        { fg = preproc })
h("Define",         { fg = preproc })
h("Macro",          { fg = preproc })
h("PreCondit",      { fg = preproc })
h("Type",           { fg = type_ })
h("StorageClass",   { fg = keyword })
h("Structure",      { fg = type_ })
h("Typedef",        { fg = type_ })
h("Special",        { fg = attr })
h("SpecialChar",    { fg = str_esc })
h("Tag",            { fg = tag })
h("Delimiter",      { fg = punct })
h("SpecialComment", { fg = doc })
h("Debug",          { fg = d_error })
h("Underlined",     { underline = true })
h("Ignore",         { fg = fg_dim })
h("Error",          { fg = d_error })
h("Todo",           { fg = bg,       bg = d_warn,   bold = true })

-- ── Treesitter ─────────────────────────────────────────────────────────
h("@comment",                  { fg = comment,  italic = true })
h("@comment.documentation",    { fg = doc,      italic = true })

h("@keyword",                  { fg = keyword })
h("@keyword.function",         { fg = keyword })
h("@keyword.operator",         { fg = operator })
h("@keyword.return",           { fg = keyword })
h("@keyword.import",           { fg = preproc })
h("@keyword.modifier",         { fg = keyword })
h("@keyword.repeat",           { fg = keyword })
h("@keyword.conditional",      { fg = keyword })
h("@keyword.exception",        { fg = keyword })

h("@function",                 { fg = func })
h("@function.call",            { fg = func })
h("@function.builtin",         { fg = func })
h("@function.method",          { fg = func })
h("@function.method.call",     { fg = func })
h("@constructor",              { fg = func })

h("@variable",                 { fg = variable })
h("@variable.builtin",         { fg = var_sp })
h("@variable.parameter",       { fg = variable })
h("@variable.member",          { fg = property })

h("@string",                   { fg = string_ })
h("@string.escape",            { fg = str_esc })
h("@string.regexp",            { fg = str_re })
h("@string.special",           { fg = str_re })
h("@string.special.symbol",    { fg = str_re })
h("@string.special.url",       { fg = func,     underline = true })

h("@number",                   { fg = number })
h("@number.float",             { fg = number })
h("@boolean",                  { fg = number })

h("@constant",                 { fg = constant })
h("@constant.builtin",         { fg = constant })
h("@constant.macro",           { fg = preproc })

h("@type",                     { fg = type_ })
h("@type.builtin",             { fg = type_ })
h("@type.definition",          { fg = type_ })
h("@type.qualifier",           { fg = keyword })

h("@attribute",                { fg = attr })
h("@property",                 { fg = property })
h("@operator",                 { fg = operator })

h("@punctuation.delimiter",    { fg = punct })
h("@punctuation.bracket",      { fg = punct })
h("@punctuation.special",      { fg = punct_sp })

h("@module",                   { fg = namespace })
h("@module.builtin",           { fg = var_sp })
h("@namespace",                { fg = namespace })
h("@label",                    { fg = attr })

h("@tag",                      { fg = tag })
h("@tag.attribute",            { fg = property })
h("@tag.delimiter",            { fg = punct })

h("@markup.heading",           { fg = property,  bold = true })
h("@markup.raw",               { fg = string_ })
h("@markup.link",              { fg = func,      underline = true })
h("@markup.link.label",        { fg = func,      italic = true })
h("@markup.list",              { fg = property })
h("@markup.italic",            { italic = true })
h("@markup.strong",            { bold = true })
h("@markup.strikethrough",     { strikethrough = true })

h("@diff.plus",                { fg = diff_add })
h("@diff.minus",               { fg = diff_del })
h("@diff.delta",               { fg = git_mod })

-- ── LSP ────────────────────────────────────────────────────────────────
h("LspReferenceText",              { bg = "#2d3540" })
h("LspReferenceRead",              { bg = "#2d3540" })
h("LspReferenceWrite",             { bg = "#3a3545" })
h("LspSignatureActiveParameter",   { fg = fg_bright, bg = bg_visual, bold = true })
h("LspInlayHint",                  { fg = d_hint,    italic = true })

h("DiagnosticError",               { fg = d_error })
h("DiagnosticWarn",                { fg = d_warn })
h("DiagnosticInfo",                { fg = d_info })
h("DiagnosticHint",                { fg = d_hint })
h("DiagnosticUnnecessary",         { fg = fg_dim,    italic = true })
h("DiagnosticUnderlineError",      { sp = d_error,   undercurl = true })
h("DiagnosticUnderlineWarn",       { sp = d_warn,    undercurl = true })
h("DiagnosticUnderlineInfo",       { sp = d_info,    undercurl = true })
h("DiagnosticUnderlineHint",       { sp = d_hint,    undercurl = true })
h("DiagnosticVirtualTextError",    { fg = d_error,   italic = true })
h("DiagnosticVirtualTextWarn",     { fg = d_warn,    italic = true })
h("DiagnosticVirtualTextInfo",     { fg = d_info,    italic = true })
h("DiagnosticVirtualTextHint",     { fg = d_hint,    italic = true })

-- ── Git signs ──────────────────────────────────────────────────────────
h("GitSignsAdd",                   { fg = git_add })
h("GitSignsChange",                { fg = git_mod })
h("GitSignsDelete",                { fg = git_del })

-- ── Snacks ─────────────────────────────────────────────────────────────
h("SnacksDashboardHeader",         { fg = func })
h("SnacksDashboardTitle",          { fg = fg_bright, bold = true })
h("SnacksDashboardDesc",           { fg = fg })
h("SnacksDashboardKey",            { fg = keyword })
h("SnacksDashboardIcon",           { fg = attr })
h("SnacksDashboardFooter",         { fg = comment,   italic = true })
h("SnacksPickerMatch",             { fg = func,      bold = true })

-- ── Terminal ───────────────────────────────────────────────────────────
vim.g.terminal_color_0  = "#282c34"
vim.g.terminal_color_1  = "#e06c75"
vim.g.terminal_color_2  = "#98c379"
vim.g.terminal_color_3  = "#e5c07b"
vim.g.terminal_color_4  = "#61afef"
vim.g.terminal_color_5  = "#c678dd"
vim.g.terminal_color_6  = "#56b6c2"
vim.g.terminal_color_7  = "#abb2bf"
vim.g.terminal_color_8  = "#636d83"
vim.g.terminal_color_9  = "#ea858b"
vim.g.terminal_color_10 = "#aad581"
vim.g.terminal_color_11 = "#ffd885"
vim.g.terminal_color_12 = "#85c1ff"
vim.g.terminal_color_13 = "#d398eb"
vim.g.terminal_color_14 = "#6ed5de"
vim.g.terminal_color_15 = "#fafafa"
