reworked_actions = {
	["X_RAY"] = {
		max_uses            = 3,
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