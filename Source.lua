local RBXWait = require(PATH.RBXWait) -- Replace this with the path leading to the RBXWait ModuleScript!

local function FastDelay(...)
	local Len = select('#', ...)
	if Len < 2 then
		error('FastDelay function requires 2 arguments', 2)
	end
	local Args = {...}

	local Time = Args[1]
	Time = type(Time) == 'number' and Time or 0

	local Callback = Args[2]
	coroutine.wrap(function(...)
		local YieldTime, TimePassed = RBXWait(Time)
		return Callback(YieldTime, TimePassed, ...)
	end)(select(3, ...))
end
local function FastDebris(Item, Lifetime)
	if typeof(Item) ~= 'Instance' then
		error('Unable to cast value to Object', 2)
	end
	Lifetime = type(Lifetime) == 'number' and Lifetime or 0

	FastDelay(Lifetime, function()
		if Item.Parent then
			Item:Destroy()
			Item = nil
		end
	end)
end