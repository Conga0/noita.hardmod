
local _search = "shoot_projectile( entity_id, spell, pos_x, pos_y, vel_x, vel_y)"

modifile(
  "data/scripts/items/broken_wand_throw.lua",
  [[spell_amount = 18]], [[spell_amount = 27]]
)
modifile(
  "data/scripts/items/broken_wand_spells.lua",
  _search,
  "local thrown_projectile = " .. _search .. [[
    EntityAddComponent2(thrown_projectile, "HomingComponent", {
      _tags = "homing_projectile",
      homing_targeting_coeff = 130.0,
      homing_velocity_multiplier = 0.86,
      detect_distance = 300,
      predefined_target = 0
    })
  ]]
)

return {}
