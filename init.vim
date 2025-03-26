"Kelly's init.vim file

"presets I like
set number
set hlsearch



"Vim Plug
call plug#begin()

" List your plugins here
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'hashivim/vim-terraform'
Plug 'preservim/nerdtree'
Plug 'github/copilot.vim'
call plug#end()

"Set vim-airline theme
let g:airline_theme='base16_gruvbox_dark_hard'


colorscheme gruvbox

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

"NERDTree keybindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
