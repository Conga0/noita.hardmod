return function(hooks)
    hooks.pre_processing[#hooks.pre_processing+1] = {
        id = "hardmod_blood_money_scaling",
        func = function(nugget, data)
            if nugget.group == "blood" then
                nugget.heal_amount = nugget.value * 0.002
            end
        end
    }
end