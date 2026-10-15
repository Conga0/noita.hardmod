local perks = {
	{
		id = "TEST_PERK",
		name = "$hardmod_enemy_perks_test",
		description = "Wow, what a great test perk!",
		weight = 10,
		--condition = function(self, data) end,
		func = function(self, holder, perk_entity)
			--GetGameEffectLoadTo(holder, "REGENERATION", true)
		end
	}
}

for _,perk in ipairs(perks) do
	perk.name = perk.name or perk.id
	perk.weight = perk.weight or 10
	perk.icon = ModDoesFileExist(perk.icon or "") and perk.icon or "mods/noita.hardmod/files/modules/enemy_perks/perk_sprites/missing.png"
end

return perks