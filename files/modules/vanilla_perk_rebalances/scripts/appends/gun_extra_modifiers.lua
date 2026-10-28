---@diagnostic disable: undefined-global

extra_modifiers.lower_spread = function ()
  c.spread_degrees = c.spread_degrees - 5
  c.damage_projectile_add = c.damage_projectile_add + 0.2
  c.fire_rate_wait   = c.fire_rate_wait + 5
  shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
end
