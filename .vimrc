syntax enable
set mouse=a
set nu
set nohlsearch

autocmd FileType * set expandtab | set tabstop=4 | set shiftwidth=4 |set softtabstop=4
autocmd FileType cpp set noexpandtab | set tabstop=8 | set shiftwidth=8 |set softtabstop=8
autocmd FileType hpp set noexpandtab | set tabstop=8 | set shiftwidth=8 |set softtabstop=8

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
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

autocmd FileType c :iabbrev main int main(int ac, char **av)<left><left>

set undodir=~/.vim/undodir
set undofile
