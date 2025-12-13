vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.cmd("set cursorline")
vim.opt.showmode = false
vim.opt.relativenumber = true
vim.opt.number = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Enable inlay hints globally after LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function()
        vim.lsp.inlay_hint.enable(true)
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = 'Remove whitespace on write',
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})


vim.o.winborder = 'single'
vim.opt.colorcolumn = "120"
