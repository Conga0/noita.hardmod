dofile_once("mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/perks/wand_experimenter/shared.lua")

local wand = GetUpdatedEntityID()
local comp = GetUpdatedComponentID()

local state = GetStoredWandState(wand)
local new_state = GetNewWandState(wand)

if not state or state == invalid_state then
  EntityRemoveComponent(wand, comp)
  return
end

if new_state == invalid_state or new_state ~= state then
  EntityRemoveComponent(wand, comp)
  MarkWandAsTinkered(wand)
  return
end
