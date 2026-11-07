RegisterSpawnFunction(0xff6411ff, "spawn_purchasable_item")
dofile_once("mods/noita.hardmod/files/modules/holy_mountain_items/shop_item/spawn.lua")

function spawn_hp(x, y)
	EntityLoad("data/entities/buildings/music_trigger_temple.xml", x-16, y)

	EntityLoad("mods/noita.hardmod/files/modules/holy_mountain_items/entities/heal_shop.xml", x-16, y)
	EntityLoad("mods/noita.hardmod/files/modules/holy_mountain_items/entities/spell_refresh_shop.xml", x+16, y)
end
