-- ===============
-- = BASIC SETUP =
-- ===============
do
    -- Leader key
    vim.g.mapleader = " "

    vim.g.have_nerd_font = false

    -- Basic options
    vim.opt.number = true
    vim.opt.relativenumber = true

    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true

    vim.opt.wrap = false

    vim.opt.winborder = "rounded"

    -- Use the system clipboard
    vim.opt.clipboard = "unnamedplus"
end

-- ============
-- = KEYBINDS =
-- ============
-- :help vim.keymap
do
    vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Update and source the config' })

    -- Move line up and down
    vim.keymap.set('n', '<C-k>', 'ddkP', { desc = 'Move line up' })
    vim.keymap.set('n', '<C-j>', 'ddp', { desc = 'Move line down' })

    -- Clear hightlights on search when pressing <Esc> in normal mode
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear hightlight on search' })
end

-- =================
-- = AUTO-COMMANDS =
-- =================
-- :help lua-guide-autocommands
do
    -- Highlight when copying text
    vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when copying text',
        group = vim.api.nvim_create_augroup('hightlight-yank', { clear = true }),
        callback = function()
            vim.hl.on_yank() -- :help vim.highlight
        end
    })
end

-- ===========
-- = PLUGINS =
-- ===========
do
    vim.pack.add({
        { src = "https://github.com/vague2k/vague.nvim" },
        { src = "https://github.com/windwp/nvim-autopairs" },
        { src = "https://github.com/stevearc/oil.nvim" },
        { src = "https://github.com/echasnovski/mini.pick" },
        { src = "https://github.com/neovim/nvim-lspconfig" }
    })

    require "nvim-autopairs".setup()
    require "oil".setup()
    require "mini.pick".setup()

    -- === mini.pick keybinds ===
    vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
    vim.keymap.set('n', '<leader>h', ":Pick help<CR>")

    -- === Oil keybinds ===
    vim.keymap.set('n', '<leader>e', ":Oil<CR>")

    -- === lsp configuration ===
    vim.lsp.enable({ "lua_ls", "clangd" })

    -- :help lsp-defaults
    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Formats the buffer based on the language' })

    -- === colorscheme configuration ===
    vim.cmd.colorscheme("vague") -- Set the theme
    vim.cmd(":hi statusline guibg=NONE")

    -- Transparent background
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
