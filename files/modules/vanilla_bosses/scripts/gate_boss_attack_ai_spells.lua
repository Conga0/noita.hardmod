--This is the list of spells the boss can use, projectiles are in 'modules/vanilla_bosses/entity/gate_boss_projectiles/'
--Make sure the xml file name lines up with their spell icon name
function GetSpellAttackListing()
	return {
	-- Spell Name, Min/Max Speed, Phasing, Projectile Type ("static","healing") healing not currently implemented
	{ "light_bullet", { 750, 850 }, true, "normal" },
	}
end