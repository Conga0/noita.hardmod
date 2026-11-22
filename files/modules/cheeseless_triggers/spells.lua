local hooks = {}---@type spell_hooks

local sacrilege_blacklisted_spells = {
	ADD_TRIGGER = true,
	ADD_TIMER = true,
	ADD_DEATH_TRIGGER = true,
	HARDMOD_SACRILEGE = true,
}

hooks.new_spells = {
	{
		id = "HARDMOD_SACRILEGE",
		name = "$hardmod_spell_sacrilege_name",
		description = "$hardmod_spell_sacrilege_desc",
		sprite = "mods/noita.hardmod/files/modules/cheeseless_triggers/gfx/ui_gfx/spells/sacrilege.png",
		type = ACTION_TYPE_OTHER,
		spawn_level = "5,6,10",
		spawn_probability = "0.6,0.6,1",
		spawn_requires_flag = "card_unlocked_mestari",
		price = 400,
		mana = 80,
		action = function()
			-- original Add Trigger function (i.e. copies modifiers for free), except it doesn't add a trigger
			local data = deck[1]
			local how_many = 1

			if not data then return end

			while #deck >= how_many and data and (data.type == ACTION_TYPE_MODIFIER or data.type == ACTION_TYPE_PASSIVE or data.type == ACTION_TYPE_OTHER or data.type == ACTION_TYPE_DRAW_MANY) do
				if data.uses_remaining or data.uses_remaining ~= 0 and not sacrilege_blacklisted_spells[data.id] then
					if data.type == ACTION_TYPE_MODIFIER then
						dont_draw_actions = true
						data.action()
						dont_draw_actions = false
					end
				end

				how_many = how_many + 1
				data = deck[how_many]
			end

			if not data or not data.related_projectiles then return end
			if data.uses_remaining and data.uses_remaining == 0 then return end

			local target = data.related_projectiles[1]
			local count = data.related_projectiles[2] or 1

			for _=1,how_many do
				data = deck[1]
				table.insert(discarded, data)
				table.remove(deck, 1)
			end

			local valid = false
			for _,check in pairs(deck) do
				if check and (check.type == ACTION_TYPE_PROJECTILE or check.type == ACTION_TYPE_STATIC_PROJECTILE or check.type == ACTION_TYPE_MATERIAL or check.type == ACTION_TYPE_UTILITY) then
					valid = true
					break
				end
			end

			if data.uses_remaining and data.uses_remaining > 0 then
				data.uses_remaining = data.uses_remaining - 1

				local reduce_uses = ActionUsesRemainingChanged(data.inventoryitem_id, data.uses_remaining)
				if not reduce_uses then
					data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
				end
			end

			if valid then
				for _=1,count do
					add_projectile(target)
				end
			else
				dont_draw_actions = true
				data.action()
				dont_draw_actions = false
			end
		end,
	},
}

local function add_trigger(type)
	local last = trigger_queue[#trigger_queue]
	if last and last.type == type then
		last.draw_count = last.draw_count + 1
	else
		local trigger = { type = type, draw_count = 1 }
		if type == TRIGGER_TIMER then
			trigger.delay_frames = 20
		end
		table.insert(trigger_queue, trigger)
	end

	draw_actions(1, true)
end

hooks.spell_patches = {
	["ADD_TRIGGER"] = {
		type = ACTION_TYPE_MODIFIER,
		description = "$hardmod_spell_add_trigger_desc",
		action = function() add_trigger(TRIGGER_HIT_WORLD) end,
	},
	["ADD_TIMER"] = {
		type = ACTION_TYPE_MODIFIER,
		description = "$hardmod_spell_add_timer_desc",
		action = function() add_trigger(TRIGGER_TIMER) end,
	},
	["ADD_DEATH_TRIGGER"] = {
		type = ACTION_TYPE_MODIFIER,
		description = "$hardmod_spell_add_death_trigger_desc",
		action = function() add_trigger(TRIGGER_DEATH) end,
	},
}

-- mana = 20,
-- spawn_level = "1,2,3,4,5,6" -- very rare early spawns because they are just fun spells
-- spawn_probability = "0.05,0.1,0.2,0.3,0.4,0.4"

return hooks
