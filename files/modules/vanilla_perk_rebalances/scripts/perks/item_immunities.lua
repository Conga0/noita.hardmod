local script_interval_frames = 30

local entity = GetUpdatedEntityID()
local player = EntityGetRootEntity(entity)
local inventory

for _,child in pairs(EntityGetAllChildren(player) or {}) do
  if EntityGetName(child) == "inventory_quick" then
    inventory = child
    break
  end
end

if not inventory then
  return
end

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
  if EntityHasTag(item, "thunderstone") then add_effect("PROTECTION_ELECTRICITY")
  elseif EntityHasTag(item, "brimstone") then add_effect("PROTECTION_FIRE")
  elseif EntityHasTag(item, "waterstone") then add_effect("BREATH_UNDERWATER")
  elseif EntityHasTag(item, "hardmod_cheese") then add_effect("PROTECTION_MELEE")
  end
end
