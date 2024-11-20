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
        org_highlight_latex_and_related = 'native',
        org_hide_emphasis_markers = true,
        org_todo_keywords = { 'TODO', 'WAITING', 'NEXT', '|', 'DONE', 'DELEGATED' },
        org_todo_keyword_faces = {
          WAITING = ':foreground orange :weight bold',
          DELEGATED = ':foreground teal :slant italic',
          TODO = ':weight bold :foreground red',
          NEXT = ':weight bold :foreground cyan :slant italic',
          DONE = ':weight bold :foreground green',
        },
        notifications = {
          enabled = false,
          cron_enabled = true,
          repeater_reminder_time = false,
          deadline_warning_reminder_time = false,
          reminder_time = 10,
          deadline_reminder = true,
          scheduled_reminder = true,
          notifier = function(tasks)
            local result = {}
            for _, task in ipairs(tasks) do
              require('orgmode.utils').concat(result, {
                string.format('# %s (%s)', task.category, task.humanized_duration),
                string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
                string.format('%s: <%s>', task.type, task.time:to_string()),
              })
            end

            if not vim.tbl_isempty(result) then
              require('orgmode.notifications.notification_popup'):new { content = result }
            end
          end,
          cron_notifier = function(tasks)
            for _, task in ipairs(tasks) do
              local title = string.format('%s (%s)', task.category, task.humanized_duration)
              local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
              local date = string.format('%s: %s', task.type, task.time:to_string())

              -- Linux
              if vim.fn.executable 'notify-send' == 1 then
                vim.loop.spawn('notify-send', { args = { string.format('%s\n%s\n%s', title, subtitle, date) } })
              end

              -- MacOS
              if vim.fn.executable 'terminal-notifier' == 1 then
                vim.loop.spawn('terminal-notifier', { args = { '-title', title, '-subtitle', subtitle, '-message', date } })
              end
            end
          end,
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
  { 'tpope/vim-repeat' },
}
