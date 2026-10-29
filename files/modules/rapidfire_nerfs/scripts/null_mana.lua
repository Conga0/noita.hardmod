-- i dont like copypaste
function HardmodActionNullMana(cast)
  cast = cast or c

  cast.damage_null_all = 1

  cast.damage_electricity_add = 0
  cast.damage_explosion_add = 0
  cast.damage_explosion = 0
  cast.damage_critical_chance = 0
  cast.damage_ice_add = 0
  cast.damage_projectile_add = 0
  cast.damage_critical_chance = 0
  cast.damage_healing_add = 0
  cast.gore_particles = 0

  cast.extra_entities = cast.extra_entities .. "data/entities/particles/tinyspark_white_small.xml,data/entities/misc/zero_damage.xml,"
  cast.hardmod_null_mana = true
end

local function apply_null_mana(from, to)
  if not from or from == to then return end
  if from.hardmod_null_mana and not to.hardmod_null_mana then
    HardmodActionNullMana(to)
  end
end

local previous_draw_shot = draw_shot
function draw_shot(shot, instant_reload_if_empty)
  apply_null_mana(c, shot.state)
	previous_draw_shot(shot, instant_reload_if_empty)
  apply_null_mana(shot.state, c)
end
