" __     _____ __  __   _       _                     
" \ \   / /_ _|  \/  | (_)___  | |    _____   _____   
"  \ \ / / | || |\/| | | / __| | |   / _ \ \ / / _ \  
"   \ V /  | || |  | | | \__ \ | |__| (_) \ V /  __/_ 
"    \_/  |___|_|  |_| |_|___/ |_____\___/ \_/ \___(_)
"                                                     




" # ======== P L U G I N S ========= #
"
" GitHub Page: https://github.com/junegunn/vim-plug
"
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged/') " ('~/.vim/plugged')
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" Plug 'ivanov/vim-ipython' 

" Functions:
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'

" Line:
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color Scheme:
Plug 'doums/darcula'

" Syntax:
Plug 'calviken/vim-gdscript3'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Plug 'hdima/python-syntax'

" LaTeX:
Plug 'lervag/vimtex'

" Git:
" Plug 'tpope/vim-fugitive'

" Completion:
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" COC extensions:
" :CocInstall coc-vimtex
" :CocInstall coc-snippets

call plug#end()


" Load all Functions

runtime! foo/**/*.vim


"   P L U G I N S   C O N F I G U R A T I O N 
"
" --> semshi

autocmd FileType python call IntellyJ_highlikes()
" autocmd ColorScheme * call IntellyJ_highlikes()


" --> vim-airline

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀'

let g:airline_theme='deus'
" let g:airline#extensions#vimtex#enabled = 1

" --> vimtex
" Autocompletion
let g:vimtex_complete_enabled = 1
" call deoplete#custom#var('omni', 'input_patterns', {
"       \ 'tex': g:vimtex#re#deoplete
"       \})
"
" :CocInstall coc-vimtex
" :h vimtex-complete-coc.nvim
" let g:vimtex_compiler_progname = 'nvr' " neovim-remote


" --> kite

let g:kite_supported_languajes = ['python', 'javascript']


" --> coc

autocmd FileType python let b:coc_suggest_disable = 1
autocmd FileType javascript let b:coc_suggest_disable = 1
" autocmd FileType scss setl iskeyword+=@-@

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

runtime mapping.vim
runtime general.vim
runtime indents.vim
runtime darcula.vim

echom ">^.^<"
