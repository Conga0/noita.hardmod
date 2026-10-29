local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

local mists = { "slime", "alcohol", "blood", "radioactive" }

for _,mist in pairs(mists) do
  for file in nxml.edit_file("data/entities/projectiles/deck/mist_"..mist..".xml") do
    local proj = file:first_of("ProjectileComponent")
    if proj then
      -- todo idk
      proj:set("lifetime", 200)
      proj:set("damage_every_x_frames", 30)
      proj:set("collide_with_world", true)
    end
  end
end

for file in nxml.edit_file("data/entities/projectiles/deck/base_field.xml") do
  local proj = file:first_of("ProjectileComponent")
  if proj then
    proj:set("collide_with_world", true)
    proj:set("damage_every_x_frames", 30)
  end

  local lifetime = file:first_of("LifetimeComponent")
  if lifetime then
    lifetime:set("lifetime", 600)
  end
end

ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/noita.hardmod/files/modules/vanilla_spell_rebalances/spell_appends.lua")

return {}
