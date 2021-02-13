"   __  __                   _                 
"  |  \/  | __ _ _ __  _ __ (_)_ __   __ _ ___ 
"  | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
"  | |  | | (_| | |_) | |_) | | | | | (_| \__ \
"  |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"               |_|   |_|            |___/     




" Explanation Mappings:
" https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping


let mapleader =","  " It defines the key for the map leader


" ---------- N E R D T R E E ----------- "

nnoremap <leader>ntt :NERDTreeToggle<CR>


" ------------- L a T e X -------------- "

" Begin <This> environment:
:noremap \bb bcw\begin{<C-R>"}<CR>\end{<C-R>"}<ESC>O

" Begin itemize environment:
:noremap \bi cw\begin{itemize}<CR>\end{itemize}<ESC>O\item<SPACE>

" Begin section:
:noremap \bs <C-V>0c\section{<C-R>"}<CR><CR><ESC>O
" :noremap \bs i\section{}<ESC>i

" Begin chapter:
:noremap \bc <C-V>0c\chapter[<C-R>"]{<C-R>"}<CR>\chaptermark{<C-R>"}<CR><CR><ESC>O
" :noremap \bc i\chapter{}<ESC>i
