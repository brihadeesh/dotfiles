" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Plugin for current colorscheme pywal shit
Plug 'peregrinat0r/vim-mephistopheles'

" Distraction free text editor
Plug 'junegunn/goyo.vim'

" Limelight to highlight the section of text being edited
Plug 'junegunn/limelight.vim'

" Nvim-R
Plug 'jalvesaq/Nvim-R'

" Completions
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'gaalcaras/ncm-R'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
noremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Optional: for snippet support
" Further configuration might be required, read below
" Plug 'sirver/UltiSnips'
" Plug 'ncm2/ncm2-ultisnips'

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" Optional: better Rnoweb support (LaTeX completion)
" Plug 'lervag/vimtex'

" Better syntax highlighting for Rmarkdown files
Plug 'vim-pandoc/vim-pandoc-syntax'

augroup pandoc_syntax
        au! BufNewFile,BufFilePre,BufRead *.[r]md set filetype=markdown.pandoc
augroup END

" Use tab for completions rather than <C-x> <C-o> which is bloody tedious
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

" Pairing brackets
" Plug 'ervandew/matchem'
Plug 'jiangmiao/auto-pairs'

" smooth scrolling??
Plug 'psliwka/vim-smoothie'

" interactive scratchpad for R and stuff? TODO: replacement for Radian(?)
Plug 'metakirby5/codi.vim'

" better indenting visibility??
Plug 'Yggdroot/indentLine'

" Initialize plugin system
call plug#end()


"""" Configurations

"" Misc settings
set textwidth=100
set ruler         		" show the cursor position all the time
set showcmd       		" display incomplete commands
set incsearch     		" do incremental searching
set laststatus=0  		" Always display the status line
set autowrite     		" Automatically :write before running commands
set cursorline 			" highlight current line 

filetype indent plugin on
" Open new split panes to right and bottom, which feels more natural
set splitbelow
" set splitright

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
" set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell


"" Set color scheme
set background=dark
colo mephistopheles

" indentline config
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" let g:indentLine_char = '┆'

""" Goyo
" Width
" Goyo 120

" Height
" Goyo x30

" Both
" Goyo 120x30

" In percentage
" Goyo 120x50%

" With offsets
" Goyo 50%+25%x50%-25%

"function! s:goyo_enter()
"  let b:quitting = 0
"    let b:quitting_bang = 0
"      autocmd QuitPre <buffer> let b:quitting = 1
"        cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
"	endfunction

"function! s:goyo_leave()
"  " Quit Vim if this is the only remaining buffer
"  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
"    if b:quitting_bang
"      qa!
"    else
"      qa
"    endif
"  endif
"endfunction

"autocmd! User GoyoEnter call <SID>goyo_enter()
"autocmd! User GoyoLeave call <SID>goyo_leave()


""" Limelight

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
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Goyo integration
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


""""""""

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"""" Configs for Nvim-R
let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1

" Preferred default settings
set nowrap

" start R with F2 key
" map <F2> <Plug>RStart
" imap <F2> <Plug>RStart
" vmap <F2> <Plug>RStart
" R version can be specified like this:
" let vimrplugin_r_path = "/opt/R/3.1.2-release/bin/R"
" Send selection or line to R with space bar, respectively.
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" Shortcut for R's assignment operator: 0 turns it off; 1 assigns underscore; 2 assigns two 
" underscores
let R_assign = 2

" Ensures usage of your own ~/.tmux.conf file
let R_notmuxconf = 1

" Shows function arguments in a separate viewport during omni completion with Ctrl-x Ctrl-o:w
let R_show_args = 1

" Use Ctrl-Space to do omnicompletion
inoremap <C-Space> <C-x><C-o>

" Remove white background of status line at bottom of nvim viewport (default is 2)
"set laststatus=1

"let R_in_buffer = 0
"let R_tmux_split = 1
"let R_applescript = 0
"let R_tmux_close = 0

" The following provides a zoom functionality, similar to Tmux's Ctrl-a z, by pressing 'gz' in 
" normal mode.
"function ZoomWindow()
"	 let cpos = getpos(".")
"	 tabnew %
"	 redraw
"	 call cursor(cpos[1], cpos[2])
"	 normal! zz
"endfunction
"nmap gz :call ZoomWindow()<CR>

"""NERDTree Plugin
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


" Centred cursor
augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
augroup END

