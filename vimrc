let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set backupcopy=yes
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

let g:flow#enable = 0

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Strip Whitespace
nnoremap <leader>ws :StripWhitespace<CR>

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Numbers
set number
set numberwidth=5
set relativenumber

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>


"MATTS ADDITIONS
"This is the new place for stuff, only add stuff to this one
"
map <C-n> :NERDTreeToggle<CR>


set statusline+=%#warningmsg#
set statusline+=%*

""Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Open new split panes to right and bottom which feels more natural
set splitbelow
set splitright


" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
set cursorline    " highlight the current line the cursor is on

let mapleader = "\<Space>"
set spelllang=en_gb

" Indentation
nnoremap <Leader>i gg=G``
nnoremap == gg=G``


"Enable mouse
set mouse=a
"set to name of terminal
set ttymouse=xterm2


map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

"Emmet
let g:user_emmet_leader_key=','

"open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" source vimrc
nnoremap <leader>es :so $MYVIMRC

"make ctrl-c work with vim on a mac
vnoremap <C-c> :w !pbcopy<CR><CR> noremap <C-v> :r !pbpaste<CR><CR>

"autosave when focus lost
:au FocusLost * :wa

set ignorecase
set smartcase
" save automatically when text is changed
set updatetime=200
au CursorHold * silent! update

" Two keyletter search EasyMotion
nmap s <Plug>(easymotion-s2)

" " such very magic
:nnoremap / /\v
:cnoremap %s/ %s/\v"

"Jsx highlighting with .js files
let g:jsx_ext_required = 0
