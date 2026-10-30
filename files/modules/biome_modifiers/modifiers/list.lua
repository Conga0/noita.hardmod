---@diagnostic disable: undefined-global

MaxBiomeModifierCount = { default = 5 }
BiomeModifierChances = { default = 0.3 }

PatchModifiers({
	FREEZING = {
		probability = 0.4
	},
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
	INVISIBILITY = { probability = 0.05 },
	PROTECTION_FIELDS = { probability = 0.03 },
	OMINOUS = { probability = 0.02 },
})

AddBiomeGroup({ "wizardcave", "alchemist_secret" })
AddBiomeGroup({ "wizardcave", "alchemist_secret" })
AddBiomeGroup({ "sandcave" })
AddBiomeGroup({ "fungiforest" })
AddBiomeGroup({ "meat" })

ForcedBiomeModifiers.wandcave = { id = "FOG_OF_WAR_REAPPEARS", prob = 0.5 }
ForcedBiomeModifiers.wizardcave = { id = "FOG_OF_WAR_REAPPEARS", prob = 0.5 }
ForcedBiomeModifiers.alchemist_secret = { id = "FOG_OF_WAR_REAPPEARS", prob = 0.5 }
ForcedBiomeModifiers.snowcave = "FREEZING"
