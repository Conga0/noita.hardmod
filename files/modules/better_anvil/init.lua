local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua")---@type nxml

local function patch_broken_wand()
  modifile(
    "data/scripts/items/broken_wand_throw.lua",
    [[spell_amount = 18]], [[spell_amount = 27]]
  )

  local search = "shoot_projectile( entity_id, spell, pos_x, pos_y, vel_x, vel_y)"
  modifile(
    "data/scripts/items/broken_wand_spells.lua",
    search,
    "local thrown_projectile = " .. search .. [[
      EntityAddComponent2(thrown_projectile, "HomingComponent", {
        _tags = "homing_projectile",
        homing_targeting_coeff = 130.0,
        homing_velocity_multiplier = 0.86,
        detect_distance = 300,
        predefined_target = 0
      })
    ]]
  )
end

local function patch_forge_convert()
  local file = "data/scripts/buildings/forge_item_convert.lua"

  modifile(
    file,
    [[CreateItemActionEntity( "SUMMON_PORTAL", x, y)]],
    [[dofile("mods/noita.hardmod/files/modules/better_anvil/forge/repaired_spell.lua")(x, y)]]
  )

  dofile_once("data/scripts/gun/gun_actions.lua")
  ---@diagnostic disable-next-line: undefined-global
  for _,action in pairs(actions) do
    if action.id == "SUMMON_PORTAL" then
      action.spawn_probability = "0.5"
    end
  end

  modifile(
    file,
    [[data/entities/items/wand_level_05_better.xml]],
    [[data/entities/items/wand_unshuffle_05.xml]]
  )

  for broken_spell in nxml.edit_file("data/entities/items/pickup/summon_portal_broken.xml") do
    local icomp = broken_spell:first_of("ItemComponent")
    if icomp then
      icomp:set("preferred_inventory", "FULL")
      icomp:set("play_spinning_animation", "0")
    end

    local acomp = broken_spell:first_of("AbilityComponent")
    if acomp then
      broken_spell:remove_child(acomp)
      -- acomp:unset("throw_as_item")
    end

    broken_spell:set("tags", "hittable,teleportable_NOT,forgeable,card_summon_portal_broken")

    -- broken_spell:create_child("ItemActionComponent", {
    --   _enabled="0",
    --   _tags = "enabled_in_world",
    --   action_id = "",
    -- })
  end
  -- [[mods/noita.hardmod/files/modules/better_anvil/forge/repaired_wand.xml]]
end

patch_broken_wand()
patch_forge_convert()

return {}
