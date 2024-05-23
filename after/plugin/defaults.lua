local swift_format = function()
  local files = vim.api.nvim_get_runtime_file('Sources/*.swift', true)
  local fileName = ''
  for _, val in ipairs(files) do
    fileName = val .. ' ' .. fileName
  end
  print(vim.inspect(fileName))
  vim.fn.jobstart({ 'swift-format', '-i', fileName }, { stdout_buffered = false })
end

local api = vim.api

local attach_to_buffer = function(output_bufnr, pattern, command)
  api.nvim_create_autocmd('BufWritePost', {
    group = api.nvim_create_augroup('PlaygroundExperiments', { clear = true }),
    -- pattern = "*.swift",
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then
          api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
        end
      end

      api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { 'output of: ' .. pattern })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

-- vim.api.nvim_create_user_autocmd("Autorun", function()
-- print("Autorun starts now...")
--[[ local bufnr = vim.fn.input "Bufnr: "
     local pattern = vim.fn.input "Pattern: "
     local command = vim.split(vim.fn.input " command: ", " ")
     attach_to_buffer(tonumber(bufnr), pattern, command) ]]
-- end,{})

vim.api.nvim_create_user_command('Autorun', function()
  local bufnr = vim.fn.input 'Bufnr: '
  local pattern = vim.fn.input 'Pattern: '
  local command = vim.split(vim.fn.input ' command: ', ' ')
  attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})

vim.api.nvim_create_user_command('Swiftrun', function()
  local bufnr = vim.fn.input 'Bufnr: '
  attach_to_buffer(tonumber(bufnr), '*.swift', { 'swift', 'run' })
end, {})

vim.api.nvim_create_user_command('Swiftbuild', function()
  local bufnr = vim.fn.input 'Bufnr: '
  attach_to_buffer(tonumber(bufnr), '*.swift', { 'swift', 'build' })
end, {})
--[[  vim.api.nvim_create_user_command("CppRun", function ()
  local bufnr = vim.fn.input "Bufnr: "
  attach_to_buffer(tonumber(bufnr), "*.cpp", {"cmake", "CMakeLists.txt", "&&", "make", "&&", "output"})
 end, {})
 ]]

vim.api.nvim_create_user_command('GoRun', function()
  local bufnr = vim.fn.input 'Bufnr: '
  attach_to_buffer(tonumber(bufnr), '*.go', { 'go', 'run', '.' })
end, {})

vim.api.nvim_create_user_command('CargoRun', function()
  local bufnr = vim.fn.input 'Bufnr: '
  attach_to_buffer(tonumber(bufnr), '*.rs', { 'cargo', 'run' })
end, {})

vim.api.nvim_create_user_command('CargoTest', function()
  local bufnr = vim.fn.input 'Bufnr: '
  attach_to_buffer(tonumber(bufnr), '*.rs', { 'cargo', 'test' })
end, {})

vim.api.nvim_create_user_command('SwiftTest', function()
  local bufnr = vim.fn.input 'Bufnr: '
  attach_to_buffer(tonumber(bufnr), '*.swift', { 'swift', 'test' })
end, {})

--[[  vim.api.nvim_create_user_command("CProgram", function ()
  local bufnr = vim.fn.input "Bufnr: "
  attach_to_buffer(tonumber(bufnr), "main.c", {"gcc", "-g", "-o", "c_output", "main.c" })
  attach_to_buffer(tonumber(bufnr), "main.c", {"./c_output" })
 end, {})
 ]]
vim.api.nvim_create_user_command('SwiftFormat', function()
  swift_format()
end, {})
