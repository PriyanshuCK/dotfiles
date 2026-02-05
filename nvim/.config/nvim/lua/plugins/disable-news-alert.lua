-- Disable the news alert that shows on startup
return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = false },
    },
  },
}
