function Events:OnEntityKilled(event)
	local killed = EntIndexToHScript(event.entindex_killed)
	local killer = EntIndexToHScript(event.entindex_attacker)
	local inflictor

	if event.entindex_inflictor then
		inflictor = EntIndexToHScript(event.entindex_inflictor)
	end

	if killed:IsClone() then killed = killed:GetCloneSource() end
	if killer and killed and killed:IsRealHero() and not killed:IsReincarnating() then
		local time_left = killed:GetRespawnTime()
		time_left = time_left - (time_left * GameSettings:GetRespawnTimeReduction())
		time_left = math.min(time_left, GameSettings:GetRespawnTimeCap())

		killed:SetTimeUntilRespawn(time_left)
	end
end
