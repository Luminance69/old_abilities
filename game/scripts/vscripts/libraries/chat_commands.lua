ChatCommands = ChatCommands or class({})


function ChatCommands:Init()
	RegisterGameEventListener("player_chat", function(event)
		ChatCommands:OnPlayerChat(event)
	end)
end


function ChatCommands:OnPlayerChat(event)
	if not event.userid then return end

	event.player = PlayerInstanceFromIndex( event.userid )
	if not event.player then return end

	event.hero = event.player:GetAssignedHero()
	if not event.hero then return end

	event.player_id = event.hero:GetPlayerID()

	if not event.playerid or not PlayerResource:IsValidPlayerID(event.playerid) then return end

	local command_source = string.trim(string.lower(event.text))
	if command_source:sub(0,1) ~= "-" then return end
	-- removing `-`
	command_source = command_source:sub(2)

	local arguments = string.split(command_source)
	local command_name = table.remove(arguments, 1)

	if ChatCommands[command_name] then
		ErrorTracking.Try(ChatCommands[command_name], ChatCommands, arguments, event)
	end

	ErrorTracking.Try(ChatCommands.GeneralProcessing, ChatCommands, command_name, arguments, event)
end


ChatCommands:Init()

function ChatCommands:timescale(arguments, event)
	if not GameMode:IsDeveloper(event.player_id) and not GameRules:IsCheatMode() then return end
	if not arguments[1] then return end

	local value = tonumber(arguments[1])
	if value < 0.1 then value = 0.1 end
	Convars:SetFloat("host_timescale", value)
end
