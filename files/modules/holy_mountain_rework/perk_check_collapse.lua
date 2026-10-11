local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/biomes/temple_shared.lua" )

local function collapse()
	-- this reset the biome stats - see workshop_trigger_check_stats.lua
	StatsBiomeReset()

	EntityLoad("data/entities/misc/workshop_collapse.xml", x - 240, y - 60)
	EntityLoad("data/entities/misc/workshop_areadamage.xml", x-143, y+47) --unmodified
	EntityLoad("data/entities/misc/workshop_areadamage.xml", x-543, y+47) --unmodified

	-- Destroy workshop entities

	local entities_to_kill = {
		"workshop",
		"workshop",
		"workshop",
		"workshop_show_hint"
	}
	for _,tag in ipairs(entities_to_kill) do
		EntityKill(EntityGetClosestWithTag(x, y, tag))
	end

	-- kill temple_areacheckers that are on (about) the same horizontal level as we are
	local temple_areacheckers = EntityGetInRadiusWithTag( x, y, 2048, "temple_areachecker" )
	for k,areachecker in pairs(temple_areacheckers) do
		local area_x, area_y = EntityGetTransform( areachecker )
		if( math.abs( y - area_y ) < 512 ) then
			EntityKill( areachecker )
		end
	end

	-- SetGlobalValue( "temple_collapsed_" )
	-- tags="temple_areachecker"

	local collapse_name = "TEMPLE_COLLAPSED_" .. temple_pos_to_id( x, y )
	GlobalsSetValue( collapse_name, "1" )

	temple_set_active_flag( x, y, "0" )

	GameTriggerMusicFadeOutAndDequeueAll( 2.0 )
	GamePlaySound( "data/audio/Desktop/misc.bank", "misc/temple_collapse", x-112, y + 40 )
end

local nearby_perks = EntityGetInRadius(x, y, 130)
if #EntityGetInRadiusWithTag(x, y, 130, "perk") == 0 then
	for _,crystal in ipairs(EntityGetInRadiusWithTag(x+250, y, 60, "worm_crystal") or {}) do
		if EntityGetName(crystal) == "hardmod_collapse_crystal" then
			collapse()
		end
	end
	EntityKill(entity_id)
end