"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/peregrinator/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/peregrinator/.vim/bundles')
  call dein#begin('/home/peregrinator/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('/home/peregrinator/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Plugins:  
  " Convenient code typing
  call dein#add('junegunn/vim-easy-align')
  call dein#add('junegunn/goyo.vim')
  call dein#add('junegunn/limelight.vim')
  call dein#add('ervandew/supertab')
  " call dein#add('ervandew/matchem')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('psliwka/vim-smoothie')
  call dein#add('Yggdroot/indentLine')
  call dein#add('tpope/vim-commentary')

  " Fixme: on demand loading; Nerdtree
  call dein#add('preservim/nerdtree')
  " Todo: complete setup for Nerdcommenter
  " call dein#add('scrooloose/nerdcommentor')

  " Interactive scratchpad
  " call dein#add('metakirby5/codi.vim')

  " Language/file-type plugins
  " lisp
  call dein#add('vim-scripts/paredit.vim', {'on_ft': 'lisp'})

  " org-mode
  call dein#add('jceb/vim-orgmode', {'on_ft': 'org'})

  " vimwiki - org-mode like vim mode?
  call dein#add('vimwiki/vimwiki', {'on_ft': 'wiki'})
  
  " R stuff
  call dein#add('jalvesaq/Nvim-R', {'on_ft': 'R,Rmd'})
  " (R-)completion
  "  call dein#add('rdnetto/YCM-Generator')
  
  "  call dein#add('ncm2/ncm2')
  "  call dein#add('roxma/nvim-yarp')
  "  call dein#add('gaalcaras/ncm-R')
  " vim-8 specific requirement
  "  call dein#add('roxma/vim-hug-neovim-rpc')
  
  " Better Rmarkdown syntax
  call dein#add('vim-pandoc/vim-pandoc-syntax')

  " Themes
  call dein#add('brihadeesh/vim-mephistopheles')
  call dein#add('brihadeesh/vim-solarizedless')
  call dein#add('brihadeesh/vim-viz-mod')
  "  call dein#add('brihadeesh/vim-selenizedless') NOTE: this has been moved to vim-colors-plain
  call dein#add('brihadeesh/vim-colors-plain')
  call dein#add('brihadeesh/vim-zen')
  call dein#add('brihadeesh/wal.vim')

  " third party
  call dein#add('xdefrag/vim-beelzebub') 
  call dein#add('zefei/simple-dark')
  call dein#add('huyvohcmc/atlas.vim')
  call dein#add('cormacrelf/vim-colors-github')
  call dein#add('vim-scripts/pyte')
  call dein#add('jdsimcoe/abstract.vim')
  call dein#add('chase/focuspoint-vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------


"Configs----------------------------------

set encoding=utf-8

set textwidth=100

" line numbers
set number

" Show cursor position always
set ruler         		

" Display incomplete commands
set showcmd       		

" Enable incremental search
set incsearch     		

" Always hide status line
set laststatus=0  		

" Automatically :write before running commands
set autowrite     		

" highlight current line
set cursorline			

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Centred cursor
augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
augroup END


" ncm2: enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone,noselect
" Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"noremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
"set shortmess+=c


" Super-tab completion
let g:SuperTabDefaultCompletionType = "<c-n>"


" Pandoc-syntax for Rmd files
augroup pandoc_syntax
        au! BufNewFile,BufFilePre,BufRead *.[r]md set filetype=markdown.pandoc
augroup END


" indentline config
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" let g:indentLine_char = '┆'


" Limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#626262'
" Default: 0.5
let g:limelight_default_coefficient = 0.7
" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1
" Beginning/end of paragraph
" When there's no empty line between the paragraphs
" and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
" Highlighting priority (default: 10)
" Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
" Goyo integration
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!


" Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" NERDTree
" Usage
"   - '?' opens quick help
"   - 'zz' opens and 'q' closes NERDTree ('zz 'requires setting below)
"       - 't' opens file in new tab
"       - 'T' opens file in new tab silently
"   - 'gt' and 'gT' switch between tabs
"       - 'm' opens menu mode for creating/deleting files, 'Ctrl-c' to exit out of this mode
"
" Settings
" Opens NERDTree with custom shortcut, here 'nn'
let mapleader = "n"
nmap <leader>n :NERDTreeToggle<cr>
" Instruct NERDTree to always opens in the current folder
"set autochdir
"let NERDTreeChDirMode=2
"nnoremap <leader>n :NERDTree .<CR>
" Optional to show special NERDTree browser characters properly (e.g. on remote linux system)
let g:NERDTreeDirArrows=0
" Show bookmarks by default
let NERDTreeShowBookmarks=1



" Important: complete Nvim-R config 

"set colourscheme
" colorscheme solarizedless
" colorscheme beelzebub
" colorscheme simple-dark
" colorscheme mephistopheles
" colorscheme viz-mod
" set background=dark
" colorscheme zen

" Enable GUI colors for the terminal to get truecolor
" set termguicolors 
" set background=dark
" colorscheme balaam
" colorscheme duotone-selenized
" colo atlas
" hi Normal guibg=NONE ctermfg=NONE
colorscheme wal
" only for acme; TODO: incorporate into json scheme/wal.vim??
hi CursorLine ctermbg=229 guibg=#ffffaf ctermfg=NONE guifg=NONE cterm=NONE term=NONE
