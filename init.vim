set mouse=a  " enable mouse
set encoding=utf-8
set number
set cursorline
set noswapfile
set scrolloff=7

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
filetype indent on      " load filetype-specific indent files

" for tabulation
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2

" horizontal split open below and right
set splitbelow
set splitright
set colorcolumn=88


call plug#begin('~/.vim/plugged')

" Установка nvim-cmp и его источников
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'tribela/vim-transparent'

" Установка nvim-lspconfig
Plug 'neovim/nvim-lspconfig'

" Установка pyright
Plug 'microsoft/pyright'

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'

call plug#end()

lua <<EOF
-- Настройка nvim-cmp

require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp_signature_help' },  -- Добавление подсказок по сигнатурам функций
  },
  mapping = {
    ['<C-Space>'] = require'cmp'.mapping.complete(),
    ['<C-e>'] = require'cmp'.mapping.close(),
    ['<CR>'] = require'cmp'.mapping.confirm({ select = true }),
    ['<Tab>'] = require'cmp'.mapping(function(fallback)
      if require'cmp'.visible() then
        require'cmp'.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = require'cmp'.mapping(function(fallback)
      if require'cmp'.visible() then
        require'cmp'.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
}

-- Настройка nvim-lspconfig для pyright
require'lspconfig'.pyright.setup{}

EOF

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap ,<space> :nohlsearch<CR>

source ~/.config/nvim/color_schema.vim
colorscheme color_schema


function! CenterText(text)
    let width = winwidth(0)
    let padding = (width - strwidth(a:text)) / 2
    return repeat(' ', padding) . a:text
endfunction

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git"'
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>

let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']               },
      \ { 'type': 'commands',  'header': ['   Commands']                },
      \ ]

let g:startify_bookmarks = [
      \ { 'c': '~/.config/nvim/init.vim' },
      \ { 'z': '~/.zshrc' },
      \ ]

let g:startify_change_to_vcs_root = 1

let g:startify_session_persistence = 1

let g:startify_enable_special = 0

let g:startify_custom_header = [
      \ '   Wake up, Neo...                              ',
      \ '   The Matrix has you...                        ',
      \ '   Follow the white rabbit.                     ',
      \ '   ──────────────────────────────────────────── ',
      \ '   > Neovim loaded.                             ',
      \ '   > Ready to hack.                             ',
      \ '   ╭───────────────────────────────────────────╮',
      \ '   │        ███╗   ██╗███████╗ ██████╗         │',
      \ '   │        ████╗  ██║██╔════╝██╔═══██╗        │',
      \ '   │        ██╔██╗ ██║█████╗  ██║   ██║        │',
      \ '   │        ██║╚██╗██║██╔══╝  ██║   ██║        │',
      \ '   │        ██║ ╚████║███████╗╚██████╔╝        │',
      \ '   │        ╚═╝  ╚═══╝╚══════╝ ╚═════╝         │',
      \ '   ╰───────────────────────────────────────────╯',
      \ ]
