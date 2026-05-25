-- ===============
-- = BASIC SETUP =
-- ===============
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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

-- ============
-- = KEYBINDS =
-- ============
-- Move line up
vim.keymap.set('n', '<C-k>', 'ddkP', { desc = 'Move line up' })

-- Move line down
vim.keymap.set('n', '<C-j>', 'ddp', { desc = 'Move line down' })

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

--  =======
--  = LSP =
--  =======
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('pyright')
            vim.lsp.enable('ccls')
    	end
    }
})

