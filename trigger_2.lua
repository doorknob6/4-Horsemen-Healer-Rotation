function(event, timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,_, spellName, ...)
    if subEvent=="UNIT_DIED" then
        --else error in options
        destGUID=destGUID or ""
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", destGUID)
		npc_id = tonumber(npc_id)
		if tContains(aura_env.horsemenIDs, npc_id) then
			for n, id in pairs(aura_env.horsemenIDs) do
				if (id==npc_id) then
					aura_env.horsemenNames[n]="Safe Zone"
					if (n==aura_env.currentHorsemanNumber) then
						aura_env.message="MOVE to "
						aura_env.currentHorseman=aura_env.horsemenNames[n]
					end
					break
				end
			end
			return true
		end
    end
end
