" .vimrc
set encoding=utf-8

" load up pathogen and all bundles
call pathogen#infect()
call pathogen#helptags()

syntax on                         " show syntax highlighting
filetype plugin indent on
set autoindent                    " set auto indent
set ts=4                          " set indent to 2 spaces
set shiftwidth=4
set expandtab                     " use spaces, not tab characters
set nocompatible                  " don't need to be compatible with old vim
set relativenumber                " show relative line numbers
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set list listchars=tab:»·,trail:· " show extra space characters
set nofoldenable                  " disable code folding
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
runtime macros/matchit.vim        " use % to jump between start/end of methods

" put git status, column/row number, total lines, and percentage in status
" set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]
" set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set statusline=%F\ [%{strlen(&fenc)?&fenc:'none'}]%h%m%r%y%=%l/%L\ %P

" set dark background and color scheme
" :q
" set background=dark
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme spacegray

" set leader key to comma
let mapleader = ","

" clang settings
let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
let g:clang_user_options = '-std=c++11'
if isdirectory(s:clang_library_path)
    let g:clang_library_path=s:clang_library_path
endif

" ctrlp config
let g:ctrlp_map = '<leader>f'
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0

" use silver searcher for ctrlp
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" quick out of insert mode
imap jj <Esc>

" swedish characters
map <silent> å <C-]>
map! <silent> ö {
map! <silent> ä }
map! <silent> Ö [
map! <silent> Ä ]
set langmap=ö{,ä},Ö[,Ä]

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" unmap F1 help
nmap <F1> <nop>
imap <F1> <nop>

" unmap ex mode: 'Type visual to go into Normal mode.'
nnoremap Q <nop>

" map . in visual mode
vnoremap . :norm.<cr>

" map markdown preview
map <leader>m :!open -a Marked %<cr><cr>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" map git commands
map <leader>b :Gblame<cr>
map <leader>l :!clear && git log -p %<cr>
map <leader>d :!clear && git diff %<cr>

" map Silver Searcher
map <leader>a :Ag!<space>

" clear the command line and search highlighting
noremap <C-l> :nohlsearch<CR>

" toggle spell check with <F5>
map <F5> :setlocal spell! spelllang=en_us<cr>
imap <F5> <ESC>:setlocal spell! spelllang=en_us<cr>

" add :Plain command for converting text to plaintext
command! Plain execute "%s/’/'/ge | %s/[“”]/\"/ge | %s/—/-/ge"

" jump to last position in file
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" multi-purpose tab key (auto-complete)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" rename current file, via Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>
