# Truly Limited Spells

A set of changes that makes limited-use spells *truly* limited - no more infinite cheesing with Greek letters and Wand Refresh.


## Changes

- The **Unlimited Spells** perk has been removed. In its place is **Spell Gems**, a perk that causes enemies to sometimes drop ammo packs (chance scaling with their max HP). Ideally, the frequency of these drops should practically still let you "unlimit" spells, but with the added requirement of more effort and danger.

- **Wand Refresh** has been removed from the spell pool (for now); Alt Fire Anything replaces the copy dropped by MoM. (would be nice if the spell just lost its unlimiting ability instead of removing it, but alas, I am not a gun person)

- **Greek spells** are now limited to 30 uses - by default. This lets you cast powerful spells (e.g. Black Hole, CoV) a generous 30 extra times, before you need to find a Spell Refresh, hunt for *Spell Gems*, or use one of the following:

- Two new (late-game) spells have been added, with the explicit intention of letting you unlimit spells again - either at a monetary cost, or after proving yourself truly worthy of a god run.
	- **Indulgence** is a spell that force-casts the next spell if it has 0 uses, at the cost of some gold. The price per cast scales with the spell's max uses (less uses = more expensive), whether it is `never_unlimited`, and whether it is `recursive` (i.e. Greek spells).
		- This spell spawns, and can be purchased for 1000 gold, after emptying an HM shop.
	- **Infinity** force-casts the next empty spell, at no cost other than 99 mana.
		- This spell is a guaranteed drop from the Master of Masters.
