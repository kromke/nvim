-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup {
        org_agenda_files = '~/Yandex.Disk/orgfiles/**/*',
        org_default_notes_file = '~/Yandex.Disk/orgfiles/refile.org',
        org_capture_templates = {
          T = {
            description = 'Todo',
            template = '** TODO %?\n   SCHEDULED: %^t',
            target = '~/Yandex.Disk/orgfiles/todo.org',
            headline = 'TASKS',
          },
          I = {
            description = 'Info',
            template = '* %?\n %x',
            target = '~/Yandex.Disc/orgfiles/info.org',
          },
        },
        org_hide_leading_stars = true,
        org_highlight_latex_and_related = 'native',
        org_hide_emphasis_markers = true,
        org_todo_keywords = { 'TODO(t)', 'WAITING(w)', '|', 'DONE(d)' },
        mappings = {
          org = {
            org_toggle_checkbox = '<CR>',
            org_todo = '<C-Space>',
          },
        },
      }

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  {
    'jpalardy/vim-slime',
    config = function()
      vim.g.slime_target = 'tmux'
    end,
  },
  { 'jubnzv/mdeval.nvim' },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  { 'curkan/doom-one.nvim' },
  { 'mfussenegger/nvim-dap' },
}
