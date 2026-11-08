function death(damage_type_bit_field, message, attacker, drop_items)
	local x,y = EntityGetTransform(GetUpdatedEntityID())
	SetRandomSeed(x-219, y+191873)
	for _=1, Random(3,5) do
		local eid = EntityLoad("data/entities/animals/rat.xml", x, y)
		EntityAddTag(eid,"felcesis_ignore")
		EntityAddComponent2(eid, "VariableStorageComponent", {_tags="no_gold_drop"})
		local dmc = EntityGetFirstComponent(eid, "DamageModelComponent")
		if dmc then ComponentSetValue2(dmc, "ragdoll_fx_forced", "DISINTEGRATED") end
	end
end