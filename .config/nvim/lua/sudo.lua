local M = {}

vim.api.nvim_create_user_command("SudoWrite", function(opts)
  local filepath = opts.args
  if filepath == "" then
    M.err("No file path given. Usage: :SudoWrite <path>")
    return
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n") .. "\n"

  local ok, res = pcall(function()
    vim.fn.inputsave()
    local password = vim.fn.inputsecret("Password: ")
    vim.fn.inputrestore()
    print("\r\n")
    if not password or #password == 0 then
      M.warn("Invalid password, sudo aborted")
      return false
    end
    return vim.system(
      { "sh", "-c", string.format("echo '%s' | sudo -p '' -S tee %s > /dev/null", password, filepath) },
      { stdin = content }
    ):wait()
  end)

  if not ok or not res then
    M.err(tostring(res))
    return
  end

  if res.code ~= 0 then
    M.err(res.stderr)
    return
  end

  vim.bo.modified = false
  print("File saved with sudo: " .. filepath)

end, {
  nargs = 1,
  complete = "file",
})

vim.api.nvim_create_user_command("SudoExec", function(opts)
  local cmd = opts.args
  if cmd == "" then
    M.err("No command given. Usage: :SudoExec <command>")
    return
  end
  require("utils").sudo_exec(cmd, true)
end, {
  nargs = 1,
  complete = "shellcmd",
})

return M
