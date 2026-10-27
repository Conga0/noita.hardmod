ModLuaFileAppend("data/scripts/items/potion.lua", "mods/noita.hardmod/files/modules/potions/potion_appends.lua")

modifile(
  "data/scripts/items/potion_aggressive.lua",
  [[AddMaterialInventoryMaterial( entity_id, potion.material, 1000 )]],
  [[AddMaterialInventoryMaterial( entity_id, potion.material, 500 )]]
)

return {}
