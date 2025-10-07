return {
  'chrisbra/csv.vim',
  lazy = false, -- load at startup; fixes "ftplugin before syntax" race
  init = function()
    -- make the active column obvious (use any highlight group you like)
    vim.g.csv_hiGroup = 'Visual'
    -- help the auto-detector (comma, semicolon, pipe, tab)
    vim.g.csv_delim_test = ',;|\t'
    vim.g.csv_bind_B = 1 -- use B (not E) for "previous column"

    local grp = vim.api.nvim_create_augroup('csv_hicol', { clear = true })

    -- Ensure the plugin is (re)initialized, then highlight the column
    vim.api.nvim_create_autocmd('FileType', {
      group = grp,
      pattern = { 'csv', 'tsv' },
      callback = function()
        -- optional: force delimiter if you know it (otherwise auto-detect kicks in)
        -- vim.b.csv_delim = ';' -- uncomment to force semicolon files
        vim.cmd 'silent! CSVInit' -- initialize after ftplugin is ready
        vim.schedule(function()
          vim.cmd 'silent! HiColumn' -- first highlight
        end)
      end,
    })

    -- keep the highlight in sync as the cursor moves (remove if you only want it on enter)
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = grp,
      pattern = { '*.csv', '*.tsv' },
      command = 'silent! HiColumn',
    })
  end,
}
