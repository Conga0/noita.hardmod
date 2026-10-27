local orig_on_open = on_open
function on_open(entity)
  local x, y = EntityGetTransform(entity)
  orig_on_open(entity)

  CreateItemActionEntity("SEA_MIMIC", x + 10, y)
  AddFlagPersistent("card_unlocked_hardmod_sea_mimic")
end
