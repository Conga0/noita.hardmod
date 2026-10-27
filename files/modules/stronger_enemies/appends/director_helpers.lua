local ng_offset = 1

function check_newgame_plus_level(level)
  local ng = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) or 0
  return (ng + ng_offset) >= level
end
