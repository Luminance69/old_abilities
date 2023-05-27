for _, listener_id in ipairs(registered_custom_listeners or {}) do
	CustomGameEventManager:UnregisterListener(listener_id)
end
registered_custom_listeners = {}
function RegisterCustomEventListener(event_name, callback)
	local listener_id = CustomGameEventManager:RegisterListener(event_name, function(_, args)
		callback(args)
	end)

	table.insert(registered_custom_listeners, listener_id)
end


for _, listener_id in ipairs(registered_game_events_listeners or {}) do
	StopListeningToGameEvent(listener_id)
end
registered_game_events_listeners = {}
function RegisterGameEventListener(event_name, callback)
	local listener_id = ListenToGameEvent(event_name, callback, nil)
	table.insert(registered_game_events_listeners, listener_id)
end


function DisplayError(player_id, message)
	local player = PlayerResource:GetPlayer(player_id)
	if player then
		CustomGameEventManager:Send_ServerToPlayer(player, "display_custom_error", { message = message })
	end
end


function toboolean(value)
	if not value then return value end
	local val_type = type(value)
	if val_type == "boolean" then return value end
	if val_type == "number"	then return value ~= 0 end
	-- return true for anything we can't explicitly measure
	return true
end

function splitstring(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end
