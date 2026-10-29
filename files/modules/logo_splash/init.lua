-- Overengineered logo splash thingy

local rotatable_text = dofile_once("mods/noita.hardmod/files/modules/logo_splash/rotatable_text.lua") ---@type rotatable_text
local menu_tracker = dofile_once("mods/noita.hardmod/files/modules/logo_splash/menu_tracker.lua") ---@type menu_tracker
local splashes = dofile_once("mods/noita.hardmod/files/modules/logo_splash/splashes.lua") ---@type string[]

local year,month,day,hour,minute,second = GameGetDateAndTimeLocal()
SetRandomSeed(minute, second) --seed this off smth

local FONT = "data/fonts/font_pixel.xml"
local TEXT_ANGLE = math.rad(20)
local SCREEN_MARGIN = 4
-- Nudges the splash center off the logo's right-edge midpoint; tuned by eye.
local ANCHOR_OFFSET_X = 8
local ANCHOR_OFFSET_Y = 20
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

---@type integer[]
local splash_idx_queue = {}

---Picks a random splash index, never repeating the current one.
---@return integer
local function pick_splash_index()
	if #splash_idx_queue < 1 then
		for idx,_ in ipairs(splashes) do
			table.insert(splash_idx_queue, idx)
		end
	end

	local idx = math.random(1, #splash_idx_queue)
	local splash = splash_idx_queue[idx]

	if splash == splash_index and #splash_idx_queue > 1 then
		return pick_splash_index()
	end

	table.remove(splash_idx_queue, idx)

	return splash
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

---Draws the splash lines centered on the logo's bottom right corner with a pulsing scale AND ROTATION.
---@param screen_width number
---@param screen_height number
local function draw_splash(screen_width, screen_height)
    frame = frame + 1
    local scale = 1.5 + math.sin(frame * 0.1) * 0.1
    draw_options.scale = scale

    local _, metrics = rotatable_text.prepare(draw_options.font)
    local line_height = metrics.line_height

    local widths, block_w = {}, 0
    for i, text in ipairs(lines) do
        widths[i] = rotatable_text.measure(text, 0, 1, draw_options.font)
        block_w = math.max(block_w, widths[i])
    end

    local width = block_w * scale
    local height = #lines * line_height * scale
    local logo_right, logo_middle = menu_tracker.logo_right_middle()
    local block_x = clamp_to_screen(logo_right + ANCHOR_OFFSET_X - width / 2, width, screen_width)
    local block_y = clamp_to_screen(logo_middle + ANCHOR_OFFSET_Y - height / 2, height, screen_height)

    local center_x = block_x + width / 2
    local center_y = block_y + height / 2

    local angle = math.sin(frame * 0.01) * TEXT_ANGLE -- radians
    local cos_a, sin_a = math.cos(angle), math.sin(angle)

    local glyph_id = FIRST_GLYPH_ID
    for i = 1, #lines do
        local line_x = block_x + (block_w - widths[i]) / 2 * scale
        local line_y = block_y + (i - 1) * line_height * scale

        local dx, dy = line_x - center_x, line_y - center_y
        local rot_x = center_x + dx * cos_a - dy * sin_a
        local rot_y = center_y + dx * sin_a + dy * cos_a
		-- hope you don't mind me making this shit actively worse but i needed it to rotate left and right

        glyph_id = rotatable_text.draw(gui, glyph_id, rot_x, rot_y, lines[i], angle, draw_options)
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
	count_secrets = function(total, found)
		menu_tracker.count_secrets()
		return total, found
	end,
}
