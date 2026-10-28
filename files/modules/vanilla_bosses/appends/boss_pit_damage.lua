dofile_once("mods/noita.hardmod/lib/utilities.lua")

local orig_damage_received = damage_received
local delay_frames = 10

function damage_received(...)
  local eid = GetUpdatedEntityID()

  local frame = GameGetFrameNum()
  local last = GetInternalInt(eid, "last_dmg_at") or 0

  if frame - last < delay_frames then
    return
  end

  SetInternalInt(eid, "last_dmg_at", frame)
  orig_damage_received(...)
end
