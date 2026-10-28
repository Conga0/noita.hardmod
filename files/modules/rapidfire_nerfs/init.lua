local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml
local hooks = {}

local damage_nerfs = {
  ["chainsaw.xml"] = { slice = 0.4 },
  ["digger.xml"] = { drill = 0.2 },

  -- Already can't have any damage, just want to fix the lying tooltip
  -- (smh nolla)
  ["powerdigger.xml"] = { drill = nil },
}

for proj,nerfs in pairs(damage_nerfs) do
  for file in nxml.edit_file("data/entities/projectiles/deck/"..proj) do
    local dmg = file:first_of("ProjectileComponent"):first_of("damage_by_type")
    if dmg then
      for kind,value in pairs(nerfs) do dmg:set(kind, value) end
    end
  end
end

ModLuaFileAppend(
	"data/scripts/gun/gun_actions.lua",
	"mods/noita.hardmod/files/modules/rapidfire_nerfs/scripts/actions_append.lua"
)

return hooks
