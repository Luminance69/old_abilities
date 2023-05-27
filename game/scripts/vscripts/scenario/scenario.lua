Scenario = Scenario or class({})

require("scenario/drow")

function Scenario:Init()
end

function Scenario:RunScenario(hero, id)
	local loop_func, end_loop = Scenario[hero][tonumber(id)]()
	self.loop = loop_func

	local tick = 0

	Timers:CreateTimer(FrameTime(), function()
		if self.loop == loop_func then
			loop_func(tick)
			tick = tick + 1
			return FrameTime()
		else
			end_loop()
		end
	end)
end
