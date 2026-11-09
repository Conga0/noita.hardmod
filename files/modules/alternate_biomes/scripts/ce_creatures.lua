local creatures = dofile_once("mods/component-explorer/spawn_data/creatures.lua")

local enemy_dir = "mods/noita.hardmod/files/modules/alternate_biomes/enemies/fungal/"

local fungal_enemies = {
	{ id = "zombie", vanilla = "zombie_weak", herd = "fungus" },
	{ id = "slimeshooter", vanilla = "slimeshooter_weak", herd = "fungus" },
	{ id = "acidshooter", vanilla = "acidshooter_weak", herd = "fungus" },
	{ id = "giantshooter", vanilla = "giantshooter_weak", herd = "fungus" },
	{ id = "miner", vanilla = "miner_weak", herd = "fungus" },
	{ id = "shotgunner", vanilla = "shotgunner_weak", herd = "fungus" },
	{ id = "firemage", vanilla = "firemage_weak", herd = "fungus" },
	{ id = "worm", vanilla = "worm", herd = "fungus" },
	{ id = "skull", vanilla = "fireskull", herd = "fungus" },
	{ id = "shaman", vanilla = "shaman", herd = "fungus" },
	{ id = "alchemist", vanilla = "alchemist", herd = "fungus" },
	{ id = "thundermage", vanilla = "thundermage", herd = "fungus" },
	{ id = "longleg", vanilla = "longleg", herd = "spider" },
}

local vanilla_tags = {}
for _,creature in ipairs(creatures) do
	vanilla_tags[creature.file] = creature.tags
end

for _,enemy in ipairs(fungal_enemies) do
	table.insert(creatures, {
		file = enemy_dir..enemy.id.."/hardmod_fungal_"..enemy.id..".xml",
		herd = enemy.herd,
		name = "$animal_hardmod_fungal_"..enemy.id,
		origin = "Hard Mod",
		tags = vanilla_tags["data/entities/animals/"..enemy.vanilla..".xml"] or "teleportable_NOT,enemy,mortal,human,hittable,homing_target,destruction_target",
	})
end
