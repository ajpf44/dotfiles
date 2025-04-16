local command = require "core.command"

local function launch_terminal()
	return os.execute("gnome-terminal")
end

local template = "#include <stdio.h>\n\nint main(int argc, char** argv){\n\n  return 0;\n}"
local function c_default_template(dv)
  command.perform "doc:select-all"
  command.perform "doc:delete"
  dv.doc:insert(0,0, template)
end

command.add(nil, {["core:open-terminal"] = launch_terminal})
command.add("core.docview", {["core:c-default-template"] = c_default_template})




