---@diagnostic disable: undefined-global

dofile_once("data/scripts/biome_modifiers.lua")
dofile_once("mods/noita.hardmod/files/modules/biome_modifiers/biome_table.lua")

last_active_biome = "_EMPTY_"
get_modifier_mappings()
GetBiomeTable(biomes)

local function get_effect(player)
  local effect = EntityGetAllChildren(player, "hardmod_biomemodifier_status")
  if not effect or #effect < 1 then return nil end
  return effect[1]
end

function biome_entered(biome_name)
  local player = GetUpdatedEntityID()
  local effect = get_effect(player)

  if not effect then
    print_error("Missing biome modifier status entity!!")
    return
  end

  if last_active_biome == biome_name then return end
  last_active_biome = biome_name

  local icon = EntityGetFirstComponentIncludingDisabled(effect, "UIIconComponent")
  local biome_id = biome_ui_names[biome_name]
  local modifiers = BiomesWithModifiers[biome_id]

  if biome_name == "_EMPTY_" or not biome_id or not modifiers or #modifiers < 1 then
    if icon then EntityRemoveComponent(effect, icon) end
    return
  end

  local lines = {}
  for _,modifier in pairs(modifiers) do
    local name = modifier.ui_name or ("$hardmod_biomemodifier_"..string.lower(modifier.id))
    table.insert(lines, GameTextGetTranslatedOrNot(name))
  end

  local list = table.concat(lines, "\n")

  if not icon then
    icon = EntityAddComponent2(effect, "UIIconComponent", {
      _enabled = true,
      name = " ",
      description = " ",
      icon_sprite_file = "data/ui_gfx/status_indicators/ingestion_freezing.png"
    })
  end

  ComponentSetValue2(
    icon, "description",
    GameTextGet("$hardmod_biomemodifier_status_desc").."\n"..list
  )
end
