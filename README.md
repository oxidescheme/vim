<div align="center">

# oxide for Vim

</div>

<h6 align="center">
Where function meets form.
</h6>

<p align="center">
  <a href="https://github.com/oxidescheme/vim/stargazers"><img src="https://img.shields.io/github/stars/oxidescheme/vim?style=for-the-badge&color=2e2e2e&labelColor=161616"></a>
  <a href="https://github.com/oxidescheme/vim/issues"><img src="https://img.shields.io/github/issues/oxidescheme/vim?style=for-the-badge&color=2e2e2e&labelColor=161616"></a>
  <a href="https://discord.gg/p8GcbBH5MR"><img src="https://img.shields.io/discord/1450777325267456097?style=for-the-badge&color=2e2e2e&labelColor=161616&logo=discord&logoColor=cecece"></a>
</p>

*oxide* for [Vim](https://www.vim.org/). A dark colorscheme with monochrome UI, standard syntax highlighting, and additional Markdown, HTML, JSON, YAML, and TOML highlights.

Requires Vim 8.2+ with a true-color terminal, or gVim. No Lua or other plugins required. Terminal Vim needs `set termguicolors`; a 256-color fallback is not included.

## Installation

### [vim-plug](https://github.com/junegunn/vim-plug)

Add this inside your existing `plug#begin()` / `plug#end()` block:

```vim
Plug 'oxidescheme/vim'
```

Run `:PlugInstall`, then add this after `plug#end()` in your vimrc:

```vim
syntax enable
set termguicolors
colorscheme oxide
```

### Manual

Copy [colors/oxide.vim](colors/oxide.vim) to `~/.vim/colors/oxide.vim` (create the directory if needed). On Windows, use `~/vimfiles/colors/oxide.vim`.

Add this to your vimrc (`~/.vimrc`, or `~/_vimrc` on Windows):

```vim
syntax enable
set termguicolors
colorscheme oxide
```

## Configuration

Set options before `colorscheme oxide`. These are the defaults:

```vim
let g:oxide_transparent = 0
let g:oxide_italic_comments = 1
let g:oxide_terminal_colors = 1
let g:oxide_colors = {}
```

`oxide_transparent` removes the main and status-line backgrounds. `oxide_terminal_colors` sets the 16 ANSI colors used by newly opened `:terminal` windows.

Override palette colors by name:

```vim
let g:oxide_colors = {'teal': '#ed756e'}
colorscheme oxide
```

For individual highlights, use Vim's `ColorScheme` event:

```vim
augroup oxide_custom
  autocmd!
  autocmd ColorScheme oxide highlight Comment gui=NONE cterm=NONE
augroup END
```

Define the autocommand before loading the theme. Run `:colorscheme oxide` again after changing options.

Syntax detail depends on Vim's syntax files. Neovim Tree-sitter, LSP, and plugin integrations are not included.

## Contributing

PRs welcome, including Vim plugin integrations and syntax improvements. Keep colors consistent with the [canonical Neovim palette](https://github.com/oxidescheme/nvim/blob/main/lua/oxide/colors.lua) and follow the [UI color guide](https://github.com/oxidescheme/oxide/blob/main/UI_COLOR_GUIDE.md).

Run the checks from the repository root:

```sh
vim -Nu NONE -n -i NONE -es -S test/theme.vim
```

## Credits

- **Port Creator:** [@jakmaz](https://github.com/jakmaz)
- **Current Maintainer:** [@jakmaz](https://github.com/jakmaz)
- **Contributors:** See [contributors list](https://github.com/oxidescheme/vim/graphs/contributors)

## License

MIT License - see [LICENSE](LICENSE) for details.

<p align="center">
Copyright &copy; 2026-present oxidescheme
</p>
