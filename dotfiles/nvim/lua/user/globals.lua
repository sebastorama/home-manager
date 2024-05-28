P = function(inspectable)
  print(vim.inspect(inspectable))
end

PB = function(inspectable)
  local buffer = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(buffer, 0, 0, true, vim.split(string.rep(vim.inspect(inspectable), 1), '\n'))
  vim.cmd [[vsplit]]
  vim.api.nvim_win_set_buf(0, buffer)
end

function MAP(tbl, f)
  local t = {}
  for k, v in pairs(tbl) do
    t[k] = f(v)
  end
  return t
end

function HAS_VALUE(tab, val)
  for _index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

function shell_cmd_to_buf(cmd, bufno)
  vim.api.nvim_buf_set_lines(bufno, 0, -1, false, {})

  local write_data = function(_, data)
    if data then
      vim.api.nvim_buf_set_lines(bufno, -1, -1, false, data)
      vim.api.nvim_buf_call(bufno, function()
        vim.cmd '$'
      end)
    end
  end

  local tail_buffer = function()
    vim.api.nvim_buf_call(bufno, function()
      vim.cmd '$'
    end)
  end

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = write_data,
    on_stderr = write_data,
    on_exit = tail_buffer,
  })
end
