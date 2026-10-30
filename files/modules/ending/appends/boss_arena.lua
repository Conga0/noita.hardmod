local orig_spawn_items = spawn_items
function spawn_items(x, y, ...)
  orig_spawn_items(x, y, ...)

  -- print(x..", "..y)
  -- print((3401-x)..", "..(13036-y))
  EntityLoad("mods/noita.hardmod/files/modules/ending/entities/book_hint.xml", x - 145, y - 40)
end
