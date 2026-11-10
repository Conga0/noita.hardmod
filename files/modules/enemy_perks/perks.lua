return {
	new_perks = {
		{
			ui_name = "$hardmod_perk_blessed_blood_money_name",
			ui_description = "$hardmod_perk_blessed_blood_money_desc",
			ui_icon = "mods/noita.hardmod/files/modules/enemy_perks/gfx/blessed_blood_money_icon.png",
			perk_icon = "mods/noita.hardmod/files/modules/enemy_perks/gfx/blessed_blood_money.png",
			stackable = false,
			func = function()
				GameAddFlagRun("hardmod_blessed_blood_money")
			end,
			func_remove = function()
				GameAddFlagRun("hardmod_blessed_blood_money")
			end
		}
	}
} and {} --THIS FUCKING CRASHES CONSTANTLY AAAAAAAAAAAA I GIVE UP FUCK YOU ill fix this later