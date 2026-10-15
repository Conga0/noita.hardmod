-- Overengineered logo splash thingy

local rotatable_text = dofile_once("mods/noita.hardmod/files/modules/logo_splash/rotatable_text.lua") ---@type rotatable_text
local menu_tracker = dofile_once("mods/noita.hardmod/files/modules/logo_splash/menu_tracker.lua") ---@type menu_tracker
local splashes = dofile_once("mods/noita.hardmod/files/modules/logo_splash/splashes.lua") ---@type string[]

local FONT = "data/fonts/font_pixel.xml"
local TEXT_ANGLE = math.rad(60)
local SCREEN_MARGIN = 4
-- Nudges the splash center off the logo's right-edge midpoint; tuned by eye.
local ANCHOR_OFFSET_X = 8
local ANCHOR_OFFSET_Y = -10
local FIRST_GLYPH_ID = 1000

local gui = GuiCreate()
local was_visible = false
local splash_index = 0
local frame = 0
local draw_options = { scale = 1, font = FONT, z = -1000000, color = { r = 1, g = 1, b = 0, a = 1 } } ---@type rotatable_text_options

-- Lines and their scale-1 sizes only change on reroll; the per-frame pulse just multiplies them.
local lines = {} ---@type string[]
local line_widths = {} ---@type number[]
local line_heights = {} ---@type number[]
local line_origins_x = {} ---@type number[]
local line_origins_y = {} ---@type number[]
local block_width = 0
local block_height = 0

-- The glyph sprite must be generated while ModTextFileSetContent is still available.
rotatable_text.prepare(FONT)

---Picks a random splash index, never repeating the current one.
---@return integer
local function pick_splash_index()
	local count = #splashes
	if splash_index == 0 or count < 2 then return math.random(1, count) end
	local index = math.random(1, count - 1)
	if index >= splash_index then index = index + 1 end
	return index
end

---Splits a splash into lines and measures them at scale 1.
---@param splash string
local function layout_splash(splash)
	lines, line_widths, line_heights, line_origins_x, line_origins_y = {}, {}, {}, {}, {}
	block_width, block_height = 0, 0
	for line in splash:gmatch("[^\n]+") do
		local width, height, origin_x, origin_y = rotatable_text.measure(line, TEXT_ANGLE, 1, FONT)
		lines[#lines + 1] = line
		line_widths[#lines] = width
		line_heights[#lines] = height
		line_origins_x[#lines] = origin_x
		line_origins_y[#lines] = origin_y
		block_width = math.max(block_width, width)
		block_height = block_height + height
	end
end

---Returns the start coordinate that keeps a block inside the screen margin, favoring the top/left edge when it cannot fit.
---@param position number
---@param size number
---@param screen_size number
---@return number
local function clamp_to_screen(position, size, screen_size)
	return math.max(SCREEN_MARGIN, math.min(screen_size - SCREEN_MARGIN - size, position))
end

---Draws the splash lines centered on the logo's right edge with a pulsing scale.
---@param screen_width number
---@param screen_height number
local function draw_splash(screen_width, screen_height)
	frame = frame + 1
	local scale = 1.5 + math.sin(frame * 0.1) * 0.1
	draw_options.scale = scale

	local width, height = block_width * scale, block_height * scale
	local logo_right, logo_middle = menu_tracker.logo_right_middle()
	local block_x = clamp_to_screen(logo_right + ANCHOR_OFFSET_X - width / 2, width, screen_width)
	local line_y = clamp_to_screen(logo_middle + ANCHOR_OFFSET_Y - height / 2, height, screen_height)
	local glyph_id = FIRST_GLYPH_ID
	for line_index = 1, #lines do
		local line_x = block_x + ((block_width - line_widths[line_index]) / 2 + line_origins_x[line_index]) * scale
		local origin_y = line_y + line_origins_y[line_index] * scale
		glyph_id = rotatable_text.draw(gui, glyph_id, line_x, origin_y, lines[line_index], TEXT_ANGLE, draw_options)
		line_y = line_y + line_heights[line_index] * scale
	end
end

---Draw
local function update()
	GuiStartFrame(gui)
	local screen_width, screen_height = GuiGetScreenDimensions(gui)
	local visible = menu_tracker.should_show_splash()
	if visible and not was_visible then
		splash_index = pick_splash_index()
		layout_splash(splashes[splash_index])
	end
	was_visible = visible
	if visible then draw_splash(screen_width, screen_height) end
	menu_tracker.draw(gui, screen_width, screen_height)
end

return {
	-- Runs unpaused too, so GuiStartFrame clears the splash left over from the last paused frame.
	pre_update = update,
	pause_pre_update = function()
		if menu_tracker.pause_pre_update() then update() end
	end,
	pause_changed = menu_tracker.pause_changed,
}
