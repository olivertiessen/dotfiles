" Show relative line numbers
set rnu

" Show line and column number in the status bar
set ruler

" Enable mouse support
set mouse=a

" Neovim's default dark colours (0.10+)
set background=dark
if has('termguicolors')
  set termguicolors
endif
syntax on
hi Normal       guifg=#e0e2ea guibg=#14161b
hi Comment      guifg=#9b9ea4
hi String       guifg=#b3f6c0 ctermfg=10
hi Identifier   guifg=#a6dbff ctermfg=12
hi Function     guifg=#8cf8f7 ctermfg=14
hi Special      guifg=#8cf8f7 ctermfg=14
hi Directory    guifg=#8cf8f7 ctermfg=14
hi Question     guifg=#8cf8f7 ctermfg=14
hi Statement    guifg=#e0e2ea gui=bold cterm=bold
hi Title        guifg=#e0e2ea gui=bold cterm=bold
hi Todo         guifg=#e0e2ea gui=bold cterm=bold
hi! link Constant  Normal
hi! link Type      Normal
hi! link PreProc   Normal
hi! link Operator  Normal
hi! link Delimiter Normal
hi LineNr       guifg=#4f5258
hi NonText      guifg=#4f5258
hi SpecialKey   guifg=#4f5258
hi CursorLine   guibg=#2c2e33
hi CursorLineNr gui=bold cterm=bold
hi Visual       guibg=#4f5258
hi Search       guifg=#eef1f8 guibg=#6b5300 ctermfg=0 ctermbg=11
hi IncSearch    guifg=#07080d guibg=#fce094 ctermfg=0 ctermbg=11
hi MatchParen   guibg=#4f5258 gui=bold cterm=bold
hi StatusLine   guifg=#2c2e33 guibg=#c4c6cd
hi StatusLineNC guifg=#e0e2ea guibg=#4f5258
hi VertSplit    guifg=#e0e2ea guibg=#14161b
hi Pmenu        guibg=#2c2e33
hi Folded       guifg=#9b9ea4 guibg=#07080d
hi Error        guifg=#eef1f8 guibg=#590008 ctermfg=0 ctermbg=9
hi ErrorMsg     guifg=#ffc0b9 ctermfg=9
hi WarningMsg   guifg=#fce094 ctermfg=11
hi ModeMsg      guifg=#b3f6c0 ctermfg=10
hi DiffAdd      guifg=#eef1f8 guibg=#005523
hi DiffChange   guifg=#eef1f8 guibg=#4f5258
hi DiffDelete   guifg=#ffc0b9 gui=bold
hi DiffText     guifg=#eef1f8 guibg=#007373

" Incremental search
set incsearch

" Highlight search matches
set hlsearch

" Ignore case unless there's a capital letter
set ignorecase
set smartcase

" Automatically reload file if changed outside
set autoread
autocmd FocusGained,BufEnter * checktime

" Remember cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" | endif
endif

" Disable swap and backup files (optional)
set noswapfile
set nobackup
set nowritebackup
