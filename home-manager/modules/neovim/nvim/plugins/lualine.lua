local custom_theme = {
  normal = {
    a = { fg = "#63d0f0", bg = "#171717" },
    b = { fg = "#00d9df", bg = "#171717" },
    c = { fg = "#bbbbbb", bg = "#171717" },
    x = { fg = "#bbbbbb", bg = "#171717" },
    y = { fg = "#ce6fda", bg = "#171717" },
    z = { fg = "#4c4c4c", bg = "#171717" },
  },
  insert = {
    a = { fg = "#03f622", bg = "#171717" },
    z = { fg = "#4c4c4c", bg = "#171717" },
  },
  visual = {
    a = { fg = "#ce6fda", bg = "#171717" },
    z = { fg = "#4c4c4c", bg = "#171717" },
  },
  terminal = {
    a = { fg = "#ffbd5e", bg = "#171717" },
    z = { fg = "#4c4c4c", bg = "#171717" },
  },
}

require("lualine").setup({
  options = { theme = custom_theme }
})
