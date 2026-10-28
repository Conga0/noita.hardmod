local perks = {}
for _,perk in ipairs(dofile_once("mods/noita.hardmod/files/modules/enemy_perks/enemy_perks_list.lua")) do
	perks[perk.id] = perk
end

return perks