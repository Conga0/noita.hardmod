CHEST_LEVEL = 0

RegisterSpawnFunction(0xffffeedd, "init")
RegisterSpawnFunction(0xff00ff2e, "spawn_book")

function spawn_book(x, y)
  -- TODO: i might add a lore book or something
  -- EntityLoad("", x, y)
end

function init(x, y)
  LoadPixelScene("mods/noita.hardmod/files/modules/biome_map/gfx/secret_lab_path.png", "", x, y, "", true)
end
