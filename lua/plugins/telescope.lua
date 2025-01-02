return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()

        local builtin = require("telescope.builtin");

        -- telescope keycombinations
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>pg', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)
    end
}
