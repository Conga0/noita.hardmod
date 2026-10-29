---@diagnostic disable: undefined-global

local reworked_actions = {}

for _,action in pairs(actions) do
  if reworked_actions[action.id] then
    for k,v in pairs(reworked_actions[action.id]) do
      action[k] = v
    end

    action["hardmod_reworked"] = true
  end
end
