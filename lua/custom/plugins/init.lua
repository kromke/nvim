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
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
        org_capture_templates = {
          T = {
            description = 'Todo',
            template = '** TODO %?\n   SCHEDULED: %^t',
            target = '~/orgfiles/todo.org',
            headline = 'TASKS',
          },
          I = {
            description = 'Info',
            template = '* %?\n %x',
            target = '~/orgfiles/info.org',
          },
        },
        org_hide_leading_stars = true,
        org_agenda_skip_scheduled_if_done = true,
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
}
