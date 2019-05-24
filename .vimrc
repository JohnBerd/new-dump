execute pathogen#infect()
set background=dark
colorscheme gruvbox
syntax enable
set mouse=a
set nu
set nohlsearch

autocmd FileType * set expandtab | set tabstop=4 | set shiftwidth=4 |set softtabstop=4
autocmd FileType cpp set noexpandtab | set tabstop=2 | set shiftwidth=2 |set softtabstop=2
autocmd FileType hpp set noexpandtab | set tabstop=2 | set shiftwidth=2 |set softtabstop=2

autocmd FileType c,h highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

filetype on
filetype plugin on
filetype indent on

autocmd bufnewfile *.c so ~/.vim/epitech_header
autocmd bufnewfile *.cpp so ~/.vim/epitech_header
autocmd bufnewfile *.h so ~/.vim/epitech_header
autocmd bufnewfile *.hpp so ~/.vim/epitech_header
autocmd bufnewfile Makefile so ~/.vim/epitech_header_make

autocmd VimLeave *.c :normal 7gg=G
autocmd VimLeave *.h :normal 7gg=G

autocmd FileType c,cpp :iabbrev main int main(int ac, char **av)<right><CR>{<CR><TAB>return (0)<CR>}<up><up>

set undodir=~/.vim/undodir
set undofile

set laststatus=2
