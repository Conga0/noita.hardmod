A Noita Community Mod Collaboration! Following the Noita Fair Mod, this mod intends to make the game more difficult/challenging.

(Note that this does NOT mean adding memey bullshit or otherwise making the game more frustrating, this isn't Fairmod! The difficulty should ideally be fun and engaging.)


<ins>Development has officially begun as of October 1st</ins> and the mod will be released midnight after Halloween, or Novermber 1st 00:00 (you can still further develop/work on the mod post-release).

# Implemented Features
- `nerfed_combat_healing`
  - On taking damage, you gain a healblock status effect
  - For every 1% of max health you take as damage, you gain 2 seconds of wounded up to a maximum of 10 seconds from a single instance of damage
  - As you continually take more damage, the wounded timer you have can grow up to a maximum of 60 seconds, at which point it cannot be risen any higher
- `phantom_nemesis`
  - A phantom is haunting you and will possess nearby enemies, granting them powerful abilities in order to drag you into the grave with them.
  - The Phantom is named Ira and will grow stronger with each biome you visit, they will take the situation & previous encounters into consideration when selecting abilities to grant their next host in order to best slay you.
  - You have a 3 minute grace period before Ira begins haunting you, after which Ira will continually possess a new target every minute to hunt you down; however Ira will stop haunting you briefly if you banish them by killing their host, this grace period timer after each kill also grows longer with each biome you visit.
  - Ira can be banished instantly by charming their host with pheromones but this will anger Ira greatly and you may have a harder time fending them off in future encounters.
- `truly_limited_spells`
  - The Unlimited Spells perk has been removed.
  - A new perk gives enemies a chance to drop "spell gems", which restore a few spell charges on pickup.
  - Greek spells are now (by default) limited to 30 uses.
  - Two new late-game spells allow you to cast limited spells with 0 remaining charges.
  - More info: [readme.md](files/modules/truly_limited_spells/readme.md)
- `vanilla_perk_rebalances`
  - All-Seeing Eye (perk) now grants vision around the cursor only, rather than lighting up the entire screen.
  - All-Seeing Eye (spell) is now less common early, and has fewer uses.
  - Most Immunity perks have been reworked into Protection perks, halving damage taken by the corresponding damage type. These perks now stack up to 3 times, for a total damage reduction of up to 87.5%.
  - Exploding Corpses and Oil Blood now also grant explosion/fire protection, rather than immunity.
  - Stainless Armour and Permanent Shield can now be stacked a maximum of 3 times each.
  - Added a new item, "Petrified Cheese". Holding it gives you melee immuniuty. It can spawn on item pedestals or drop from chests.
  - Adds a new perk "Amplified Items". This perk lets you get some immunities from having stones in your inventory (fire immunity, electricity immunity and melee immunity)
- `chest_tweaks`
  - Adds more drops to chests/GTCs. Some of them are good, some of them are dangerous
  - Adds the "Better Chests" perk which makes chests contain more loot
  - Adds the "Treasure Hunter" perk which gives more gold to chests
  - Removes the "Summon Sädekivi" perk; chests can now drop that item instead
  - Makes great treasure chests much better
  - Adds an uncommon Healthy Extra HP dropped from chests, which increases your max HP by 25 and heals you by the same amount
- `better_anvil`
  - Hiisi Anvil has been moved! You now have to explore the Hiisi Base a bit to find it.
  - In the old place in the bottom right there is a book hinting at the general location of the anvil, so you don't have to search everything
  - Reforging a broken tablet at the anvil now guarantees a good non-shuffle wand
  - Broken Spell has been repurposed: you can now find it on item pedestals, and reforge it on the anvil for random good spells
  - You can put broken spells in your spell inventory to save space
  - Additionally, you can now use Broken Wands as a weapon early game - their projectiles will home onto enemies (they still hurt you, though, so watch out!)
- `no_more_max_hp_cheesing`
  - The heart mage's spell now temporarily causes you to lose max HP equal to 50% of the damage you take. This max HP is not restored afterwards.
  - Changed Matosade's related_projectiles to spawn a small worm, instead of a big one.
- `splash_text`
  - Pause menu will have a random splash message on it
- `cheeseless_triggers`
  - Trigger spells pay their payload's cast delay
  - `Add Trigger`, `Add Timer` and `Add Death Trigger` don't give free modifiers anymore and properly applies spell's cast delay
- `rapidfire_nerfs`
  - Chainsaw now appears much later, and costs 12 mana to cast.
  - Add Mana now restores only 15 mana, and appears later & rarer
  - A new spell called Mini Chainsaw replaces the original spawns, which costs 6 mana and halves cast delay instead of setting it to 0.
  - A new spell called Mana Burst restores less mana the longer you hold the fire button, working in bursts only
  - A new spell called Mana Regen restores 12% of a wand's max mana per second, intended to make high mana, low charge speed wands more usable.
- `trappier_traps`
  - Made a bunch of the box traps unkickable.
  - Wall traps shotgun projectiles.
- `worse_hearts`
  - Holy mountain hearts no longer grant health increase
- `no_more_max_hp_cheesing`
  - The heart mage's spell now temporarily causes you to lose max HP equal to 50% of the damage you take. This max HP is not restored afterwards.
  - Changed Matosade's related_projectiles to spawn a small worm, instead of a big one.
- `alt_fire_anything`
  - The [Alt Fire Anything](https://noita.wiki.gg/wiki/Mod:Alt_Fire_Anything) spell has been ported into this mod.
- `trial_perks`
  - Adds a set of new perks that reward the player for challenging themselves.
- `holy_mountain_rework`
  - [readme.md](files/modules/holy_mountain_rework/readme.md)
- `ring_of_returning`
  - An item found in each Holy Mountain that, when broken, opens a portal to the last HM you discovered.
- `credit`
  - Credits are replaced with the Commit history and optional dev messages
