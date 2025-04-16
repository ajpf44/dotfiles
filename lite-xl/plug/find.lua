local command = require "core.command"
local core = require "core"
local keymap = require "core.keymap"
local style = require "core.style"
local View = require "core.view"
local common = require "core.common"

local function get_selected_text()
	local view = core.active_view
	local doc = (view and view.doc) and view.doc or nil
	if doc then
		return doc:get_text(table.unpack({ doc:get_selection() }))
	end
end

local function rg(word)
	local handle = io.popen("rg -n " .. word)
	local result = handle:read("*a")
	handle:close()
	return result
end

local function format_rg(word)
	local matches = {}
	local ind = 0
	for match in string.gmatch(rg(word), '([^' .. "\n" .. ']+)') do
		table.insert(matches, match)
		ind = ind + 1
	end
	return { list = matches, size = ind }
end

---@class  HelloView : core.object
---@field  size table
---@field  draw_background function
---@field  get_content_offset function
---@field  draw_scrollbar function
local HelloView = View:extend()

function HelloView:new(word)
	HelloView.super.new(self)
	self.context = "session"
	self.caption = "Hello world!"
	self.content = format_rg(word)
end

function HelloView:get_name()
	return "Find Results"
end

function HelloView:get_scrollable_size()
	return 2 * self.size.y
end

function HelloView:get_h_scrollable_size()
	return 2 * self.size.x
end

function HelloView:draw()
	self:draw_background(style.background)
	local top_pad = 20
	local spacing = 40
	local x, y = self:get_content_offset()
	local w, h = self.size.x + 300, top_pad
	common.draw_text(style.font, style.text, self.caption, 'left', x, y, w, h)

	local lw = self.size.x - style.padding.x * 2
	local lh = style.divider_size
	renderer.draw_rect(10, h + 34, lw, lh, style.dim)

	for ind = 1, self.content.size, 1 do
		common.draw_text(
			style.font, style.text,
			self.content.list[ind], 'left',
			x, y, w, h + ind * spacing
		)
	end
	self:draw_scrollbar()
end

local find_plug = function()
	core.command_view:enter("Grep:  ", {
		text = get_selected_text(),
		select_text = true,
		submit = function(word)
			core.root_view:get_active_node():add_view(HelloView(word))
		end
	})
end

command.add(nil, { ["find-plug: test"] = find_plug })
keymap.add { ["ctrl+."] = "find-plug: test" }

