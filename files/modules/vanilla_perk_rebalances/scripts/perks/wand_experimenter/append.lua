dofile_once("mods/noita.hardmod/files/modules/vanilla_perk_rebalances/scripts/perks/wand_experimenter/shared.lua")
dofile_once("data/scripts/game_helpers.lua")

-- 40 for shuffle, 20 for a nonshuffler
local shuffle_bonus_multiplier = 2
local heal_amounts = { 4, 4, 4, 4, 4 }

function wand_fired(wand)
  if not wand then return end

  local player = EntityGetRootEntity(GetUpdatedEntityID())
  if not player or not IsPlayer(player) then return end

  local state = GetStoredWandState(wand)
  local new_state = GetNewWandState(wand)

  -- Nuh uh!
  if IsWandStateInvalid(state, new_state) then
    return
  end

  local comp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent")
  if not comp then return end

  local shuffler = ComponentObjectGetValue2(comp, "gun_config", "shuffle_deck_when_empty")
  local casts = tonumber(ComponentGetValue2(comp, "stat_times_player_has_shot")) or 0

  if casts > #heal_amounts then
    MarkWandAsTinkered(wand)
    return
  end

  local hp = heal_amounts[casts]
  if shuffler then
    hp = hp * shuffle_bonus_multiplier
  end

  ---@diagnostic disable-next-line: undefined-global
  heal_entity(player, hp / 25)
end
