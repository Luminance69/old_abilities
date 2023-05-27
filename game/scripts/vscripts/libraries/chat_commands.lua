ChatCommands = ChatCommands or class({})


function ChatCommands:Init()
	-- Fix it double firing for some reason
	self.cooldown = GameRules:GetGameTime()

	RegisterGameEventListener("player_chat", function(event)
		ChatCommands:OnPlayerChat(event)
	end)
end


function ChatCommands:OnPlayerChat(event)
	if GameRules:GetGameTime() < self.cooldown then return end
	self.cooldown = GameRules:GetGameTime() + 0.1

	local command_source = string.trim(string.lower(event.text))

	local arguments = string.split(command_source)
	local command_name = table.remove(arguments, 1)

	if ChatCommands[command_name] then
		ChatCommands[command_name](ChatCommands, arguments)
	end
end


ChatCommands:Init()

function ChatCommands:timescale(arguments)
	if not arguments[1] then return end

	local value = tonumber(arguments[1])
	if value < 0.1 then value = 0.1 end
	Convars:SetFloat("host_timescale", value)
end

function ChatCommands:dump(arguments)
	local hero = PlayerResource:GetSelectedHeroEntity(0)

	print("origin:", hero:GetAbsOrigin())
end

function ChatCommands:run(arguments)
	if not arguments[1] and arguments[2] then return end

	Scenario:RunScenario(arguments[1], arguments[2])
end
