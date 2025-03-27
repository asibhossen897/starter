require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4
o.smartindent = true
o.number = true
o.relativenumber = true

-- Disable swap file
o.swapfile = false
o.backup = false
o.writebackup = false
