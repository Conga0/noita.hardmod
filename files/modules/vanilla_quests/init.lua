local function patch_mimicium_quest()
  ModLuaFileAppend(
    "data/scripts/gun/gun_actions.lua",
    "mods/noita.hardmod/files/modules/vanilla_quests/appends/gun_actions.lua"
  )

  local mimic_reward = "data/biome_impl/static_tile/puzzle_logic_potion_mimics.lua"
  modifile(mimic_reward, "SEA_MIMIC", "HARDMOD_SEA_POISON")
  modifile(mimic_reward, "card_unlocked_sea_mimic", "card_unlocked_hardmod_sea_poison")

  modifile(
    "data/biome_impl/static_tile/chest_darkness.lua",
    [[AddFlagPersistent( "card_unlocked_touch_grass" )]],
    [[
      AddFlagPersistent( "card_unlocked_touch_grass" )

      CreateItemActionEntity("SEA_MIMIC", x + 5, y)
      AddFlagPersistent("card_unlocked_hardmod_sea_mimic")
    ]]
  )

  modifile(
    "data/scripts/animals/mimic_potion.lua",
    [[CreateItemActionEntity( "SEA_MIMIC", x, y )]],
    "" -- no free spell for u! Murderer!!!
  )
end

patch_mimicium_quest()

return {}
