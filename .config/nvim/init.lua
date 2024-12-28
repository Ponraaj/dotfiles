-- bootstrap lazy.nvim, LazyVim and your plugins
require("core.lazy")
require("snippets.cpp.init")

vim.api.nvim_create_user_command("RunCpp", function()
  local file = vim.fn.expand("%:p") -- Full path of the current file
  local exec = "temp_executable" -- Temporary executable name

  -- Check if recompilation is needed
  local file_modified = vim.fn.getftime(file)
  local exec_modified = vim.fn.getftime(exec)

  if exec_modified == -1 or file_modified > exec_modified then
    print("Compiling...")
    local compile_command = string.format("g++ -O2 %s -o %s", file, exec)
    local compile_result = vim.fn.system(compile_command)
    if vim.v.shell_error ~= 0 then
      print("Compilation failed:\n" .. compile_result)
      return
    end
    print("Compilation successful.")
  else
    print("Executable is up-to-date. Skipping compilation.")
  end

  -- Run the executable with input/output redirection
  print("Running the program...")
  local run_command = string.format("./%s < input.txt > output.txt", exec)
  local run_result = vim.fn.system(run_command)
  if vim.v.shell_error ~= 0 then
    print("Execution failed:\n" .. run_result)
    return
  end

  vim.cmd("checktime")
  print("Execution successful. Output written to output.txt.")
end, {})
