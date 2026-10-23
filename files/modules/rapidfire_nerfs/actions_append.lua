reworked_actions = {
	["CHAINSAW"] = {
        sprite              = "mods/noita.hardmod/files/modules/rapidfire_nerfs/chainsaw.png",
        spawn_level         = "6,10",
        spawn_probability   = "0.2,1",
        price               = 160,
        mana                = 12,
        action              = function()
                                add_projectile( "data/entities/projectiles/deck/chainsaw.xml" )
                                c.fire_rate_wait = c.fire_rate_wait * 0.5
                                c.spread_degrees = c.spread_degrees + 6.0
                                current_reload_time = current_reload_time - 10
                            end,
	},
}

new_actions = {
    {
        id                  = "HARDMOD_MINI_CHAINSAW",
        name                = "$hardmod_spell_mini_chainsaw_name",
        description         = "$hardmod_spell_mini_chainsaw_desc",
        sprite              = "mods/noita.hardmod/files/modules/rapidfire_nerfs/mini_chainsaw.png",
        related_projectiles = { "data/entities/projectiles/deck/chainsaw.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,2",
        spawn_probability   = "1,1",
        price               = 80,
        mana                = 1,
        sound_loop_tag      = "sound_chainsaw",
        action              = function()
                                add_projectile( "data/entities/projectiles/deck/chainsaw.xml" )
                                c.spread_degrees = c.spread_degrees + 6.0
                                current_reload_time = current_reload_time - 10
                            end,
    },
}

for i=1,#actions do
    if reworked_actions[actions[i].id] then
        for k,v in pairs( reworked_actions[actions[i].id] ) do
            actions[i][k] = v
        end
        actions[i]['hardmod_reworked'] = true
    end
end

if actions ~= nil then
    for i=1, #new_actions do
        table.insert( actions, new_actions[i] )
    end
end
