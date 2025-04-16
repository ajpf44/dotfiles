local config = require "core.config"
local style = require "core.style"

style.code_font = renderer.font.group {
   renderer.font.load("/home/ajpf/.local/share/fonts/JetBrainsMono-Regular.ttf", 20 * SCALE)
 }
config.indent_size = 4
config.tab_type = "soft"      
