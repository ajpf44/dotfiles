local core = require "core"
local keymap = require "core.keymap"
local config = require "core.config"
local style = require "core.style"
local lspconfig = require "plugins.lsp.config"
local command = require "core.command"

-- Custom commands
keymap.add{ ["ctrl+t" ] = "core:open-terminal" }
-- launch terminal
local function launch_terminal()
	return os.execute("gnome-terminal")
end
command.add(nil, {["core:open-terminal"] = launch_terminal})

local template = "#include <stdio.h>\n\nint main(int argc, char** argv){\n\n  return 0;\n}"

local function c_default_template(dv)
  command.perform "doc:select-all"
  command.perform "doc:delete"
  dv.doc:insert(0,0, template)
end

command.add("core.docview", {["core:c-default-template"] = c_default_template})

lspconfig.jsonls.setup()
lspconfig.clangd.setup()


style.code_font = renderer.font.group {
   renderer.font.load("/home/ajpf/.local/share/fonts/JetBrainsMono-Regular.ttf", 20 * SCALE)
 }

config.indent_size = 2 
config.tab_type = "soft"      


