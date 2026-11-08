local root = "mods/noita.hardmod/files/modules/for_the_worthy/"
dofile_once(root.."shared.lua")

function item_pickup(item, player)
	if not IsPlayer(player) then return end

	local x, y = EntityGetTransform(item)
	local visual_y = y - 16

	HardmodEnableHell(player)
	GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", x, visual_y)
	EntityLoad(root.."entity/pick_effect.xml", x, visual_y)

	EntityAddComponent2(player, "UIIconComponent", {
		name = "$hardmod_hell_mode_detail_title",
		description = "$hardmod_hell_mode_detail_desc",
		icon_sprite_file = "mods/noita.hardmod/files/modules/for_the_worthy/gfx/hell_perk_016.png",
		is_perk = true,
	})

	local emitter = EntityGetInRadiusWithTag(x, y, 10, "hardmod_hell_perk_emitter")[1]
	if emitter then
		local comp = EntityGetFirstComponent(emitter, "ParticleEmitterComponent")
		if comp then
			ComponentSetValue2(comp, "image_animation_speed", 10)
		end
	end

	GamePrintImportant("$hardmod_hell_mode_popup_title", "$hardmod_hell_mode_popup_desc")
	GameScreenshake(150)
	EntityKill(item)
end
