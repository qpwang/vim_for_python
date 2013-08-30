" basic Settings
set nocompatible "不兼容vi
set backupskip=/tmp/* "不需要备份的目录
syntax enable "语法高亮
filetype plugin indent on " 检测文件类型 匹配插件 缩进
autocmd FileType html set shiftwidth=2 | set expandtab "html文件缩进为2个空格
set number "显示代码行数
set title "terminal显示标题
set mouse+=a "鼠标可用
set clipboard=unnamed " yank and paste with the system clipboard
set directory-=. " don't store swapfiles in the current directory

"Setting colors
set background=dark
colorscheme solarized 
set t_Co=256

"don't bell or blink
set noerrorbells
""set vb t_vb

" ingore there files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=egg/**
set wildignore+=*.egg-info/**
" show a navigable menu for tab completion
set wildmenu
set wildmode=full

set grepprg=ack

"Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"Disable the colorcolumn when switching modes.  Make sure this is the
"first autocmd for the filetype here
autocmd FileType * setlocal colorcolumn=0

"Insert completion
set completeopt=menuone,longest,preview
set pumheight=6

"Moving Around/Editing
set cursorline
set nostartofline
set virtualedit=block
set scrolloff=3
set backspace=2
set showmatch
set nowrap
set linebreak
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set foldmethod=indent
set foldlevel=99

"Reading/Writing
set noautowrite
set noautowriteall
set noautoread
set modeline
set modelines=5
set ffs=unix,dos,mac

"Message, Info, Status
set ls=2
set vb t_vb=
set confirm
set showcmd
set report=0
set shortmess+=a
set ruler
set laststatus=2
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
set list

"Searching and Patterns
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

"Paste from clipboard
map <leader>p "+p

"Quit window on <leader>q
nnoremap <leader>q :q<CR>

"hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

"Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

"Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! ToggleBackground()
    if (w:solarized_style=="dark")
        let w:solarized_style="light"
        colorscheme solarized
    else
        let w:solarized_style="dark"
        colorscheme solarized
    endif
endfunction

command! Togbg call ToggleBackground()
nnoremap <F4> :call ToggleBackground()<CR>
inoremap <F4> <ESC> :call ToggleBackground()<CR>a
vnoremap <F4> <ESC> :call ToggleBackground()<CR>


"Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    "Let Vundle manage Vundle
    "required!
    Bundle 'gmarik/vundle'
    " My Bundles here:
    Bundle 'The-NERD-tree'
    Bundle 'pep8'
    Bundle 'ctrlp.vim'
    Bundle 'Solarized'
    Bundle 'TaskList.vim'
    Bundle 'Gundo'
    Bundle 'python.vim'
    Bundle 'compilerpython.vim'
    Bundle 'pyflakes.vim'
    Bundle 'mattn/zencoding-vim'
    Bundle 'SuperTab'
    Bundle 'fugitive.vim'
    Bundle 'Command-T'
    Bundle 'ctags.vim'
    Bundle 'taglist.vim'
    Bundle 'taglist-plus'
    Bundle 'surround.vim'
    Bundle 'The-NERD-Commenter'
    "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echi ""
        :BundleInstall
    endif
"Setting up Vundle - the vim plugin bundler end


"Window Splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"TaskList
map <leader>td <Plug>TaskList

"Gundo
map <leader>g :GundoToggle<CR>

"NerdTree
map <leader>n :NERDTreeToggle<CR>

"pep8
let g:pep8_map='<leader>8'

"Jump to the definition of whatever the cursor is on
map <leader>j :RopeGotoDefinition<CR>

"Rename
map <leader>r :RopeRename<CR>

"Run command-t file search
map <leader>f: CommandT<CR>



"ctags
set tags=~/mytags

"Tlist
map <F3> :silent! Tlist<CR>
let Tlist_Use_Right_Window=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"autopep8
map <F4> :call FormartSrc()<CR>

"定义FormartSrc()
func FormartSrc()
exec "w"
if &filetype == 'c'
exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
elseif &filetype == 'cpp' || &filetype == 'hpp'
exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
elseif &filetype == 'perl'
exec "!astyle --style=gnu --suffix=none %"
elseif &filetype == 'py'||&filetype == 'python'
exec "r !autopep8 -i --aggressive --max-line-length 80 %"
elseif &filetype == 'java'
exec "!astyle --style=java --suffix=none %"
elseif &filetype == 'jsp'
exec "!astyle --style=gnu --suffix=none %"
elseif &filetype == 'xml'
exec "!astyle --style=gnu --suffix=none %"
endif
exec "e! %"
endfunc
"结束定义FormartSrc
