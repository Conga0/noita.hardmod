local vsc_name = "hardmod_wand_experimenter_state"
local invalid_state = "tinkered"

function GetNewWandState(wand)
  local spells = {}

  for _,child in pairs(EntityGetAllChildren(wand) or {}) do
    local comp = EntityGetFirstComponentIncludingDisabled(child, "ItemActionComponent")
    if comp then
      local id = ComponentGetValue2(comp, "action_id")
      table.insert(spells, id)

      if #spells >= 26 then return invalid_state end
    end
  end

  return "spells:" .. table.concat(spells, ",")
end

---@return string?
function GetStoredWandState(wand)
  local vsc = EntityGetComponent(wand, "VariableStorageComponent") or {}
  for _,comp in pairs(vsc) do
    if ComponentGetValue2(comp, "name") == vsc_name then
      return ComponentGetValue2(comp, "value_string")
    end
  end
end

function StoreWandState(wand, value)
  local vsc = EntityGetComponent(wand, "VariableStorageComponent") or {}
  for _,comp in pairs(vsc) do
    if ComponentGetValue2(comp, "name") == vsc_name then
      ComponentSetValue2(comp, "value_string", value)
      return
    end
  end

  EntityAddComponent2(wand, "VariableStorageComponent", {
    _tags = "enabled_in_hand,enabled_in_inventory",
    name = vsc_name,
    value_string = value,
    value_int = 0
  })
end

function MarkWandAsTinkered(wand)
  StoreWandState(wand, invalid_state)
end

function IsWandStateInvalid(old_state, new_state)
  return new_state == invalid_state or (
    old_state and (old_state == invalid_state or old_state ~= new_state)
  )
end
