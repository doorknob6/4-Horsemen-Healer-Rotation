aura_env.last=0
aura_env.maxMarkStack=0
aura_env.markCount=0
aura_env.message=""
aura_env.wrongMark=false

--horsemen mark ids/names and npc ids/names in clockwise order
--[Lady Blaumeaux]  --► [Sir Zeliek]
--      ▲                     |
--		|                     ▼
--[Thane Korth'azz] ◄-- [Highlord Mograine]

aura_env.markIDs={28834, 28832, 28833, 28835}
aura_env.markNames = {}
for _,v in pairs(aura_env.markIDs) do
	local name=GetSpellInfo(v)
	table.insert(aura_env.markNames, name)
end
aura_env.horsemenIDs={16062, 16064, 16065, 16063}
aura_env.horsemenNames = {"Highlord Mograine", "Thane Korth'azz", "Lady Blaumeaux", "Sir Zeliek"}

--name of the current horseman in the rotation
aura_env.currentHorseman=""
--index in the mark id, npc id and names tables of the current horseman, set on encounter start
aura_env.currentHorsemanNumber=0

--setting values in case encounter_start (loads aura), comes after PLAYER_REGEN_DISABLED and the trigger doesnt get the encounter_start event, since the aura just loaded
aura_env.timer=20
aura_env.expirationTime=GetTime()+20