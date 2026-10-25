" oxide: a dark colorscheme for Vim.
" Palette source: https://github.com/oxidescheme/nvim/blob/main/lua/oxide/colors.lua

let s:save_cpo = &cpoptions
set cpoptions&vim

set background=dark
highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'oxide'

let s:c = {
      \ 'mantle': '#121212',
      \ 'base': '#161616',
      \ 'surface0': '#222222',
      \ 'surface1': '#2e2e2e',
      \ 'surface2': '#3a3a3a',
      \ 'bright_text': '#eeeeee',
      \ 'text': '#cecece',
      \ 'subtext0': '#aeaeae',
      \ 'subtext1': '#808080',
      \ 'subtext2': '#555555',
      \ 'red': '#ed756e',
      \ 'orange': '#e48233',
      \ 'yellow': '#c39900',
      \ 'lime': '#9ca81f',
      \ 'green': '#5bb661',
      \ 'teal': '#00baaa',
      \ 'sky': '#00b3d6',
      \ 'blue': '#3ba6f5',
      \ 'purple': '#968ff7',
      \ 'pink': '#cc7bd1',
      \ 'bright_red': '#ff9890',
      \ 'bright_orange': '#ffa156',
      \ 'bright_yellow': '#e3b831',
      \ 'bright_lime': '#bbc949',
      \ 'bright_green': '#7bd77f',
      \ 'bright_teal': '#00dcca',
      \ 'bright_sky': '#00d5f9',
      \ 'bright_blue': '#6fc6ff',
      \ 'bright_purple': '#b5b2ff',
      \ 'bright_pink': '#dd8be2',
      \ 'diff_delete': '#452b28',
      \ 'diff_add': '#263826',
      \ 'diff_change': '#213546',
      \ 'none': 'NONE',
      \ }

" Filled highlights need a solid foreground even with a transparent background.
let s:opaque_base = get(get(g:, 'oxide_colors', {}), 'base', s:c.base)
if get(g:, 'oxide_transparent', 0)
  let s:c.base = 'NONE'
  let s:c.mantle = 'NONE'
endif
call extend(s:c, get(g:, 'oxide_colors', {}), 'force')

" Set every attribute explicitly so defaults and previous themes cannot leak in.
let s:highlights = {
      \ 'Normal': {'fg': s:c.text, 'bg': s:c.base},
      \ 'Cursor': {'fg': s:opaque_base, 'bg': s:c.text},
      \ 'CursorLine': {'bg': s:c.surface0},
      \ 'CursorColumn': {'bg': s:c.surface0},
      \ 'CursorLineNr': {'fg': s:c.text, 'style': 'bold'},
      \ 'LineNr': {'fg': s:c.subtext2},
      \ 'SignColumn': {'fg': s:c.subtext2, 'bg': s:c.base},
      \ 'FoldColumn': {'fg': s:c.subtext2, 'bg': s:c.base},
      \ 'Folded': {'fg': s:c.subtext0, 'bg': s:c.surface0},
      \ 'Search': {'fg': s:opaque_base, 'bg': s:c.blue},
      \ 'IncSearch': {'fg': s:opaque_base, 'bg': s:c.orange},
      \ 'CurSearch': {'fg': s:opaque_base, 'bg': s:c.orange},
      \ 'Substitute': {'fg': s:opaque_base, 'bg': s:c.red},
      \ 'Visual': {'bg': s:c.surface1, 'style': 'bold'},
      \ 'VisualNOS': {'bg': s:c.surface1},
      \ 'ModeMsg': {'fg': s:c.text},
      \ 'MoreMsg': {'fg': s:c.blue},
      \ 'Question': {'fg': s:c.text},
      \ 'ErrorMsg': {'fg': s:c.red},
      \ 'WarningMsg': {'fg': s:c.orange},
      \ 'StatusLine': {'fg': s:c.subtext0, 'bg': s:c.mantle},
      \ 'StatusLineNC': {'fg': s:c.subtext0, 'bg': s:c.base},
      \ 'TabLine': {'fg': s:c.subtext0, 'bg': s:c.mantle},
      \ 'TabLineFill': {'bg': s:c.base},
      \ 'TabLineSel': {'fg': s:c.bright_text, 'bg': s:c.surface0},
      \ 'Pmenu': {'fg': s:c.text, 'bg': s:c.surface0},
      \ 'PmenuSel': {'fg': s:c.text, 'bg': s:c.surface1, 'style': 'bold'},
      \ 'PmenuSbar': {'bg': s:c.surface1},
      \ 'PmenuThumb': {'bg': s:c.subtext2},
      \ 'PmenuKind': {'fg': s:c.subtext0, 'bg': s:c.surface0},
      \ 'PmenuExtra': {'fg': s:c.subtext1, 'bg': s:c.surface0},
      \ 'PmenuMatch': {'fg': s:c.blue, 'style': 'bold'},
      \ 'PmenuMatchSel': {'fg': s:c.blue, 'style': 'bold'},
      \ 'PopupNotification': {'fg': s:c.text, 'bg': s:c.surface0},
      \ 'VertSplit': {'fg': s:c.surface2},
      \ 'DiffAdd': {'fg': s:c.text, 'bg': s:c.diff_add},
      \ 'DiffDelete': {'fg': s:c.text, 'bg': s:c.diff_delete},
      \ 'DiffChange': {'fg': s:c.text, 'bg': s:c.diff_change},
      \ 'DiffText': {'fg': s:c.text, 'bg': s:c.surface2, 'style': 'bold'},
      \ 'Added': {'fg': s:c.green},
      \ 'Changed': {'fg': s:c.blue},
      \ 'Removed': {'fg': s:c.red},
      \ 'SpellBad': {'sp': s:c.red, 'style': 'undercurl'},
      \ 'SpellCap': {'sp': s:c.orange, 'style': 'undercurl'},
      \ 'SpellLocal': {'sp': s:c.blue, 'style': 'undercurl'},
      \ 'SpellRare': {'sp': s:c.teal, 'style': 'undercurl'},
      \ 'Directory': {'fg': s:c.blue},
      \ 'Title': {'fg': s:c.text, 'style': 'bold'},
      \ 'Bold': {'style': 'bold'},
      \ 'Italic': {'style': 'italic'},
      \ 'Underlined': {'style': 'underline'},
      \ 'Terminal': {'fg': s:c.text, 'bg': s:c.base},
      \ 'NonText': {'fg': s:c.subtext2},
      \ 'EndOfBuffer': {'fg': s:c.base},
      \ 'Conceal': {'fg': s:c.subtext2},
      \ 'SpecialKey': {'fg': s:c.subtext1},
      \ 'Whitespace': {'fg': s:c.surface0},
      \ 'WildMenu': {'fg': s:c.text, 'bg': s:c.surface1},
      \ 'MatchParen': {'fg': s:c.text, 'bg': s:c.subtext2, 'style': 'underline'},
      \ 'QuickFixLine': {'fg': s:c.text, 'bg': s:c.surface0},
      \ 'ToolbarLine': {'fg': s:c.subtext0, 'bg': s:c.mantle},
      \ 'ToolbarButton': {'fg': s:c.text, 'bg': s:c.surface1, 'style': 'bold'},
      \ 'Comment': {'fg': s:c.subtext1, 'style': get(g:, 'oxide_italic_comments', 1) ? 'italic' : 'NONE'},
      \ 'Constant': {'fg': s:c.orange},
      \ 'String': {'fg': s:c.green},
      \ 'Character': {'fg': s:c.green},
      \ 'Number': {'fg': s:c.orange},
      \ 'Boolean': {'fg': s:c.orange},
      \ 'Float': {'fg': s:c.orange},
      \ 'Identifier': {'fg': s:c.text},
      \ 'Function': {'fg': s:c.teal},
      \ 'Statement': {'fg': s:c.purple},
      \ 'Conditional': {'fg': s:c.purple},
      \ 'Repeat': {'fg': s:c.purple},
      \ 'Label': {'fg': s:c.purple},
      \ 'Operator': {'fg': s:c.text},
      \ 'Keyword': {'fg': s:c.purple},
      \ 'Exception': {'fg': s:c.purple},
      \ 'Type': {'fg': s:c.sky},
      \ 'StorageClass': {'fg': s:c.purple},
      \ 'Structure': {'fg': s:c.sky},
      \ 'Typedef': {'fg': s:c.sky},
      \ 'Special': {'fg': s:c.text},
      \ 'SpecialChar': {'fg': s:c.text},
      \ 'Tag': {'fg': s:c.pink},
      \ 'Delimiter': {'fg': s:c.subtext0},
      \ 'SpecialComment': {'fg': s:c.subtext1},
      \ 'Debug': {'fg': s:c.pink},
      \ 'Error': {'fg': s:c.red},
      \ 'Todo': {'fg': s:c.yellow, 'style': 'bold'},
      \ 'Property': {'fg': s:c.blue},
      \ 'htmlArg': {'fg': s:c.teal},
      \ 'markdownH1': {'fg': s:c.blue, 'style': 'bold'},
      \ 'markdownH2': {'fg': s:c.sky, 'style': 'bold'},
      \ 'markdownH3': {'fg': s:c.teal, 'style': 'bold'},
      \ 'markdownH4': {'fg': s:c.green, 'style': 'bold'},
      \ 'markdownH5': {'fg': s:c.lime, 'style': 'bold'},
      \ 'markdownH6': {'fg': s:c.yellow, 'style': 'bold'},
      \ 'markdownCode': {'fg': s:c.orange},
      \ 'markdownCodeBlock': {'fg': s:c.text},
      \ 'markdownBlockquote': {'fg': s:c.subtext1, 'style': 'italic'},
      \ 'markdownLinkText': {'fg': s:c.blue},
      \ 'markdownUrl': {'fg': s:c.sky, 'style': 'underline'},
      \ }

for [s:group, s:attrs] in items(s:highlights)
  let s:style = get(s:attrs, 'style', 'NONE')
  execute 'highlight ' . s:group
        \ . ' guifg=' . get(s:attrs, 'fg', 'NONE')
        \ . ' guibg=' . get(s:attrs, 'bg', 'NONE')
        \ . ' guisp=' . get(s:attrs, 'sp', 'NONE')
        \ . ' gui=' . s:style . ' cterm=' . s:style . ' term=NONE'
endfor

highlight! link lCursor Cursor
highlight! link CursorIM Cursor
highlight! link CursorLineFold FoldColumn
highlight! link CursorLineSign SignColumn
highlight! link LineNrAbove LineNr
highlight! link LineNrBelow LineNr
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link PmenuKindSel PmenuSel
highlight! link PmenuExtraSel PmenuSel
highlight! link PopupSelected PmenuSel
highlight! link PreProc Keyword
highlight! link Include Keyword
highlight! link Define Keyword
highlight! link Macro Constant
highlight! link PreCondit Keyword
highlight! link Variable Identifier
highlight! link Field Property
highlight! link Parameter Variable
highlight! link diffAdded Added
highlight! link diffChanged Changed
highlight! link diffRemoved Removed
highlight! link yamlMappingKey Property
highlight! link tomlKey Property
highlight! link tomlKeyDq Property
highlight! link tomlKeySq Property
highlight! link jsonKeyword Property
highlight! link htmlTag Tag
highlight! link htmlEndTag Tag
highlight! link htmlTagName Tag
highlight! link markdownHeadingDelimiter Delimiter
highlight! link markdownListMarker Keyword
highlight! link markdownBold Bold
highlight! link markdownItalic Italic

if get(g:, 'oxide_terminal_colors', 1)
  let g:terminal_ansi_colors = [
        \ s:c.surface0, s:c.red, s:c.green, s:c.yellow,
        \ s:c.blue, s:c.purple, s:c.teal, s:c.text,
        \ s:c.subtext1, s:c.bright_red, s:c.bright_green, s:c.bright_yellow,
        \ s:c.bright_blue, s:c.bright_purple, s:c.bright_teal, s:c.bright_text,
        \ ]
endif

let &cpoptions = s:save_cpo
unlet s:save_cpo
