local effect_items = {
	["data/entities/items/pickup/brimstone.xml"] = {
        game_effects = {
            "PROTECTION_FIRE",
        },
    },
	["data/entities/items/pickup/waterstone.xml"] = {
        game_effects = {
            "BREATH_UNDERWATER",
        },
    },
	["data/entities/items/pickup/thunderstone.xml"] = {
        game_effects = {
            "PROTECTION_ELECTRICITY",
        },
    },
	--["data/entities/items/pickup/stonestone.xml"] = {}, --no effect associated at present
	["mods/noita.hardmod/files/modules/vanilla_perk_rebalances/entities/items/cheese.xml"] = {
        game_effects = {
            "PROTECTION_MELEE",
        },
    },
	["data/entities/items/pickup/sun/sunseed.xml"] = {
        children = {
            "hardmod.all_seeing_eye"
        }
    },
	["data/entities/items/pickup/sun/sunstone.xml"] = {
        children = {
            "hardmod.all_seeing_eye"
        }
    },
}

for _,data in ipairs(effect_items) do
    for _,game_effect in ipairs(data.game_effects) do
        data.game_effects[game_effect] = true
    end
    for _,child in ipairs(data.children) do
        data.children[child] = true
    end
end


return effect_items