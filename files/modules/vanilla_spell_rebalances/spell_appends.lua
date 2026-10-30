---@diagnostic disable: undefined-global

local function apply_freeze()
  if reflecting then return end

  local player = GetUpdatedEntityID()
  SetRandomSeed(GameGetFrameNum(), 123)
  if Random(1, 4) == 1 then
    local count = GameGetGameEffectCount(player, "INTERNAL_ICE")

    if count > 3 then
      local effect = GetGameEffectLoadTo(player, "FROZEN", true)
      ComponentSetValue2(effect, "lifetime", 100)
    else
      LoadGameEffectEntityTo(player, "mods/noita.hardmod/files/modules/vanilla_spell_rebalances/entities/effect_cold.xml")
    end
  end
end

local reworked_actions = {
  ["FREEZE"] = {
    mana = 20,
    action = function()
      apply_freeze()
      c.damage_ice_add = c.damage_ice_add + 0.2
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_frozen.xml,"
			c.extra_entities = c.extra_entities .. "data/entities/particles/freeze_charge.xml,"
			draw_actions(1, true)
    end
  },
  ["FREEZE_FIELD"] = {
    mana = 75,
    action = function ()
      apply_freeze()
      add_projectile("data/entities/projectiles/deck/freeze_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
    end
  }
}

for _,action in pairs(actions) do
  if reworked_actions[action.id] then
    for k,v in pairs(reworked_actions[action.id]) do
      action[k] = v
    end

    action["hardmod_reworked"] = true
  end
end
