dofile_once("data/scripts/lib/utilities.lua")

local FLOAT_RANGE = 5
local SPEED = 20
local DEBUG = false
local RAYCAST_DISTANCE = 50
local RAYCAST_STEPS = 36
local GRAVITY_NEAR_SURFACE = 0
local GRAVITY_FALLING = 300
local STOP_DISTANCE = 100

local function GetPlayers()
	local players = EntityGetWithTag("player_unit") or {}
	for _, player in ipairs(EntityGetWithTag("polymorphed_player") or {}) do
		table.insert(players, player)
	end
	return players
end

frames_ran = frames_ran or 0
move_x = move_x or 0
move_y = move_y or 0

frames_ran = frames_ran + 1
if frames_ran < 3 then return end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

if move_x == 0 and move_y == 0 then
	move_x = x
	move_y = y
end

local players = GetPlayers()
if #players == 0 then return end
local player = players[1]

local player_x, player_y = EntityGetTransform(player)
local player_too_close = math.sqrt((player_x - x) ^ 2 + (player_y - y) ^ 2) <= STOP_DISTANCE

local normal_hit, normal_x, normal_y = GetSurfaceNormal(x, y, FLOAT_RANGE, RAYCAST_STEPS)
local function isNearSurface()
	return normal_hit
end

if GameGetFrameNum() % 5 == 0 then
	if player then
		local closest_distance_to_player = math.huge
		local target_x, target_y = x, y

		for i = 1, RAYCAST_STEPS do
			local angle = (i / RAYCAST_STEPS) * (2 * math.pi)
			local ray_dx = math.cos(angle) * RAYCAST_DISTANCE
			local ray_dy = math.sin(angle) * RAYCAST_DISTANCE

			local hit, hit_x, hit_y = RaytraceSurfacesAndLiquiform(x, y, x + ray_dx, y + ray_dy)

			if hit then
				local distance_to_player = math.sqrt((player_x - hit_x) ^ 2 + (player_y - hit_y) ^ 2)

				if distance_to_player < closest_distance_to_player then
					closest_distance_to_player = distance_to_player
					target_x = hit_x
					target_y = hit_y
				end
			end
		end

		move_x = target_x
		move_y = target_y
	end
end

local target_dx = move_x - x
local target_dy = move_y - y
local distance_to_target = math.max(1, math.sqrt(target_dx ^ 2 + target_dy ^ 2))
local direction_x = target_dx / distance_to_target
local direction_y = target_dy / distance_to_target

local desired_vel_x = direction_x * SPEED
local desired_vel_y = direction_y * SPEED

if player_too_close then
	desired_vel_x = 0
	desired_vel_y = 0
end

if DEBUG then
	GameCreateSpriteForXFrames(
		"data/ui_gfx/debug_marker.png",
		x + direction_x * 10,
		y + direction_y * 10,
		true,
		0,
		0,
		1,
		true
	)
end

local velocity_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
local character_data_comp =
	EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
local character_platforming_component =
	EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterPlatformingComponent")
if velocity_comp and character_data_comp and character_platforming_component then
	local current_vel_x, current_vel_y = ComponentGetValue2(velocity_comp, "mVelocity")

	if isNearSurface() then
		local vel_x = current_vel_x * 0.8 + desired_vel_x
		local vel_y = current_vel_y * 0.8 + desired_vel_y

		ComponentSetValue2(character_data_comp, "gravity", GRAVITY_NEAR_SURFACE)
		ComponentSetValue2(character_platforming_component, "pixel_gravity", GRAVITY_NEAR_SURFACE)

		ComponentSetValue2(velocity_comp, "mVelocity", vel_x, vel_y)
		ComponentSetValue2(character_data_comp, "mVelocity", vel_x, vel_y)
	else
		ComponentSetValue2(character_data_comp, "gravity", GRAVITY_FALLING)
		ComponentSetValue2(character_platforming_component, "pixel_gravity", GRAVITY_FALLING)
	end
end
