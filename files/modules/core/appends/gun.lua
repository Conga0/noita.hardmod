local do_global_stats = not ModSettingGet("noita.hardmod.cheeseless_triggers.disabled")

--[[ Global Stats ]]--
--#region

local null_shot_nullify = {
	"damage_electricity_add", "damage_explosion_add", "damage_explosion",
	"damage_critical_chance", "damage_ice_add", "damage_projectile_add",
	"damage_critical_chance", "damage_healing_add", "gore_particles",
}

---@param from ShotState
---@param to ShotState
local function apply_global_stats(from, to)
	if not from or from == to then return end

	if do_global_stats then
		to.fire_rate_wait = from.fire_rate_wait
		to.spread_degrees = from.spread_degrees
	end

	if from.global_null_shot and not to.global_null_shot then
		to.damage_null_all = 1
		for _,key in pairs(null_shot_nullify) do
			to[key] = 0
		end

		to.extra_entities = to.extra_entities.."data/entities/particles/tinyspark_white_small.xml,data/entities/misc/zero_damage.xml,"
		to.global_null_shot = true
	end
end

local old_draw_shot = draw_shot

---@param shot Shot
function draw_shot(shot, instant_reload_if_empty)
	apply_global_stats(c, shot.state)
	old_draw_shot(shot, instant_reload_if_empty)
	apply_global_stats(shot.state, c)
end

--#endregion

--[[ Custom Triggers ]]--
--#region

---@alias TriggerType 1|2|3
---@class QueuedTrigger
---@field type TriggerType
---@field draw_count integer
---@field delay_frames integer?

---@type QueuedTrigger[]
trigger_queue = {}

TRIGGER_HIT_WORLD = 1
TRIGGER_TIMER = 2
TRIGGER_DEATH = 3

function add_projectile(file)
	if reflecting then Reflection_RegisterProjectile(file) return end

	BeginProjectile(file)

	if #trigger_queue > 0 then
		local todo = trigger_queue
		trigger_queue = {}

		for _,trigger in pairs(todo) do
			if trigger.type == TRIGGER_HIT_WORLD then BeginTriggerHitWorld()
			elseif trigger.type == TRIGGER_TIMER then BeginTriggerTimer(trigger.delay_frames)
			elseif trigger.type == TRIGGER_DEATH then BeginTriggerDeath()
			end

			draw_shot(create_shot(trigger.draw_count), true)
			EndTrigger()
		end
	end

	EndProjectile()
end

---@param file string
---@param trigger QueuedTrigger
local function add_projectile_with_trigger(file, trigger)
	if reflecting then Reflection_RegisterProjectile(file) return end

	table.insert(trigger_queue, trigger)
	add_projectile(file)
end

function add_projectile_trigger_hit_world(file, draws)
	add_projectile_with_trigger(file, {
		type = TRIGGER_HIT_WORLD,
		draw_count = draws
	})
end

function add_projectile_trigger_death(file, draws)
	add_projectile_with_trigger(file, {
		type = TRIGGER_DEATH,
		draw_count = draws
	})
end

function add_projectile_trigger_timer(file, delay_frames, draws)
	add_projectile_with_trigger(file, {
		type = TRIGGER_TIMER,
		draw_count = draws,
		delay_frames = delay_frames
	})
end

--#endregion
