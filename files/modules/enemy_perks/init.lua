local hooks = {}
local _g = GLOBAL_DATA

local curr_path = "mods/noita.hardmod/files/modules/enemy_perks/"

ModLuaFileAppend("data/scripts/perks/perk_reflect.lua", curr_path.."add_perks_to_progress.lua")


local enemy_perks = {}
local enemy_perks_indexed = {}

local offscreen_leniancy = 16 --how many pixels off-screen can the target be before the window closes automatically
local min_dark = 200 --maximum dark value the target can be in before the windo closes automatically

local gz = 100 --Z position that all the GUI is relative to
local x_offset_from_target = 16 --x offset away from the target's origin
local y_offset_from_target = -20 --y offset away from the target's origin
local edge_padding = 3 --padding in pixels from the left, right and bottom sides of the window
local top_padding = 2 --padding between the top of the window and the name, and the name and perk view
local icon_padding = 1 --padding between perks in the perk view
local max_perks_per_row = 5 --max perks before breaking into a new row
local icon_size = 16 --the xy size of the perk icons

RemoveFlagPersistent("perk_picked_enemyperk_hardmod_test_perk")
local function update_perk_unlock_states()
	for _,perk in ipairs(enemy_perks) do
		perk.locked = not HasFlagPersistent("perk_picked_enemyperk_hardmod_"..perk.id:lower())
	end
end

hooks.mod_post_init = function() --run later in case of appends
	enemy_perks = dofile_once(curr_path.."enemy_perks_list.lua")
	for _,perk in ipairs(enemy_perks) do
		enemy_perks_indexed[perk.id] = perk
	end

	update_perk_unlock_states()
end

hooks.world_init = function()
	SetRandomSeed(1337, -6967)
end

local function give_enemy_perk(entity_id)
	local x,y = EntityGetTransform(entity_id)
	local enemy_perks_handler
	for _,child in ipairs(EntityGetAllChildren(entity_id) or {}) do
		if EntityGetName(child) == "hardmod.enemy_perks" then enemy_perks_handler = child break end
	end
	if not enemy_perks_handler then
		enemy_perks_handler = EntityLoad("mods/noita.hardmod/files/modules/enemy_perks/handler.xml", x, y)
		EntityAddChild(entity_id, enemy_perks_handler)
	end

	local enemy_perk_data
	for _,varcomp in ipairs(EntityGetComponent(enemy_perks_handler, "VariableStorageComponent") or {}) do
		if ComponentGetValue2(varcomp, "name") == "enemy_perk_data" then enemy_perk_data = varcomp break end
	end
	if not enemy_perk_data then
		enemy_perk_data = EntityAddComponent2(enemy_perks_handler, "VariableStorageComponent", {name = "enemy_perk_data"})
	end

	local data = {
		player = _g.player,
		player_poly_identity = _g.player_poly_identity
	}
	local perk = ConditionalRandomFromTable(enemy_perks, data)
	if not perk then return end
	perk:func(entity_id)


	local held_perks = ComponentGetValue2(enemy_perk_data, "value_string")
	if #held_perks == 0 then held_perks = perk.id else held_perks = held_perks..","..perk.id end
	ComponentSetValue2(enemy_perk_data, "value_string", held_perks)

	if not EntityHasTag(entity_id, "hardmod_blessed") then
		EntityAddTag(entity_id, "hardmod_blessed")
	end
end


hooks.new_eid = function(entity_id)
	if EntityHasTag(entity_id, "enemy") and not EntityHasTag(entity_id, "hardmod_blessed") then
		give_enemy_perk(entity_id)
		give_enemy_perk(entity_id)
		give_enemy_perk(entity_id)
		give_enemy_perk(entity_id)
		give_enemy_perk(entity_id)
		give_enemy_perk(entity_id)
		give_enemy_perk(entity_id)
	end
end



local gui = GuiCreate()

local _id = 0
local function new_id()
	_id = _id + 1
	return _id
end

local virt_x, virt_y, screen_width, screen_height, scale_x, scale_y, cx, cy
local function world_to_screen_coordinates(x, y)
	return (x - cx) / scale_x + screen_width / 2 + 1.5, (y - cy) / scale_y + screen_height / 2
end

local cached_perk_hover_info = {}

local selected_creature = nil
function hooks.post_update(frame)
	if GameHasFlagRun("hardmod_new_enemy_perk_discovered") then
		update_perk_unlock_states()
	end


	if InputIsKeyJustDown(18) then
		local x,y = DEBUG_GetMouseWorld()
		selected_creature = EntityGetClosestWithTag(x, y, "hardmod_blessed")
		local creature_x,creature_y = EntityGetTransform(selected_creature)
		if (creature_x-x)^2 + (creature_y-y)^2 > 16^2 then selected_creature = nil end
		print("selected creature: "..tostring(selected_creature))
	end
	if not EntityGetIsAlive(selected_creature or 0) then selected_creature = nil end
	if not (selected_creature and EntityGetIsAlive(selected_creature)) then return end

	local creature_x,creature_y = EntityGetTransform(selected_creature)
	if GameGetFogOfWarBilinear(creature_x, creature_y) > min_dark then selected_creature = nil return end

	GuiStartFrame(gui)
	virt_x = MagicNumbersGetValue("VIRTUAL_RESOLUTION_X")
	virt_y = MagicNumbersGetValue("VIRTUAL_RESOLUTION_Y")
	screen_width, screen_height = GuiGetScreenDimensions(gui)
	scale_x = virt_x / screen_width
	scale_y = virt_y / screen_height
	cx, cy = GameGetCameraPos()


	local vx = creature_x - cx + virt_x / 2
	local vy = creature_y - cy + virt_y / 2
	local gui_x = vx * screen_width / virt_x
	local gui_y = vy * screen_height / virt_y
	if gui_x < (0-offscreen_leniancy) or gui_x > (screen_width+offscreen_leniancy) or gui_y < (0-offscreen_leniancy) or gui_y > (screen_height+offscreen_leniancy) then selected_creature = nil return end


	local enemy_perks_handler
	for _,child in ipairs(EntityGetAllChildren(selected_creature) or {}) do
		if EntityGetName(child) == "hardmod.enemy_perks" then enemy_perks_handler = child break end
	end
	if not enemy_perks_handler then return end

	local enemy_perk_data
	for _,varcomp in ipairs(EntityGetComponent(enemy_perks_handler, "VariableStorageComponent") or {}) do
		if ComponentGetValue2(varcomp, "name") == "enemy_perk_data" then enemy_perk_data = varcomp break end
	end
	if not enemy_perk_data then return end

	local target_perks = {}
	for perk_id in ComponentGetValue2(enemy_perk_data, "value_string"):gmatch("([^,]+)") do
		target_perks[#target_perks+1] = enemy_perks_indexed[perk_id]
	end

	local function render_perk(perk, x, y)
		if perk.locked then GuiColorSetForNextWidget(gui, 0.3, 0.3, 0.3, 1) end
		GuiImage(gui, new_id(), x, y, perk.icon, 1, 1, 1)
		local prev = {GuiGetPreviousWidgetInfo(gui)}
		if prev[3] then
			local perk_hover_info
			if not cached_perk_hover_info[perk.id] then
				cached_perk_hover_info[perk.id] = {
					icon = perk.icon,
					name = GameTextGetTranslatedOrNot(perk.name),
					box_size = {
						x = edge_padding*2 + icon_size*2 + top_padding + math.max(GuiGetTextDimensions(gui, perk_hover_info.name), 48),
						y = top_padding,
					}
				}
			end
		end
	end

	local name = GameTextGetTranslatedOrNot(EntityGetName(selected_creature))
	local name_w,name_h = GuiGetTextDimensions(gui, name)

	local box_size = {
		x = edge_padding * 2 + math.max(icon_padding*math.max(math.min(#target_perks, 5)-1, 0) + math.min(#target_perks, 5) * icon_size, name_w),
		y = top_padding + name_h + edge_padding * 2 + icon_padding*math.max(math.ceil(#target_perks*.2)-1, 0) + math.ceil(#target_perks*.2) * icon_size,
	}

	local box_origin_x,box_origin_y = gui_x + x_offset_from_target, gui_y + y_offset_from_target
	if box_origin_x + box_size.x >= screen_width then box_origin_x = gui_x - (x_offset_from_target + box_size.x) end
	box_origin_y = math.max(math.min(box_origin_y, screen_height-box_size.y), 0)
	GuiZSetForNextWidget(gui, gz-4)
	GuiImageNinePiece(gui, new_id(), box_origin_x, box_origin_y, box_size.x, box_size.y)
	GuiText(gui, box_origin_x+edge_padding, box_origin_y+top_padding, name)

	local next_perk_x,next_perk_y,next_perk_num =
		box_origin_x+edge_padding,
		box_origin_y+top_padding+name_h+edge_padding,
		0

	for _,perk in ipairs(target_perks) do
		GuiZSetForNextWidget(gui, gz-5)
		render_perk(perk, next_perk_x, next_perk_y)
		next_perk_num = next_perk_num + 1
		if next_perk_num % max_perks_per_row == 0 then
			next_perk_x = box_origin_x+edge_padding
			next_perk_y = next_perk_y + icon_size + icon_padding
		else
			next_perk_x = next_perk_x + icon_size + icon_padding
		end
	end
end--]]

return hooks