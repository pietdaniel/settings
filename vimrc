set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set number
colorscheme noctu 
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
