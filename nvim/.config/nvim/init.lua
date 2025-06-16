require("config.lazy")

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.wo.number = true

-- format on :F
vim.api.nvim_create_user_command("F", function()
  vim.lsp.buf.format({ async = false })
end, { desc = "Format current buffer" })

-- format and save on :Fw
vim.api.nvim_create_user_command("Fw", function()
  -- Format the buffer
  vim.lsp.buf.format({ async = false })
  -- Then save
  vim.cmd("write")
end, { desc = "Format and save current buffer" })
