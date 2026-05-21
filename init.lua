-- ===============
-- = BASIC SETUP =
-- ===============
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

-- Change the runtimepath for executing the plugins
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

-- Use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- =================
-- = AUTO-COMMANDS =
-- =================
-- Highlight when copying text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when copying text',
    group = vim.api.nvim_create_augroup('hightlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- ===========
-- = PLUGINS =
-- ===========
require("lazy").setup({ 

    -- Add a theme (Dracula)
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

    -- Add LuaSnip (For snippets)
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            -- Load snippets from VsCode
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
})

