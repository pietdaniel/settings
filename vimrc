set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set number
set linebreak

hi  VertSplit  guifg=None guibg=None gui=None
hi  StatusLine guifg=None
hi  StatusLineNC guifg=None
hi clear VertSplit

set fillchars+=stl:-,stlnc:-,vert:│

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

syntax on
filetype plugin indent on
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))

execute pathogen#infect()

inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

nmap ,n :NERDTreeToggle<CR> 
map <F5> :JavaCorrect<CR>
imap <Tab> <C-X><C-U>

let delimitMate_expand_cr = 1

colorscheme danteTwo


" ultisnips 

" Track the engine.
" Plugin 'ultisnips'

" Snippets are separated from the engine. Add this if you want them:
" Plugin 'vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<s-tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-space>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"









