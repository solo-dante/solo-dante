"source $VIMRUNTIME/vimrc_example.vim
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME

"Pathogen plugin manager
execute pathogen#infect()
syntax on
filetype plugin indent on

set hls
set is
set cb=unnamed
set bg=dark
set ts=4
set sw=4
set si
filetype on
set ruler

"Manage swp files
set undodir=~/.vim/tmp//
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//


"Key mapping here
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>
inoremap {{ {
inoremap {} {}
nnoremap <silent> <TAB> :tabnext<CR>


"Build and execute command keyword
autocmd filetype cpp nnoremap <F9> :w <bar> !gnome-terminal -- bash -c "g++ -std=c++17 % -o %:r -O2 -Wall;echo;echo Press Enter to continue;read line;exit" -hold<CR>
autocmd filetype cpp nnoremap <F10> :<C-U>!gnome-terminal -- bash -c "./%:r;echo;echo Press Enter to continue;read line;exit" -hold<CR>
autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
autocmd filetype java nnoremap <F9> :w <bar> !gnome-terminal -- bash -c "javac %;echo;echo Press Enter to continue;read line;exit" -hold<CR>
autocmd filetype java nnoremap <F10> :!gnome-terminal -- bash -c "java %:r;echo;echo Press Enter to continue;read line;exit" -hold<CR>


"Theme
"autocmd vimenter * ++nested colorscheme gruvbox
autocmd vimenter * ++nested colorscheme default

"" AirLine settings
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
"let g:airline_powerline_fonts=1
"=====================================================

"Use a line cursor witing insert mode and a block cursor everywhere else
"
"Reference chart of values
" Ps = 0 -> blinking block;
" Ps = 1 -> blinking block (default)
" Ps = 2 -> steady block
" Ps = 3 -> blinking underline
" Ps = 4 -> Steady underline
" Ps = 5 -> Blinking bar (xterm)
" Ps = 6 -> steady bar (xterm)

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
"toggle between number and relative number
set nu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
