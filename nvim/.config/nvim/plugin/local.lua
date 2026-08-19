-- Load machine-local Lua from ~/.config/nvim-local, stowed by the local-*
-- package. Keeps work-specific keymaps out of the shared config: a box with
-- no such directory simply loads nothing.
local dir = vim.fn.stdpath("config"):gsub("/nvim$", "/nvim-local")

if vim.fn.isdirectory(dir) == 0 then
  return
end

for _, file in ipairs(vim.fn.glob(dir .. "/*.lua", false, true)) do
  local ok, err = pcall(dofile, file)
  if not ok then
    vim.notify("nvim-local: " .. file .. ": " .. err, vim.log.levels.WARN)
  end
end
