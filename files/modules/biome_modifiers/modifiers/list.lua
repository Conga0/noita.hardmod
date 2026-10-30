---@diagnostic disable: undefined-global

MaxBiomeModifierCount = { default = 5 }
BiomeModifierChances = { default = 0.3 }

PatchModifiers({
	FOG_OF_WAR_REAPPEARS = {
		ui_name = "$hardmod_biomemodifier_darkness",
		probability = 0,
	},
	PLANT_INFESTED = {
		remove_from_biomes = { "coalmine", "coalmine_alt" },
	},
	FOG_OF_WAR_CLEAR_AT_PLAYER = {
		ui_name = "$hardmod_biomemodifier_gloomy"
	},
	OMINOUS = { probability = 0.03 },
	PROTECTION_FIELDS = { probability = 0.032 },
})

AddBiomeGroup({ "wizardcave", "alchemist_secret" })
AddBiomeGroup({ "wizardcave", "alchemist_secret" })
AddBiomeGroup({ "sandcave" })
AddBiomeGroup({ "fungiforest" })
AddBiomeGroup({ "meat" })

ForcedBiomeModifiers.wandcave = "FOG_OF_WAR_REAPPEARS"
ForcedBiomeModifiers.wizardcave = "FOG_OF_WAR_REAPPEARS"
ForcedBiomeModifiers.alchemist_secret = "FOG_OF_WAR_REAPPEARS"
