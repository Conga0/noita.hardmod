reworked_actions = {
	["X_RAY"] = {
        spawn_level         = "0,1,2,3,4,5,6",
        spawn_probability   = "0.4,0.6,0.7,0.8,1,0.8,0.7",
		max_uses            = 5,
		never_unlimited		= true,
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