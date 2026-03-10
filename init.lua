-- Plugin Manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Install if needed
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = " "

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4 -- TODO: Modify this to be dependent on the filetype (.py, .lua, .c, etc)
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"

-- Plugins
require("lazy").setup({ 

    -- Add a theme (Dracula) TODO: Integrate with my system colors
    {
        "Mofiqul/dracula.nvim", -- Github repo for the theme
        config = function()
            vim.cmd.colorscheme("dracula") -- Set the theme

            -- Transparent background 
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    },

    -- Add autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end
    },

    -- Add LuaSnip (For making snippets)
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()

            require("luasnip.loaders.from_vscode").lazy_load({
                paths = { vim.fn.stdpath("config") .. "/snippets" }
            })
        end
    },

    -- Add pywal (for dynamic colorschemes)
    {
        "AlphaTechnolog/pywal.nvim",
        name = "pywal",
        config = function()
            require("pywal").setup()

--            vim.cmd.colorscheme("pywal")
        end
    }
})


-- Keymap for expanding the snippets
local ls = require("luasnip")

vim.keymap.set({"i", "s"}, "<Tab>", function() -- TODO: May need to correct some bugs
if ls.expand_or_jumpable() then
    ls.expand_or_jump()
else
    return "<Tab>"
end
end)


