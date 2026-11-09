local entity_id = GetUpdatedEntityID()
local amount = 600
local storage = EntityGetFirstComponent(entity_id, "VariableStorageComponent", "fungal_inventory")
if storage ~= nil then
	amount = ComponentGetValue2(storage, "value_int")
end
AddMaterialInventoryMaterial(entity_id, "radioactive_liquid", 0)
AddMaterialInventoryMaterial(entity_id, "acid", 0)
AddMaterialInventoryMaterial(entity_id, "blood_fungi", amount)
