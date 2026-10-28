local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua")---@type nxml

ModLuaFileAppend("data/scripts/items/potion.lua", "mods/noita.hardmod/files/modules/potions/potion_appends.lua")

for file in nxml.edit_file("data/entities/items/pickup/potion_aggressive.xml") do
  local base = file:first_of("Base")
  if base then
    local sucker = base:first_of("MaterialSuckerComponent")
    if sucker then sucker:set("barrel_size", 2000) end

    local item = base:first_of("ItemComponent")
    if item then
      item:set("ui_description", "$hardmod_item_large_potion_desc")
    end
  end
end

modifile(
  "data/scripts/items/potion_aggressive.lua",
  [[AddMaterialInventoryMaterial( entity_id, potion.material, 1000 )]],
  [[AddMaterialInventoryMaterial( entity_id, potion.material, 2000 )]]
)

return {}
