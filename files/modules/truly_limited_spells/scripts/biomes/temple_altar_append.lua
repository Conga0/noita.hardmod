
local _spawn_all_shopitems = spawn_all_shopitems
function spawn_all_shopitems( x, y )
	_spawn_all_shopitems( x, y )

	GamePrint( "indulgence spawned (1/2)" )
	EntityLoad( "mods/noita.hardmod/files/modules/truly_limited_spells/entities/misc/indulgence_spawner.xml", x + 64, y )
end