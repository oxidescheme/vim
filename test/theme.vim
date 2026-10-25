" Run with: vim -Nu NONE -n -i NONE -es -S test/theme.vim
set nocompatible
set nomore
set termguicolors
execute 'set runtimepath^=' . fnameescape(fnamemodify(expand('<sfile>'), ':p:h:h'))
syntax enable

function! s:attr(group, attr) abort
  return synIDattr(synIDtrans(hlID(a:group)), a:attr, 'gui')
endfunction

function! s:syntax_color(filetype, lines, line, column) abort
  enew!
  call setline(1, a:lines)
  execute 'setlocal filetype=' . a:filetype
  syntax sync fromstart
  return synIDattr(synIDtrans(synID(a:line, a:column, 1)), 'fg#', 'gui')
endfunction

try
  " Loading must preserve editor options and remove the previous theme's styles.
  set background=light
  set cpoptions+=C
  let s:cpo = &cpoptions
  highlight Normal gui=bold,italic guifg=#ffffff guibg=#ffffff
  colorscheme oxide
  call assert_equal('oxide', g:colors_name)
  call assert_equal('dark', &background)
  call assert_equal(s:cpo, &cpoptions)
  call assert_equal('#cecece', s:attr('Normal', 'fg#'))
  call assert_equal('#161616', s:attr('Normal', 'bg#'))
  call assert_equal('', s:attr('Normal', 'bold'))
  call assert_equal('', s:attr('Normal', 'italic'))
  call assert_equal('#00baaa', s:attr('Function', 'fg#'))
  call assert_equal('#968ff7', s:attr('Include', 'fg#'))
  call assert_equal('#808080', s:attr('Comment', 'fg#'))
  call assert_equal('1', s:attr('Comment', 'italic'))
  call assert_equal('#2e2e2e', s:attr('Visual', 'bg#'))
  call assert_equal('', s:attr('StatusLine', 'reverse'))
  call assert_equal('#121212', s:attr('StatusLineTerm', 'bg#'))
  call assert_equal('#161616', s:attr('StatusLineTermNC', 'bg#'))
  call assert_equal('#ed756e', s:attr('SpellBad', 'sp#'))
  call assert_notequal(s:attr('DiffText', 'fg#'), s:attr('DiffText', 'bg#'))
  call assert_equal(16, len(g:terminal_ansi_colors))
  call assert_equal('#222222', g:terminal_ansi_colors[0])
  call assert_equal('#eeeeee', g:terminal_ansi_colors[15])

  " Exercise actual bundled syntax files, including loading them after the theme.
  call assert_equal('#808080', s:syntax_color('c', ['// comment'], 1, 4))
  call assert_equal('#5bb661', s:syntax_color('c', ['char *name = "oxide";'], 1, 15))
  call assert_equal('#3ba6f5', s:syntax_color('json', ['{"name": "oxide"}'], 1, 3))
  call assert_equal('#3ba6f5', s:syntax_color('yaml', ['name: oxide'], 1, 2))
  call assert_equal('#3ba6f5', s:syntax_color('toml', ['name = "oxide"'], 1, 2))
  call assert_equal('#3ba6f5', s:syntax_color('markdown', ['# Heading'], 1, 4))
  call assert_equal('#cc7bd1', s:syntax_color('html', ['<div class="content">'], 1, 3))
  call assert_equal('#00baaa', s:attr('htmlArg', 'fg#'))
  call assert_equal('#5bb661', s:syntax_color('diff', ['+added'], 1, 2))
  call assert_equal('#ed756e', s:syntax_color('diff', ['-removed'], 1, 2))
  call assert_equal('#3ba6f5', s:syntax_color('diff', ['! changed'], 1, 3))

  " Options must apply on reload and must not mutate user configuration.
  let g:oxide_transparent = 1
  let g:oxide_italic_comments = 0
  let g:oxide_colors = {'teal': '#ed756e', 'red': '#ff0000'}
  let s:overrides = copy(g:oxide_colors)
  colorscheme oxide
  call assert_equal('', s:attr('Normal', 'bg#'))
  call assert_equal('', s:attr('SignColumn', 'bg#'))
  call assert_equal('', s:attr('StatusLine', 'bg#'))
  call assert_equal('', s:attr('Comment', 'italic'))
  call assert_equal('#ed756e', s:attr('Function', 'fg#'))
  call assert_equal('#ff0000', s:attr('ErrorMsg', 'fg#'))
  call assert_equal('#ff0000', g:terminal_ansi_colors[1])
  call assert_equal('#2e2e2e', s:attr('Visual', 'bg#'))
  call assert_equal(s:overrides, g:oxide_colors)
  for s:group in ['Search', 'IncSearch', 'CurSearch', 'Substitute', 'Cursor']
    call assert_equal('#161616', s:attr(s:group, 'fg#'), s:group . ' needs an opaque foreground')
  endfor

  let g:oxide_terminal_colors = 0
  let g:terminal_ansi_colors = repeat(['#123456'], 16)
  colorscheme oxide
  call assert_equal(repeat(['#123456'], 16), g:terminal_ansi_colors)
  unlet g:terminal_ansi_colors
  colorscheme oxide
  call assert_false(exists('g:terminal_ansi_colors'))

  " Palette overrides take precedence over transparency, as in the Neovim port.
  let g:oxide_colors = {'base': '#202020'}
  colorscheme oxide
  call assert_equal('#202020', s:attr('Normal', 'bg#'))
  call assert_equal('', s:attr('StatusLine', 'bg#'))
  call assert_equal('#202020', s:attr('Search', 'fg#'))

  unlet g:oxide_transparent g:oxide_italic_comments g:oxide_colors g:oxide_terminal_colors
  colorscheme default
  colorscheme oxide
  call assert_equal('#161616', s:attr('Normal', 'bg#'))
  call assert_equal('#00baaa', s:attr('Function', 'fg#'))
  call assert_equal('1', s:attr('Comment', 'italic'))
  call assert_equal('#ed756e', g:terminal_ansi_colors[1])

  augroup oxide_test
    autocmd!
    autocmd ColorScheme oxide highlight Function guifg=#abcdef
  augroup END
  colorscheme oxide
  call assert_equal('#abcdef', s:attr('Function', 'fg#'))
  augroup oxide_test
    autocmd!
  augroup END
catch
  call add(v:errors, v:exception . ' at ' . v:throwpoint)
endtry

if !empty(v:errors)
  call writefile(v:errors, '/dev/stderr')
  cquit
endif
qa!
