syntax on
set number
set wrap
set ruler
set incsearch
set showcmd
set showmatch
set clipboard=unnamed
set mouse=a
set tabstop=4
set shiftwidth=4
set encoding=UTF-8



" mapping some short cut
" quit
map <C-q> :q!<cr>
imap <C-q> <ESC>:q!<cr>

" save
map <C-s> :w<cr>
imap <C-s> <ESC>:w<cr>

" undo
map <C-z> u
imap <C-z> <ESC>ua

" copy hole file
map <C-c> :w<cr>ggVGy
imap <C-c> <ESC> ggVGy

" past
map <C-p> p
imap <C-p> <ESC> pa

" save and quit
map <C-x> :wq<cr>
imap <C-x> <ESC> :wq<cr>

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')


" import plug-in

" powerline
Plug 'vim-airline/vim-airline', { 'as': 'airline' }
Plug 'vim-airline/vim-airline-themes', { 'as': 'airline-themes' }

" set status line
set laststatus=2

" enable powerline-fonts
let g:airline_powerline_fonts = 1

" theme
Plug 'dracula/vim', { 'as': 'dracula-theme' }
Plug 'frazrepo/vim-rainbow', { 'as': 'rainbow' }

" (Optiona) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim', { 'as': 'vim-fzf' }

filetype on
Plug 'vim-scripts/taglist.vim', { 'as': 'taglist' }

" file explore
let g:python3_host_prog = '/usr/local/bin/python3.9'
Plug 'Shougo/defx.nvim', { 'as': 'defx' }
noremap <silent><C-f> <cmd>Defx -buffer-name="defx"<cr>

" auto completion & lsp
Plug 'neovim/nvim-lspconfig', { 'as': 'lsp-config' }
Plug 'nvim-lua/completion-nvim', { 'as': 'lua-auto-completion' }
Plug 'nvim-lua/lsp-status.nvim', { 'as': 'lsp-status' }

let g:completion_chain_complete_list = [{'complete_items': ['lsp']},]
let g:completion_enable_auto_hover = 1
let g:completion_enable_auto_popup = 1

" golang 
Plug 'fatih/vim-go',{ 'for':'go', 'do': ':GoUpdateBinaries' }
let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_enabled = ['vet', 'errcheck', 'staticcheck', 'gosimple']

" fzf vim support

" gitgutter
Plug 'airblade/vim-gitgutter', { 'as': 'gitgutter' }

" git-vim
Plug 'motemen/git-vim'

" tagbar
Plug 'preservim/tagbar'
map <C-t> :TagbarToggle<cr>
imap <C-t> <Esc>:TagbarToggle<cr>a

" vim-dispatch
Plug 'tpope/vim-dispatch', { 'as': 'dispatch' }

" Goyo
Plug 'junegunn/goyo.vim', { 'as': 'goyo' }
map <C-g> :Goyo<cr>
imap <C-g> <Esc>:Goyo<cr>a


call plug#end()

" vim rainbow configs
let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']


" lsp config
lua << EOF
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			-- Enable underline, use default values
			underline = true,
			-- Enable virtual text, override spacing to 2
        	virtual_text = {
          		spacing = 4,
          		prefix = '<-',
        	},
        	-- Use a function to dynamically turn signs off
        	-- and on, using buffer local variables
        	signs = function(bufnr, client_id)
          	local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
          	-- No buffer local variable set, so just enable by default
          	if not ok then
            	return true
          	end

          	return result
        end,
        -- Disable a feature
        update_in_insert = false,
      }
    )

    local on_attach_vim = function(client)
        require'completion'.on_attach()
    end


    local lspconfig = require'lspconfig'
    lspconfig.gopls.setup{
        on_attach=on_attach_vim
    }
    lspconfig.clangd.setup{
        cmd = {"/usr/local/opt/llvm/bin/clangd", "--background-index"},
        on_attach=on_attach_vim
    }
EOF


" lsp menu setting
set completeopt=menuone,noinsert,noselect


" start at last time
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


" defx config
call defx#custom#column('icon', {
            \ 'directory_icon': '▸',
            \ 'opened_icon': '▾',
            \ 'root_icon': '📁 ',
            \ })

call defx#custom#column('filename', {
            \ 'min_width': 128,
            \ 'max_width': 128,
            \ })

call defx#custom#option('_', {
            \ 'columns': 'mark:indent:icon:filename:type',
            \ 'split': 'vertical',
            \ 'winwidth': 35,
            \ 'direction': 'topleft',
            \ 'resume': v:false,
            \ 'toggle': v:true
            \ })

autocmd FileType defx call s:defx_mappings()

function! s:defx_mappings() abort
  nnoremap <silent><buffer><expr>  <cr>    <SID>defx_toggle_tree()
endfunction

function! s:defx_toggle_tree() abort
    " Open current file, or toggle directory expand/collapse
    if defx#is_directory()
        return defx#do_action('open_or_close_tree')
    endif
    return defx#do_action('multi', ['drop'])
endfunction


" fzf configs
" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
set rtp+=/usr/local/opt/fzf
