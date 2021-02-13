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

Plug 'preservim/nerdtree'
" Help: https://jdhao.github.io/2018/09/10/nerdtree_usage/

" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

Plug 'doums/darcula'

" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'lervag/vimtex'

" Plug 'ivanov/vim-ipython'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" COC Extensions:
" :CocInstall coc-vimtex
" :CocInstall coc-snippets

" Plug 'mhinz/neovim-remote'

Plug 'calviken/vim-gdscript3'

" Initialize plugin system
call plug#end()

"   P L U G I N S   C O N F I G U R A T I O N 
"
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


source $HOME/.config/nvim/mapping.vim
source $HOME/.config/nvim/general.vim
source $HOME/.config/nvim/indents.vim
source $HOME/.config/nvim/darcula.vim
