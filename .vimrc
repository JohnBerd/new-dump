execute pathogen#infect()
set background=dark
set termguicolors
colorscheme gruvbox
syntax enable
set mouse=a
set nu
set nohlsearch
set nobackup
set nowritebackup
set noswapfile

"NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
map <C-n> :NERDTreeTabsToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

map <C-Right> :tabn<CR>
map <C-Left> :tabp<CR>
imap <C-Right> <esc>:tabn<CR>
imap <C-Left> <esc>:tabp<CR>

set ttimeoutlen=50
let g:airline_theme = 'powerlineish'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

autocmd FileType * set expandtab | set tabstop=4 | set shiftwidth=4 |set softtabstop=4
autocmd FileType cpp set expandtab | set tabstop=2 | set shiftwidth=2 |set softtabstop=2
autocmd FileType hpp set expandtab | set tabstop=2 | set shiftwidth=2 |set softtabstop=2

"autocmd FileType c,h highlight OverLength ctermbg=red ctermfg=white guibg=#592929 match OverLength /\%81v.\+/

filetype on
filetype plugin on
filetype indent on

autocmd bufnewfile *.c so ~/.vim/epitech_header
autocmd bufnewfile *.cpp so ~/.vim/epitech_header
autocmd bufnewfile *.h so ~/.vim/epitech_header
autocmd bufnewfile *.hpp so ~/.vim/epitech_header
autocmd bufnewfile Makefile so ~/.vim/epitech_header_make

autocmd FileType c,cpp :iabbrev main int main(int ac, char **av)<right><CR>{<CR><TAB>return (0)<CR>}<up><up>

set undodir=~/.vim/undodir
set undofile

set laststatus=2

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

autocmd FileType ino map <C-v> :ArduinoVerify<CR>

tnoremap <Esc> <C-\><C-n>:q!<CR>
map <C-t> :terminal<CR>
set splitbelow
nnoremap <expr> <Enter> &ma?"\<CR>":":q!\<CR>"
