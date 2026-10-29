local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml
local deck = "data/entities/projectiles/deck/"

local damage_nerfs = {
  ["chainsaw.xml"] = { slice = 0.4 },
  ["digger.xml"] = { drill = 0.2 },

  -- Already can't have any damage, just want to fix the lying tooltip
  -- (smh nolla)
  ["powerdigger.xml"] = { drill = nil },
}

for proj,nerfs in pairs(damage_nerfs) do
  for file in nxml.edit_file(deck..proj) do
    local dmg = file:first_of("ProjectileComponent"):first_of("damage_by_type")
    if dmg then
      for kind,value in pairs(nerfs) do dmg:set(kind, value) end
    end
  end
end

-- Evil and fucked up damage
local lasers = {
  "orb_laseremitter_cutter.xml",
  "orb_laseremitter_four.xml",
  "orb_laseremitter_cutter.xml",
}

for _,proj in pairs(lasers) do
  for file in nxml.edit_file(deck..proj) do
    local pcomp = file:first_of("ProjectileComponent")
    if pcomp then
      pcomp:set("damage", 0)
      pcomp:set("damage_every_x_frames", 15)
    end

    for emitter in file:each_of("LaserEmitterComponent") do
      local laser = emitter:first_of("laser")
      if laser then
        laser:set("damage_to_entities", 0.005)
      end
    end
  end
end

return {
  new_eid = function (eid)
    if not EntityHasTag(eid, "enemy") then return end

    local dmc = EntityGetComponent(eid, "DamageModelComponent")
    if not dmc then return end

    for _,comp in pairs(dmc) do
      -- :)
      ComponentObjectSetValue2(comp, "damage_multipliers", "physics_hit", 0.001)
    end
  end
}
