local mana_reducing_spells = { "MANA_REDUCE", "HARDMOD_MANA_REDUCE", "APOTHEOSIS_WATER_POWER" }
local materials = { "MATERIAL_WATER", "MATERIAL_OIL", "MATERIAL_BLOOD", "MATERIAL_CEMENT" }

reworked_actions = {
	["CHAINSAW"] = {
        spawn_level       = "3,4,5,6,10",
        spawn_probability = "0.7,0.8,0.9,1,1",
        price             = 160,
        mana              = 12,
	},
    ["MANA_REDUCE"] = {
        spawn_level       = "3,4,5,6,10",
		spawn_probability = "0.7,0.8,0.9,1,1",
        price             = 160,
        mana              = -15,
    },
    ["HEAVY_SPREAD"] = {
        mana = 6
    },
    ["APOTHEOSIS_WATER_POWER"] = {
        description         = "$hardmod_spell_apotheosis_water_power_desc",
        mana                = 0,
        -- custom_xml_file     = "mods/noita.hardmod/files/modules/rapidfire_nerfs/entities/card_apotheosis_water_power.xml",
        action              = function()
                                draw_actions( 1, true )

                                if reflecting or GameGetGameEffectCount( GetUpdatedEntityID(), "WET" ) > 0 then
                                    c.fire_rate_wait    = c.fire_rate_wait - 10
                                    current_reload_time = current_reload_time - 20

                                    local ctrlcomp = EntityGetFirstComponentIncludingDisabled( GetUpdatedEntityID(), "ControlsComponent" )
                                    if ctrlcomp then
                                        local fire_frame = ComponentGetValue2( ctrlcomp, "mButtonFrameFire" )
                                        local current_frame = GameGetFrameNum()

                                        local frames_firing = current_frame - fire_frame
                                        local burst_duration = 20
                                        local max_restore = 0
                                        if frames_firing < burst_duration then
                                            max_restore = ( ( 50 / burst_duration ) * ( burst_duration - frames_firing ) )
                                        end

                                        local hand_cost = 0
                                        local mana_reducing_spell_count = 1
                                        for i,v in ipairs( hand ) do
                                            if v.mana ~= nil then
                                                hand_cost = hand_cost + v.mana
                                            end
                                            for i,id in ipairs( mana_reducing_spells ) do
                                                if id == v.id then
                                                    mana_reducing_spell_count = mana_reducing_spell_count + 1
                                                end
                                            end
                                        end
                                        hand_cost = hand_cost / mana_reducing_spell_count

                                        local restore = math.min( hand_cost, max_restore )
                                        mana = mana + restore
                                    end
                                end
                            end,
    },
}

new_actions = {
    {
        id                  = "HARDMOD_MANA_REDUCE",
        name                = "$action_mana_reduce",
        description         = "$hardmod_spell_mana_reduce_desc",
        sprite              = "mods/noita.hardmod/files/modules/rapidfire_nerfs/ui_gfx/add_mana.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "2,3,4,5,6",
		spawn_probability   = "0.9,1,1,1,1",
        price               = 250,
        mana                = 0,
        -- custom_xml_file     = "mods/noita.hardmod/files/modules/rapidfire_nerfs/entities/card_mana_reduce.xml",
        action              = function()
                                draw_actions( 1, true )

                                local ctrlcomp = EntityGetFirstComponentIncludingDisabled( GetUpdatedEntityID(), "ControlsComponent" )
                                if ctrlcomp then
                                    local fire_frame = ComponentGetValue2( ctrlcomp, "mButtonFrameFire" )
                                    local current_frame = GameGetFrameNum()

                                    local frames_firing = current_frame - fire_frame
                                    local burst_duration = 20
                                    local max_restore = 0
                                    if frames_firing < burst_duration then
                                        max_restore = ( ( 50 / burst_duration ) * ( burst_duration - frames_firing ) )
                                    end

                                    local hand_cost = 0
                                    local mana_reducing_spell_count = 1
                                    for i,v in ipairs( hand ) do
                                        if v.mana ~= nil then
                                            hand_cost = hand_cost + v.mana
                                        end
                                        for i,id in ipairs( mana_reducing_spells ) do
                                            if v.id == id then
                                                mana_reducing_spell_count = mana_reducing_spell_count + 1
                                            end
                                        end
                                    end
                                    hand_cost = hand_cost / mana_reducing_spell_count

                                    local restore = math.min( hand_cost, max_restore )
                                    mana = mana + restore
                                end
                            end,
    },
    {
        id                  = "HARDMOD_MINI_CHAINSAW",
        name                = "$hardmod_spell_mini_chainsaw_name",
        description         = "$hardmod_spell_mini_chainsaw_desc",
        sprite              = "mods/noita.hardmod/files/modules/rapidfire_nerfs/ui_gfx/mini_chainsaw.png",
        related_projectiles = { "data/entities/projectiles/deck/chainsaw.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,2",
        spawn_probability   = "1,1",
        price               = 80,
        mana                = 6,
        sound_loop_tag      = "sound_chainsaw",
        action              = function()
                                add_projectile( "data/entities/projectiles/deck/chainsaw.xml" )
                                c.fire_rate_wait = c.fire_rate_wait * 0.5
                                c.spread_degrees = c.spread_degrees + 6.0
                                current_reload_time = current_reload_time - 10
                            end,
    },
    {
        id                  = "HARDMOD_SPELL_MANA_REGEN",
        name                = "$hardmod_spell_mana_regen_name",
        description         = "$hardmod_spell_mana_regen_desc",
        sprite              = "mods/noita.hardmod/files/modules/rapidfire_nerfs/ui_gfx/mana_regen.png",
        type                = ACTION_TYPE_PASSIVE,
        spawn_level         = "1,2,3,4,5,6", -- MANA_REDUCE
        spawn_probability   = "0.7,0.9,1,1,1,1", -- MANA_REDUCE
        price               = 100,
        mana                = 0,
        custom_xml_file     = "mods/noita.hardmod/files/modules/rapidfire_nerfs/entities/card_mana_regen.xml",
        action              = function()
                                draw_actions( 1, true )
                            end,
    },
}

for _,material in pairs(materials) do
    reworked_actions[material] = {
        mana = 8
    }
end

for _,action in pairs(actions) do
    if reworked_actions[action] then
        for k,v in pairs(reworked_actions[action]) do
            action[k] = v
        end

        action["hardmod_reworked"] = true
    end
end

for _,action in pairs(new_actions) do
    table.insert(actions, action)
end
