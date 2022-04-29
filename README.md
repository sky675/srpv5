![Logo](https://i.imgur.com/6q1W83z.png)

# sky's Stalker Roleplay

**This will likely not be modified past this point.**
**I won't bother to add a license or anything, you can do what you want with any piece of material or code in with this, my only request is that you keep the author fields in the schema and the various plugins intact (adding onto it is fine).**

A custom NutScript-based schema for S.T.A.L.K.E.R. roleplay (based on the game series not the crime). Includes lots of gameplay features to both boost rp as well as fill the void between.

Includes a multitude of custom plugins as well as a modified version of NutScript.

## Installation

Drop the `nutscript` and `stalker` folders into your `garrysmod/gamemodes/` folder and set your gamemode launch option as such:

```
-gamemode stalker
```

The gamemode by default is set up for the addons from this [collection](https://steamcommunity.com/sharedfiles/filedetails/?id=2489641694), you'll need to modify `sh_config.lua` in the schema to add/remove the workshop addons used.

## Feature/Plugin list

- PDA System (including messaging with multiple channels and an auto-updating leaderboard with associated xp and rep systems, which are primarily given via admin commands)
- Stalker Themed UI
- Custom Player Model System
- Submaterial-based Suit Skinning System, allowing an unlimited number of variations of suits
- Suit-based Hand Models and HUD Overlays
- Shoot to RP System (displays hits taken and given with ranges, item-based armor protection, and optional damage/downing system)
- Pausing System (freeze players in a fight so they wont get advantages while players are /meing, requires an admin to be in/oversee a fight)
- Suit Ratings, Protections, and Durability
- Artifact+Radiation System (Misery/Anomaly style, with equipable artifact containers, detectors that reveal active artifacts, and junk artifacts that are always visible)
- Custom blowout and psy-storm system, that needs to be set up per map
- Modular Suit Upgrade System
- Crafting
- Trait/Skill System
- Language System (integrated with trait system)
- ArcCW Integration (with optional weapon durability and different ammo types - note that this hasnt been updated in months and the ways i did this may very well be broken by now, based on what happened while this was live)
- Food/Needs System
- Procedural mini-event/side-job system that needs to be set up manually per map (see autoevents and bountyboard plugins) with some examples (note: this worked, but was never fully implemented while the server was running)
- Automatic NPC spawn points (see directorlite, the system is built for navmesh but iirc works enough without it)
- Automatic loot spawns, as well as NPC looting (designed similar to Anomaly mutant looting), with configurable spawn tables
- Custom items created during character creation or via admin commands
- Many minor features and mechanics such as: c4 and detonators, item returning on death, dynamic music with integration for locally installed workshop music packs, a custom solution for equipping items (equiptable in preload), and more
- As a bonus, some features from previous schemas that went mostly unused but were still included: 
- hacking (use a special item for interacting with entities such as combine doors in the map icly)
- bleeding (when taking damage, theres a chance that a bleed will accrue, slowly dealing damage overtime, using an item such a bandage will decrease/remove it. it is disabled by default)

## Also included

- A modified version of [evolve](https://github.com/Xandaros/evolve) (namely adding @ for use as admin chat, ULX style)
- Various VJ Base human NPCs, using the same model system as players do. Note that they do not function properly outside of the schema (they will work, but don't die properly and won't have the correct suit materials).
- An assortment of various other NPCs and entities from various sources.
- Assorted autorun scripts taken and modified from various sources.

## Credits

- [sky](https://github.com/sky675) (main dev)
- [NateStanley](https://github.com/NateStanley) (primarily all of the custom ui)
- [the main NutScript developers](https://github.com/NutScript/NutScript)
- [Helix developers](https://github.com/NebulousCloud/helix) (some features that were inserted into the custom NutScript version here were taken from a very early version of helix (namely the command descriptions and autocomplete))
- the many many authors of various scripts and assets that we've used throughout the various lifetimes of this schema, from srpv1 back in 2017, to the most recent and likely final iteration in 2021.

### sky's shameless plug:
if you ever joined this or any previous iteration of this schema (or end up using anything from this for that matter too!), and want to support me for the work i've done throughout the years on this, you can help me out by buying [my game, OASIS: Tokyo](https://sky675.itch.io/oasis). it'd be extremely appreciated!