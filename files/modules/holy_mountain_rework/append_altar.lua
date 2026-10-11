local old_func = spawn_all_perks

function spawn_all_perks(x, y, ...)
	old_func(x, y, ...)

	EntityLoad("mods/noita.hardmod/files/modules/holy_mountain_rework/perk_check_collapse.xml", x, y)
end