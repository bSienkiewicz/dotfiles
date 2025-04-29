return {
  "RedsXDD/neopywal.nvim",
  name = "neopywal",
  lazy = false,
  priority = 1000,
  opts = {
    transparent_background = true, -- Enable transparency
  },
  config = function(_, opts)
    require("neopywal").setup(opts)
    vim.cmd.colorscheme("neopywal") -- Set the colorscheme
  end,
}
