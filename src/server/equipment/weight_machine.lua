-- Server-side Weight Machine Logic
local WeightMachine = {}
local Config = require(game.ServerScriptService:WaitForChild("config"))

function WeightMachine.new(machineModel)
	local self = setmetatable({}, WeightMachine)
	self.machineModel = machineModel
	self.userSessions = {}
	
	self:setupInteraction()
	
	return self
end

function WeightMachine:setupInteraction()
	local interactZone = self.machineModel:FindFirstChild("InteractZone")
	if not interactZone then return end
	
	interactZone.Touched:Connect(function(hit)
		self:onPlayerInteract(hit)
	end)
end

function WeightMachine:onPlayerInteract(hit)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	if not humanoid then return end
	
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if not player then return end
	
	if self.userSessions[player.UserId] then return end
	
	print(player.Name .. " started using the weight machine")
	
	self.userSessions[player.UserId] = {
		player = player,
		character = hit.Parent,
		currentRep = 0,
		currentSet = 0,
		weight = Config.Workouts.WeightMachine.weight,
		totalReps = 0
	}
	
	self:startWeightSession(player.UserId)
end

function WeightMachine:startWeightSession(userId)
	local session = self.userSessions[userId]
	if not session then return end
	
	task.spawn(function()
		local sets = Config.Workouts.WeightMachine.sets
		local repsPerSet = Config.Workouts.WeightMachine.reps
		
		for set = 1, sets do
			if not self.userSessions[userId] then break end
			
			session.currentSet = set
			
			for rep = 1, repsPerSet do
				if not self.userSessions[userId] then break end
				
				session.currentRep = rep
				session.totalReps = session.totalReps + 1
				
				-- Simulate rep duration
				self:playLiftAnimation(session)
				task.wait(1.5)
				
				self:updateDisplay(session)
			end
			
			-- Rest between sets
			if set < sets then
				task.wait(2)
			end
		end
		
		self:endWeightSession(userId)
	end)
end

function WeightMachine:playLiftAnimation(session)
	-- Play lift animation for character
	print(string.format(
		"%s: Set %d - Rep %d/%d",
		session.player.Name,
		session.currentSet,
		session.currentRep,
		Config.Workouts.WeightMachine.reps
	))
end

function WeightMachine:updateDisplay(session)
	local display = self.machineModel:FindFirstChild("Display")
	if display then
		local text = display:FindFirstChild("TextLabel")
		if text then
			text.Text = string.format(
				"Set: %d/%d\nRep: %d/%d\nWeight: %d lbs",
				session.currentSet,
				Config.Workouts.WeightMachine.sets,
				session.currentRep,
				Config.Workouts.WeightMachine.reps,
				session.weight
			)
		end
	end
end

function WeightMachine:endWeightSession(userId)
	local session = self.userSessions[userId]
	if not session then return end
	
	print(string.format(
		"%s completed weight machine session: %d total reps at %d lbs",
		session.player.Name,
		session.totalReps,
		session.weight
	))
	
	self.userSessions[userId] = nil
end

return WeightMachine
