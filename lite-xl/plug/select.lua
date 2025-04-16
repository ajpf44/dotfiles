local core = require "core"
local command = require "core.command"
local keymap = require "core.keymap"

local function get_av()
	local view = core.active_view
    local doc = (view and view.doc) and view.doc or nil
    if doc then
        return doc
    end
end

local function select(lin, col, exp_start, exp_final)
    local av = get_av()
	local final =0;
    local start = col;
    local found_start = false;
    local found_end = false;
    while(av:get_char(lin, col+final) ~= exp_final and av:get_char(lin, col+final) ~= '"' ) do
        final = final + 1
        if av:get_char(lin, col+final) == exp_final then
            found_end = true
        end
    end
    while( start ~= 0 and av:get_char(lin, start) ~= exp_start ) do
        start = start - 1
        if av:get_char(lin, start) == exp_start then
            found_start = true
        end
    end
    if found_end and found_start then
        core.log('found at ' .. 'line: ' .. lin .. ', col: ' .. col .. ', start: ' .. start .. ', final col: ' .. final+col )
        av:set_selection(lin, start+1, lin, col+final, true)
    else
        core.log('not found' .. 'line: ' .. lin .. ', col: ' .. col .. ', start: ' .. start .. ', final col: ' .. final+col )
    end
end



local function select_double_cotes()
    local av = get_av()
    local lin,col = av:get_selection(true, true)
    select(lin, col, '"', '"')
end

local function select_double_parentesis()
    local av = get_av()
    local lin,col = av:get_selection(true, true)
    select(lin, col, '(',')' )
end

local function select_double_chav()
    local av = get_av()
    local lin,col = av:get_selection(true, true)
    select(lin, col, '{', '}')
end

local function select_double_aa()
    local av = get_av()
    local lin,col = av:get_selection(true, true)
    select(lin, col, '[', ']')
end

command.add(nil, {["select: between quotes"] = select_double_cotes})
command.add(nil, {["select: between ()"] = select_double_parentesis})
command.add(nil, {["select: between {}"] = select_double_chav})
command.add(nil, {["select: between []"] = select_double_aa})

keymap.add{ ["ctrl+shift+i" ] = "select: between quotes" }
keymap.add{ ["ctrl+shift+9" ] = "select: between ()" }
keymap.add{ ["ctrl+shift+0" ] = "select: between ()" }
keymap.add{ ["ctrl+shift+[" ] = "select: between {}" }
keymap.add{ ["ctrl+shift+]" ] = "select: between {}" }
-- keymap.add{ ["ctrl+shift+[" ] = "select: between []" }
-- keymap.add{ ["ctrl+shift+]" ] = "select: between []" }
