Scenario = Scenario or class({})

require("scenario/drow")

function Scenario:Init()
end

function Scenario:RunScenario(hero, id)
	if self.end_func then
		self.end_func()
	end

	local loop_func, end_loop = Scenario[hero][tonumber(id)]()
	self.loop = loop_func
	self.end_func = end_loop

	local tick = 0

	Timers:CreateTimer(FrameTime(), function()
		if self.loop == loop_func then
			loop_func(tick)
			tick = tick + 1
			return FrameTime()
		end
	end)
end
