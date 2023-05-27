-- TODO: figure out why this doesn't work

Client = Client or class({})

function Client:HideUI(event)
	print("a", event)
	if event.hide then
		SendToConsole("r_drawpanorama 0;dota_hide_cursor 1")
	else
		SendToConsole("r_drawpanorama 1;dota_hide_cursor 0")
	end
end

ListenToGameEvent("hide_ui", Dynamic_Wrap(Client, "HideUI"), Client)
