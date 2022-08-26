syntax on
set number
set noswapfile
set hlsearch
set ignorecase
set incsearch
set splitbelow
set encoding=UTF-8
set fileencoding=utf-8

filetype plugin indent on

" https://github.com/vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1

set autowrite
set mouse=a

" Brackets Highlighting Colors
"hi MatchParen cterm=none ctermbg=black ctermfg=white

" Errors/BadSpellings Higlighing Colors
:highlight clear SpellBad

" PopUp (auto complete popup color)
":highlight Pmenu ctermbg=gray guibg=gray
":highlight PmenuSel ctermbg=green

" CUSOR SETUP
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" TAB SETUPS
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces


" VIM-GO CONFIGS
" Syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" Enable auto formatting on saving
let g:go_fmt_autosave = 1
" Run `goimports` on your current file on every save
let g:go_fmt_command = "goimports" 
" Status line types/signatures (auto show GoInfo)
let g:go_auto_type_info = 1

" Enable lsp for go by using gopls
let g:completor_filetype_map = {}
let g:completor_filetype_map.go = {'ft': 'lsp', 'cmd': 'gopls -remote=auto'}"

"" Go Add Tags
let g:go_addtags_transform = 'camelcase'
noremap gat :GoAddTags<cr>

" NERDTREE CONFIGS
map <C-z> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

" PLUGINS
call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-scripts/AutoComplPop'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'AndrewRadev/splitjoin.vim'
call plug#end()

if (has("termguicolors"))
  set termguicolors
endif

"colorscheme mirodark
"colorscheme cyberspace
"colorscheme onedark
colorscheme jellybeans


" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)


" Auto closing pairs
:so ~/.dotfiles/vim/autopair.vim

" NERDTREE
" Start NERDTree when Vim is opened and leave the cursor in it.
"autocmd VimEnter * NERDTree

" Start NERDTree when Vim is opened and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p


" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif


" Open vimagit pane
nnoremap <leader>gs :Magit<CR>       " git status


" True color
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Use <cr> to confirm completion
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
