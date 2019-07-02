nnoremap <buffer> <C-v> :ArduinoVerify<CR>
nnoremap <buffer> <C-u> :ArduinoUpload<CR>
nnoremap <buffer> <C-a> :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <C-m> :ArduinoSerial<CR>
nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_confino.py'
"set filetype=cpp
autocmd VimEnter * :set filetype=cpp
autocmd VimEnter * :set syntax=arduino
ALEDisable
let g:ycm_show_diagnostics_ui = 0
"set cindent
