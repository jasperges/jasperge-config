set encoding=utf-8
" Pathogen
" execute pathogen#infect()

" Vundle
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim'}
Plugin 'taglist.vim'
Plugin 'restore_view.vim'
Plugin 'ervandew/supertab'
Plugin 'AutoComplPop'
" Plugin 'othree/html5.vim'
" Plugin 'fatih/vim-go'
" Plugin 'garbas/vim-snipmate'
Plugin 'Sirver/ultisnips'
Plugin 'honza/vim-snippets'
" Plugin 'AutoClose'
call vundle#end()
filetype plugin indent on

let g:Powerline_symbols = 'fancy'

" Japsers dingetjes
set background=dark
colorscheme solarized
let g:python_recommended_style = 0
set number
set modeline
set listchars=eol:¬,tab:>―,space:·
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
set shiftround
set expandtab
set autoread    " reload file when changes happen in another editor
" make yank copy to the global system clipboard
set clipboard=unnamed
" Fast navigation between tabs
" map <Leader>, <esc>:tabprevious<CR>
" map <Leader>. <esc>:tabnext<CR>
" better indentation for code blocks
vnoremap < <gv
vnoremap > >gv
" Delete comment character when joining commented lines
set formatoptions+=j
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
set laststatus=2
" Map TagList toggle to <leader> t
nnoremap <Leader>t <esc>:Tlist<CR>
let g:Tlist_Inc_Winwidth = 1

" Synstastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" let g:syntastic_python_checkers = ['python', 'flake8', 'pep8', 'pylint', 'pyflakes']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_python_exec = 'python'
" let g:syntastic_python_flake8_exe = 'python -m flake8'
" let g:syntastic_python_pep8_exe = 'python -m pep8'
" let g:syntastic_python_pylint_exe = 'python -m pylint'
" let g:syntastic_python_pyflakes_exe = 'python -m pyflakes'
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_aggregate_errors = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_python_pylint_args =
    \ '--max-line-length=120 --extension-pkg-whitelist=PySide,shiboken'
" let g:syntastic_python_pylint_args = '--extension-pkg-whitelist=PySide'
" let g:syntastic_python_flake8_args = '--max-line_length=120'
let g:syntastic_mode_map = { "mode": "passive", "active_filetypes": [], "passive_filetypes": [] }
nnoremap <Leader>s <esc>:SyntasticCheck<CR>
nnoremap <Leader>a <esc>:SyntasticReset<CR>

" Show trailing whitespace
" =========================
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
map <Leader>x :%s/\s\+$//<CR>

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" set backup		" keep a backup file (restore to previous version)
set nobackup
set undofile		" keep an undo file (undo changes after closing)
set history=700		" keep 700 lines of command line history
set undolevels=700
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch

" Awesome line number magic
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <Leader>l :call NumberToggle()<cr>
:au FocusLost * set number
:au FocusGained * set relativenumber
autocmd InsertEnter * set number
autocmd InsertLeave * set relativenumber
set relativenumber

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Color column at 80 and 120
set colorcolumn=80,120

" Fold settings
" augroup vimrc
"     au BufReadPre * setlocal foldmethod=indent
"     au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END
set foldnestmax=2
set foldcolumn=2
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Search and replace mappings
nnoremap <Leader>f :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" CtrlP options
nnoremap <leader>. :CtrlPTag<CR>

" tags
set tags+=tags;/,.git/tags;/

" Case sensitivity
set ignorecase
set smartcase

" view settings
set viewoptions=cursor,folds,slash,unix

" run file with python
autocmd FileType python nnoremap <buffer> <Leader>p :exec '!python' shellescape(@%, 1)<CR>

" autocomplete for html
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Autocomplete snippets
" fun! GetSnipsInCurrentScope()
"     let snips = {}
"     for scope in [bufnr('%')] + split(&ft, '\.') + ['_']
"         call extend(snips, get(s:snippets, scope, {}), 'keep')
"         call extend(snips, get(s:multi_snips, scope, {}), 'keep')
"     endfor
"     return snips
" endf
" let g:acp_behaviorSnipmateLength = 1

set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
set cursorline
nmap <Leader>c <Plug>ToggleAutoCloseMappings
