new_actions = {
    {
        id                  = "HARDMOD_BLINK",
        name                = "$hardmod_spell_blink_name",
        description         = "$hardmod_spell_blink_desc",
        sprite              = "mods/noita.hardmod/files/modules/trial_perks/gfx/ui_gfx/spells/blink.png",
        type                = ACTION_TYPE_UTILITY,
        spawn_level         = "0",
        spawn_probability   = "0",
        spawn_requires_flag = "hardmod_time_trial_passed",
        price               = 400,
        mana                = 200,
        max_uses            = 3,
        never_unlimited     = true,
        action              = function()
                                c.fire_rate_wait = c.fire_rate_wait + 60
                                add_projectile( "mods/noita.hardmod/files/modules/trial_perks/entities/spells/blink.xml" )
                            end,
    },

    {
        id                  = "HARDMOD_PARRY",
        name                = "$hardmod_spell_parry_name",
        description         = "$hardmod_spell_parry_desc",
        sprite              = "mods/noita.hardmod/files/modules/trial_perks/gfx/ui_gfx/spells/parry.png",
        related_projectiles = { "mods/noita.hardmod/files/modules/trial_perks/entities/spells/parry.xml" },
        type                = ACTION_TYPE_STATIC_PROJECTILE,
        spawn_level         = "2,3,4", -- HEAL_BULLET
        spawn_probability   = "1,1,0.6", -- HEAL_BULLET
        price               = 220,
        mana                = 30,
        max_uses            = 30,
        never_unlimited     = true,
        action              = function()
                                c.fire_rate_wait = c.fire_rate_wait + 30
                                if reflecting then return end

                                add_projectile( "mods/noita.hardmod/files/modules/trial_perks/entities/spells/parry.xml" )
                            end,
    },
}

if actions ~= nil then
    for i=1, #new_actions do
        table.insert( actions, new_actions[i] )
    end
end
