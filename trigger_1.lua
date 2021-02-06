function(event, timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,_, spellName, ...)
    if subEvent=="SPELL_CAST_SUCCESS" then

        --else error in options
        sourceGUID=sourceGUID or ""
        local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", sourceGUID)
        npc_id = tonumber(npc_id)

        --mark cast by horsemen, not spirit, plus not in the cooldown period of 5s
        if tContains(aura_env.horsemenIDs, npc_id) and tContains(aura_env.markNames, spellName) and GetTime()>aura_env.last+5 then

            aura_env.last=GetTime()

            aura_env.markCount=aura_env.markCount+1

            --change message and horseman location
            if (aura_env.markCount==aura_env.config.optStart or (aura_env.markCount-aura_env.config.optStart) % aura_env.config.optStep==0 and aura_env.markCount>aura_env.config.optStart) then

				--change the current horseman
				--clockwise rotation
				if (aura_env.config.optRotationDirection) then
					if (aura_env.currentHorsemanNumber<4) then
						aura_env.currentHorsemanNumber=aura_env.currentHorsemanNumber+1
					else
						aura_env.currentHorsemanNumber=1
					end
				--counterclockwise rotation
				else
					if (aura_env.currentHorsemanNumber>1) then
						aura_env.currentHorsemanNumber=aura_env.currentHorsemanNumber-1
					else
						aura_env.currentHorsemanNumber=4
					end
				end
				
				aura_env.currentHorseman=aura_env.horsemenNames[aura_env.currentHorsemanNumber]
				
				--move message
                aura_env.message="MOVE to "
				
            else
				--location message
                aura_env.message="Currently at "
            end

			--get the debuff stack for the new mark
			_,_,aura_env.maxMarkStack=WA_GetUnitDebuff("player", spellName)
			aura_env.maxMarkStack=aura_env.maxMarkStack or 0
			--set the message
            if aura_env.maxMarkStack>=aura_env.config.optStackAlarm then
                aura_env.message=aura_env.maxMarkStack.." STACKS "..aura_env.message
            end
			
			--check if you got the correct mark
			if (spellName~=aura_env.markNames[aura_env.currentHorsemanNumber]) then
				aura_env.wrongMark=true
			end

            --set progress bar times
            aura_env.timer=12
            aura_env.expirationTime=GetTime()+12
            return true

        end

	--start of combat
    elseif event=="ENCOUNTER_START" then
        --reset
        aura_env.markCount=0
		--set the starting horseman as the current one
        aura_env.currentHorseman=aura_env.config.optStartHorseman
		--set starting horseman number
		for i, name in pairs(aura_env.horsemenNames) do
			if (name==aura_env.currentHorseman) then
				aura_env.currentHorsemanNumber=i
				break
			end
		end
		--set the starting message
        aura_env.message="Start at "
        --set progress bar times
        aura_env.timer=20
        aura_env.expirationTime=GetTime()+20

        return true

	--end of fight reset
    elseif event == "ENCOUNTER_END" then
        --reset
        aura_env.markCount=0
        aura_env.message=""
		aura_env.currentHorseman=""
		aura_env.currentHorsemanID=0
		
        return true
    end

end
