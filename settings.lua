dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "noita.hardmod" -- This should match the name of your mod's folder.
mod_settings_version = 1 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value.
mod_settings =
{
    {
        category_id = "limited_spells_settings",
        ui_name = "Truly Limited Spells",
        foldable = true,
        _folded = true,
        settings = {
            {
                id = "print_indulgence_cost",
                ui_name = "Print Indulgence cost",
                ui_description = "When enabled, casting the Indulgence spell will print\nits cost at the tip of your wand.",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "spawn_truly_unlimited_spells_test_package",
                ui_name = "[TEMP] Test Mode",
                ui_description = "For testing this module. Requires a new game.\n(REMOVE THIS SETTING BEFORE RELEASE)",
                value_default = false,
                scope = MOD_SETTING_SCOPE_NEW_GAME,
            },
        }
    }
}

function ModSettingsUpdate(init_scope)
    local old_version = mod_settings_get_version(mod_id)
    mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

-- This function is called to display the settings UI for this mod.
-- Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui( gui, in_main_menu )
    screen_width, screen_height = GuiGetScreenDimensions(gui)

    mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )

    local id = 46323
    local function new_id() id = id + 1; return id end

    GuiOptionsAdd( gui, GUI_OPTION.NoPositionTween )

    for i = 1, 5 do
        GuiText( gui, 0, 0, "" )
    end

    -- GuiLayoutEnd(gui)
end
