require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Terminal Window Navigation
map("t", "<C-h>", "<cmd>wincmd h<CR>")
map("t", "<C-j>", "<cmd>wincmd j<CR>")
map("t", "<C-k>", "<cmd>wincmd k<CR>")
map("t", "<C-l>", "<cmd>wincmd l<CR>")

-- Window resizing
map('n', '<C-Up>', '<cmd>resize +2<CR>')
map('n', '<C-Down>', '<cmd>resize -2<CR>')
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>')
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>')

-- Terminal Window Resizing
map("t", "<C-Up>", "<cmd>resize +2<CR>")
map("t", "<C-Down>", "<cmd>resize -2<CR>")
map("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Moving lines up and down
map("n", "<C-A-j>", "<Esc>:m .+1<CR>==gi")
map("n", "<C-A-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<C-A-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-A-k>", ":m '<-2<CR>gv=gv")

-- Buffer navigation
map("n", "<TAB>", ":bn<CR>")
map("n", "<S-TAB>", ":bp<CR>")
map("n", "<leader>bd", ":bd<CR>")

-- Telescope
local builtin = require('telescope.builtin')
map("n", "<leader>ff", builtin.find_files, {})
map("n", "<leader>fa", function() builtin.find_files({ hidden = true, no_ignore = true }) end, {})
-- Remove the file_browser mapping as it's not available by default
-- map("n", "<leader>fe", builtin.file_browser, {})
map("n", "<leader>fw", builtin.live_grep, {})
map("n", "<leader>fb", builtin.buffers, {})
map("n", "<leader>fh", builtin.help_tags, {})
map("n", "<leader>fo", builtin.oldfiles, {})
map("n", "<leader>fc", builtin.colorscheme, {})
map("n", "<leader>fe", ":Telescope file_browser<CR>", {})

-- LSP Shortcuts
map("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>")
map("n", "K", ":lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>")

-- Miscellanous improvements
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Using <leader> + number (1, 2, ... 9) to switch tab
for i=1,9,1
do
  map('n', '<leader>'..i, i.."gt", {})
end
map('n', '<leader>0', ":tablast<cr>", {})

-- map for quick quit, save files using leader key
---- Normal mode
map('n', '<Leader>w', ':write<CR>')
map('n', '<Leader>a', ':wqa<CR>')
map('n', '<Leader>x', ':wq<CR>')

---- Insert mode
map('i', ';w', '<esc>:write<CR>')
map('i', ';x', '<esc>:wq<CR>')


-- Add a command to initialize a Go module
vim.api.nvim_create_user_command('GoModInit', function(opts)
    local module_name = opts.args
    if module_name == '' then
        module_name = vim.fn.input('Module name: ')
    end
    vim.fn.system('go mod init ' .. module_name)
    print('Initialized Go module: ' .. module_name)
end, { nargs = '?' })

-- Add these to your existing mappings
map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch between source/header" })
map("n", "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>", { desc = "Show type hierarchy" })
map("n", "<leader>cs", "<cmd>ClangdSymbolInfo<cr>", { desc = "Show symbol info" })
