local utils = {}

vim.cmd("noremap -eu :e ~/.config/nvim/lua/utils/init.lua<CR>")

function utils.set_global_option(key,value)
    vim.o[key] = value
end
