local ability_id = GetUpdatedEntityID()
local host_id = EntityGetRootEntity(ability_id)
local brain_id = 0
local tier = 1

local children = EntityGetAllChildren(host_id) or {}
for _,child in ipairs(children) do
    if EntityGetName(child) == "felcesis_brain" then
        tier = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(child,"VariableStorageComponent"),"value_float") or 1
        break
    end
end

local vsc_comp = EntityGetFirstComponentIncludingDisabled(ability_id,"VariableStorageComponent") or 0
local damagetype = ComponentGetValue2(vsc_comp,"value_string")
local dmg_comp = EntityGetFirstComponentIncludingDisabled(host_id,"DamageModelComponent") or 0

local damage_mult = 0
if tier < 5 then
    --Only have 75% damage resistance until Ira is tier 6, at which point they gain full damage immunity against a given type
    damage_mult = 0.25
    local ui_comp = EntityGetFirstComponentIncludingDisabled(ability_id,"UIIconComponent")
    local ui_icon_filepath = ComponentGetValue2(ui_comp,"icon_sprite_file")
    ComponentSetValue2(ui_comp,"icon_sprite_file",ui_icon_filepath:gsub("protection_","protection_soft_"))
end
ComponentObjectSetValue2(dmg_comp,"damage_multipliers",damagetype,damage_mult)