function PatchEnemies(tbl, patches)
  for _,enemy in pairs(tbl) do
    if type(enemy) == "table" and enemy.entity then
      local patch = patches[enemy.entity]
      if patch then
        if patch.ng then enemy.ngpluslevel = patch.ng end
        if patch.prob then enemy.prob = patch.prob end
      end
    end
  end
end

function AddEnemies(tbl, spawns)
  for _,enemy in pairs(spawns) do
    table.insert(tbl, enemy)
  end
end
