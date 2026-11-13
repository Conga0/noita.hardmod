local script_interval_frames = 20

local entity = GetUpdatedEntityID()
local player = EntityGetRootEntity(entity)
local inventory

local weakening = EntityGetAllChildren(player, "spirit_weaken_effect")
if weakening and #weakening > 0 then
	return
end

for _,child in pairs(EntityGetAllChildren(player) or {}) do
	if EntityGetName(child) == "inventory_quick" then
		inventory = child
		break
	end
end

if not inventory then return end

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

local added = {}

---@param name game_effect
local function add_effect(name)
	if added[name] then return end
	added[name] = true

	local effect = GetGameEffectLoadTo(player, name, true)
	if effect then
		ComponentSetValue2(effect, "frames", script_interval_frames + 1)
	end
end

for _,item in pairs(EntityGetAllChildren(inventory) or {}) do
	if EntityGetFilename()
	if EntityHasTag(item, "thunderstone") then add_effect("PROTECTION_ELECTRICITY")
	elseif EntityHasTag(item, "brimstone") then add_effect("PROTECTION_FIRE")
	elseif EntityHasTag(item, "waterstone") then add_effect("BREATH_UNDERWATER")
	elseif EntityHasTag(item, "hardmod_cheese") then add_effect("PROTECTION_MELEE")
	end
end