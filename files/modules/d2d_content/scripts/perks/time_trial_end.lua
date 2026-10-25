dofile_once( "mods/noita.hardmod/files/modules/d2d_content/scripts/trial_perk_utils.lua" )

local player = EntityGetRootEntity( GetUpdatedEntityID() )
SetInternalInt( player, "hardmod_time_trail_start_y", 0 )

GamePrintImportant( "You failed the Time Trial..." )
EntityRemoveAllByTag( player, "hardmod_time_trial" )
SwapPerkIconForSpent( player, "$hardmod_perk_time_trial_name", false )
SetInternalInt( player, "hardmod_time_trial_start_y", 0 )

