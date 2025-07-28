local M = {}

function M.get_venv_python()
  -- If there's a venv explicitly activated, use that
  local venv_path = os.getenv 'VIRTUAL_ENV'
  if venv_path then
    local python_path = venv_path .. '/bin/python'
    if vim.fn.filereadable(python_path) == 1 then
      return python_path
    end
  end

  -- Otherwise, walk up to the filesystem root looking for a `.venv` folder
  local venv_found = vim.fs.find('.venv', {
    path = vim.fn.expand '%:p:h',
    upward = true,
    type = 'directory',
    limit = 1,
  })[1]
  if venv_found then
    local python_path = venv_found .. '/bin/python'
    if vim.fn.filereadable(python_path) == 1 then
      return python_path
    end
  end

  -- Fallback to the system python
  return vim.fn.executable 'python3' and 'python3'
end

return M
