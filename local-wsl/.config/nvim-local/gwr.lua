-- WSL box only, loaded from ~/.config/nvim-local by plugin/local.lua.
vim.keymap.set("n", "<space>gwr", function()
  vim.cmd("FloatermRun cd src/rendering && npm run start:connected_onpremise_ssl")
end, { desc = "Start GWR brochure site" })
