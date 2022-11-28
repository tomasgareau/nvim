local M = {}

M.get_python_path = function(dir)
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. "/bin/python"
  elseif vim.env.CONDA_PREFIX then
    return vim.env.CONDA_PREFIX .. "/bin/python"
  else
    local venv_ok, venv = pcall(vim.fn.system, "cd " .. dir .. " && poetry env info -p 2>/dev/null")
    if venv_ok then
      return vim.fn.trim(venv) .. "/bin/python"
    end
  end

  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

M.set_colorscheme = function(colorscheme)
  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
  end
end

return M
