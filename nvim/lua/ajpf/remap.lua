local os = require "os"
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>.", vim.cmd.Ex);

local openterm = function()
  print("this is the funciton");
  os.execute("$TERM &");
end

vim.keymap.set("n", "<leader>t", openterm);
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float);
vim.keymap.set("n", "<leader>[", vim.diagnostic.goto_prev);
vim.keymap.set("n", "<leader>]", vim.diagnostic.goto_next);
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist);
