-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Compile & run the current C++ file in the floating terminal.
-- Mirrors the `cpr` shell function in .zshrc: real GCC so <bits/stdc++.h>
-- resolves, binary in TMPDIR rather than ./a.out, and input.txt is piped in
-- only when it actually exists so a fresh problem dir still runs.
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("write")

  local src = vim.fn.expand("%:p")
  local dir = vim.fn.expand("%:p:h")
  -- Same path `cpr` uses, so the two share one binary and one cleanup story.
  -- TMPDIR is the per-user dir dirhelper reaps; nvim's cache dir is never
  -- swept, so a binary left there would live forever.
  local bin = (os.getenv("TMPDIR") or "/tmp"):gsub("/$", "") .. "/cpr-" .. vim.fn.expand("%:t:r")

  local cxx = vim.fn.executable("g++-16") == 1 and "g++-16" or "g++"

  local run = vim.fn.shellescape(bin)
  local input = dir .. "/input.txt"
  if vim.fn.filereadable(input) == 1 then
    run = run .. " < " .. vim.fn.shellescape(input)
  end

  -- Leading clear: the float hosts one long-lived shell, so without it every
  -- run stacks onto the last one's output and you scroll to find the top.
  local cmd = string.format(
    "clear; cd %s && %s -std=c++23 -O2 -g -Wall -Wextra "
      .. "-fsanitize=address,undefined -D_GLIBCXX_DEBUG %s -o %s "
      .. "&& rm -rf %s.dSYM && %s",
    vim.fn.shellescape(dir),
    cxx,
    vim.fn.shellescape(src),
    vim.fn.shellescape(bin),
    vim.fn.shellescape(bin),
    run
  )

  -- Unlike :terminal, a user command does no cmdline expansion, so % and #
  -- inside a path reach the shell untouched and need no escaping here.
  vim.cmd.FloatermRun(cmd)
end, { desc = "Compile & Run C++" })
