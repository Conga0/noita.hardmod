if GameHasFlagRun("hardmod_hell") then
	local eid = GetUpdatedEntityID()

	EntityAddTag(eid, "polymorphable_NOT")
	GetGameEffectLoadTo(eid, "PROTECTION_POLYMORPH", false)
	GetGameEffectLoadTo(eid, "PROTECTION_FREEZE", false)
	GetGameEffectLoadTo(eid, "PROTECTION_ELECTRICITY", false)
end
