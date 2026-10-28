---@diagnostic disable: undefined-global

local function remove_materials(list, materials)
  local rm = {}
  for _,m in pairs(materials) do rm[m] = true end

  for idx=#list,1,-1 do
    if rm[list[idx].material] then
      table.remove(list, idx)
    end
  end
end

remove_materials(materials_magic, {
  -- "magic_liquid_unstable_teleportation",
  "magic_liquid_protection_all",
})

-- table.insert(materials_standard, {
--   material = "poison",
--   cost = 300
-- })
