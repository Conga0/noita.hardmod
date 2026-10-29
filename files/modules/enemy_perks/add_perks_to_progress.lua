local enemy_perks = dofile_once("mods/noita.hardmod/files/modules/enemy_perks/enemy_perks_list.lua")


for _,perk in ipairs(enemy_perks) do
	local not_progress
	if perk.name:sub(1,1) ~= "$" then
		print("PERK [" .. perk.id .. "] NOT ADDED TO PROGRESS, NAME IS NOT TRANSLATION")
		not_progress = true
	elseif perk.not_progress then
		not_progress = true
	end

	if not not not not_progress then
		local perk_id = "enemyperk_hardmod_" .. perk.id

		RegisterPerk(
			perk_id,
			perk.name,
			GameTextGetTranslatedOrNot(perk.description) or "",
			perk.icon,
			perk.icon
		)
	end
end