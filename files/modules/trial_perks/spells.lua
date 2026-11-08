---@diagnostic disable: undefined-global

return {
	new_spells = {
		{
			id					= "HARDMOD_BLINK",
			name				= "$hardmod_spell_blink_name",
			description			= "$hardmod_spell_blink_desc",
			sprite				= "mods/noita.hardmod/files/modules/trial_perks/gfx/ui_gfx/spells/blink.png",
			type				= ACTION_TYPE_UTILITY,
			spawn_probability 	= "0",
			spawn_requires_flag = "hardmod_impossible_spawn",
			price				= 400,
			mana				= 200,
			max_uses			= 10,
			never_unlimited		= true,
			action = function()
				c.fire_rate_wait = c.fire_rate_wait + 60
				if reflecting then return end

				add_projectile( "mods/noita.hardmod/files/modules/trial_perks/entities/spells/blink.xml" )
			end,
		},
	}
}
