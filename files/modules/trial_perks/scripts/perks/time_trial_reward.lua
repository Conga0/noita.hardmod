dofile_once( "mods/noita.hardmod/files/modules/trial_perks/scripts/trial_perk_utils.lua" )

local function spawn_staff( x, y, frames_left )
	local tier = 1
	if frames_left >= 2700 then
		tier = 3
	elseif frames_left <= 1800 then
		tier = 2
	end

	local EZWand = dofile_once( "mods/noita.hardmod/lib/ezwand.lua" )
	local wand = EZWand()
	wand:SetName( "Aika", true )
	wand.shuffle = false
	wand.spellsPerCast = 1
	wand.castDelay = 30
	wand.rechargeTime = 40
	wand.manaMax = 360 * tier
	wand.manaChargeSpeed = 60 * tier
	wand.capacity = 6 * tier
	wand.spread = 0
	wand:AddSpells( "TELEPORT_PROJECTILE_SHORT", "LIGHT_BULLET", "LIGHT_BULLET", "HARDMOD_ALT_FIRE_ANYTHING", { "HARDMOD_BLINK", tier } )
	wand:RemoveSpells( "LIGHT_BULLET", -1 )
	wand:SetSprite( "mods/noita.hardmod/files/modules/trial_perks/gfx/items/wand_aika.png", 8, 4, 19, 0 )
	wand:PlaceAt( x, y )
	
	return true
end

local player = GetUpdatedEntityID()
local px, py = EntityGetTransform( player )
AddFlagPersistent( "hardmod_time_trial_passed" )

GamePrintImportant( "You passed the Time Trial!" )
EntityLoad( "data/entities/particles/image_emitters/perk_effect.xml", px, py - 8 )
GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/chest/create", px, py - 8 )

local game_effect = EntityGetAllChildren( player, "hardmod_time_trial_game_effect" )[1]
if game_effect then
	local effect_comp = EntityGetFirstComponentIncludingDisabled( game_effect, "GameEffectComponent" )
	if effect_comp then
		local frames_left = ComponentGetValue2( effect_comp, "frames" )
		spawn_staff( px, py - 8, frames_left )
	end
end

EntityRemoveAllByTag( player, "hardmod_time_trial" )
SwapPerkIconForSpent( player, "$hardmod_perk_time_trial_name", true )
SetInternalInt( player, "hardmod_time_trial_start_y", 0 )
