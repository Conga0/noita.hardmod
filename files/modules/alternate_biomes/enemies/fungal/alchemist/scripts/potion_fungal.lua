dofile_once("data/scripts/lib/utilities.lua")

local potions = {
	"blood_fungi",
	"blood_fungi",
	"fungi",
	"fungisoil",
	"fungus_powder_bad",
	"fungal_gas",
}

function init(entity_id)
	local x, y = EntityGetTransform(entity_id)
	SetRandomSeed(x + GameGetFrameNum(), y)
	AddMaterialInventoryMaterial(entity_id, random_from_array(potions), 1000)
end
