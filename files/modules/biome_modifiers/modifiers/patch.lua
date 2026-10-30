---@diagnostic disable: undefined-global

BiomesWithModifiers = {}

MaxBiomeModifierCount = { default = 1 }
BiomeModifierChances = {
  default = 0.1,
  coalmine = 0.2,
  excavationsite = 0.15,
}

ForcedBiomeModifiers = {
  wandcave = "FOG_OF_WAR_CLEAR_AT_PLAYER", wizardcave = "FOG_OF_WAR_CLEAR_AT_PLAYER",
	alchemist_secret = "FOG_OF_WAR_CLEAR_AT_PLAYER",
  mountain_top = "FREEZING", mountain_floating_island = "FREEZING",
  winter = "FREEZING", winter_caves = "FREEZING_COSMETIC",
	lavalake = "HOT", desert = "HOT",
	pyramid_entrance = "HOT", pyramid_left = "HOT", pyramid_top = "HOT", pyramid_right = "HOT",
  watercave = "MOIST",
  rainforest_dark = "FOG_OF_WAR_REAPPEARS",
  lake = { id = "MOIST", chance = 0.75 },
  fungicave = { id = "MOIST", chance = 0.5 },
}

local modifiers = {}
local modifiers_by_id = {}
local total_weight = 0

function PatchModifiers(tbl)
  for _,modifier in pairs(biome_modifiers) do
    if tbl[modifier.id] then
      for k,v in pairs(tbl[modifier.id]) do
        modifier[k] = v
      end
    end
  end
end

function AddModifiers(tbl)
  for _,modifier in pairs(tbl) do
    table.insert(biome_modifiers, modifier)
  end
end

---@param tbl string[]
---@param to_biome string?
function AddBiomeGroup(tbl, to_biome)
  if to_biome then
    local add_to = nil
    for _,list in pairs(biomes) do
      for _,biome in pairs(list) do
        if biome == to_biome then
          add_to = list
          break
        end
      end
    end

    if not add_to then return end
    for _,biome in pairs(tbl) do
      table.insert(add_to, biome)
    end
  else
    table.insert(biomes, tbl)
  end
end

local function get_modifier_table()
  if #modifiers > 0 then return end

  for _,modifier in pairs(biome_modifiers) do
    if modifier.requires_flag and not HasFlagPersistent(modifier.requires_flag) then goto continue end

    if modifier.apply_only_to_biome then
      modifier.whitelist_biomes = {}
      for _,biome in pairs(modifier.apply_only_to_biome) do
        modifier.whitelist_biomes[biome] = true
      end
    end

    if modifier.does_not_apply_to_biome then
      modifier.blacklist_biomes = {}
      for _,biome in pairs(modifier.does_not_apply_to_biome) do
        modifier.blacklist_biomes[biome] = true
      end
    end

    table.insert(modifiers, modifier)
    total_weight = total_weight + modifier.probability
    modifiers_by_id[modifier.id] = modifier

    ::continue::
  end
end

local function random_biome_modifier()
  if total_weight == 0 then get_modifier_table() end

	local rnd = Randomf(0, total_weight)
	for _,entry in pairs(modifiers) do
		if rnd <= entry.probability then return entry end
		rnd = rnd - entry.probability
	end
	return modifiers[#modifiers]
end

local function pick_modifiers_for(biome, count)
  local picked = {}
  local picked_categories = {}
  local picked_ids = {}

  for _=0,100 do
    local modifier = random_biome_modifier()

    if
      picked_ids[modifier.id]
      or (modifier.category and picked_categories[modifier.category])
      or (modifier.blacklist_biomes and modifier.blacklist_biomes[biome])
      or (modifier.whitelist_biomes and not modifier.whitelist_biomes[biome])
    then
      goto continue
    end

    table.insert(picked, modifier)

    picked_ids[modifier.id] = true
    if modifier.category then
      picked_categories[modifier.category] = true
    end

    if #picked >= count then break end

    ::continue::
  end

  return picked
end

local function resolve_modifier(modifier)
  local id
  local chance = 1

  if type(modifier) == "table" then
    id = modifier.id
    chance = modifier.chance or 1
  else
    id = modifier
  end

  if Randomf() > chance then return end

  if type(id) == "table" then
    local list = {}
    for _,mod in pairs(id) do
      table.insert(modifiers_by_id[mod])
    end

    return list
  else
    return { modifiers_by_id[id] }
  end
end

function get_modifier_mappings()
  local result = {}

  get_modifier_table()
  SetRandomSeed(347893, 90734)
  rnd = random_create(347893, 90734)

  local total_count = 0

  for _,biome_names in pairs(biomes) do
    local biome = biome_names[1]
    local chance = BiomeModifierChances[biome] or BiomeModifierChances.default
    local max = MaxBiomeModifierCount[biome] or MaxBiomeModifierCount.default
    if max == 0 then goto continue end

    local count = 0
    for _=1,max do
      if Randomf() <= chance then
        count = count + 1
      end
    end
    if count == 0 then goto continue end

    local list = pick_modifiers_for(biome, count)
    total_count = total_count + #list

    for _,name in pairs(biome_names) do
      result[name] = list
      BiomesWithModifiers[name] = list
    end

    ::continue::
  end

  for biome,modifier in pairs(ForcedBiomeModifiers) do
    local mod = resolve_modifier(modifier)
    if mod and not result[biome] then
      result[biome] = mod
      total_count = total_count + #mod
    end
  end

  print("Generated "..total_count.." modifiers")

  return result
end

-- called from init_biome_modifiers
function apply_modifier_from_data(name, list)
  local filename = name
	if not string_starts(filename, "data/") and not string_starts(filename, "mods/") then
    filename = "data/biome/"..name..".xml"
  end

  SetRandomSeed(347893, 90734)

  local utils = dofile_once("mods/noita.hardmod/lib/utilities.lua")
  print(name..": "..utils.dumpf(list))
  for _,modifier in pairs(list) do
    modifier.action(name, filename)
  end

  if #list > 0 and not BiomesWithModifiers[name] then
    table.insert(biomes_with_modifier, name)
    BiomesWithModifiers[name] = list
  end
end

function biome_modifiers_inject_spawns(name)
  local mappings = get_modifier_mappings()[name] or {}
  for _,modifier in pairs(mappings) do
    if modifier.inject_spawns_action then
      modifier.inject_spawns_action(name)
    end
  end
end

function apply_modifier() end
function apply_modifier_if_has_none() end

AddModifiers({ biome_modifier_cosmetic_freeze, biome_modifier_fog_of_war_clear_at_player })
PatchModifiers({
  FUNGAL = { category = "alternative" },
  FLOODED = { category = "alternative" },
  GAS_FLOODED = { category = "alternative" },
  FREEZING = { category = "temperature" },
  MOIST = { category = "temperature" },
  HOT = { category = "temperature" },
  FREEZING_COSMETIC = { category = "temperature" },
  FOG_OF_WAR_REAPPEARS = { category = "fog" },
  FOG_OF_WAR_CLEAR_AT_PLAYER = { category = "fog" },
  HIGH_GRAVITY = { category = "gravity" },
  LOW_GRAVITY = { category = "gravity" },
  GOLD_VEIN = { category = "gold" },
  GOLD_VEIN_SUPER = { category = "gold" },
  PERFORATED = { category = "worms" },
  WORMY = { category = "worms" },

  -- no categories for these
  -- CONDUCTIVE = { category = "" },
  -- PLANT_INFESTED = { category = "" },
  -- FURNISHED = { category = "" },
  -- BOOBY_TRAPPED = { category = "" },
  -- SPOOKY = { category = "" },
  -- GRAVITY_FIELDS = { category = "" },
  -- SHIELDED = { category = "" },
  -- PROTECTION_FIELDS = { category = "" },
  -- OMINOUS = { category = "" },
  -- INVISIBILITY = { category = "" },
})
