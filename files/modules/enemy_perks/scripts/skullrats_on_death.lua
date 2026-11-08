function death(damage_type_bit_field, message, attacker, drop_items)
	local x,y = EntityGetTransform(GetUpdatedEntityID())
	SetRandomSeed(x-219, y+191873)
	for _=1, Random(2,4) do
		local eid = EntityLoad("data/entities/animals/skullrat.xml", x, y)
		EntityAddTag(eid,"felcesis_ignore")
	end
end
