local nxml = dofile_once("mods/noita.hardmod/lib/nxml/nxml.lua") ---@type nxml

for file in nxml.edit_file("data/entities/animals/boss_centipede/sampo.xml") do
  local item = file:first_of("ItemComponent")
  if item then
    item:set("is_pickable", false)
  end

  for emitter in file:each_of("ParticleEmitterComponent") do
    if emitter:get("emitted_material_name") == "spark_blue" then
      emitter:set("emitted_material_name", "spark_white_bright")
      break
    end
  end

  local area_checker = file:first_of("MaterialAreaCheckerComponent")
  if area_checker then
    file:remove_child(area_checker)
  end

  local sprite = file:first_of("SpriteComponent")
  if sprite then
    sprite:set("image_file", "mods/noita.hardmod/files/modules/ending/gfx/sampo_sprite_locked.xml")
  end

  file:create_child("InteractableComponent", {
    _enabled = true,
    _tags = "enabled_in_world",
    ui_text = "-",
    name = "pickup_sampo",
    radius = 14.1
  })

  file:create_child("LuaComponent", {
    script_interacting = "mods/noita.hardmod/files/modules/ending/sampo_logic.lua",
    script_source_file = "mods/noita.hardmod/files/modules/ending/sampo_logic.lua",
    execute_every_n_frame = 120,
    execute_on_added = true,
  })
end

-- ModLuaFileAppend("data/entities/animals/boss_centipede/sampo_init.lua", "mods/noita.hardmod/files/modules/ending/appends/sampo_init.lua")

return {}
