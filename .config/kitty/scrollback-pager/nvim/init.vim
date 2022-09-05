packadd hop.nvim

set mouse=a
set clipboard=unnamedplus
set virtualedit=all
set number
set relativenumber

nnoremap ; :
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

autocmd VimEnter * :100

lua << EOF
-- space as the leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require'hop'.setup()
vim.api.nvim_set_keymap("n", "<leader>ow", "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>or", "<cmd>lua require'hop'.hint_lines()<cr>", {})
EOF
