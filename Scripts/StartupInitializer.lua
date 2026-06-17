--[[
	StartupInitializer Script
	Initializes the entire gym system on game start
	Place in: ServerScriptService as the FIRST script to run
]]

local RunService = game:GetService("RunService")

-- ============================================
-- STARTUP SEQUENCE
-- ============================================

local startupSteps = {}

-- Step 1: Load modules
table.insert(startupSteps, function()
	print("[STARTUP] Loading modules...")
	local modules = game.ServerScriptService:WaitForChild("Modules")
	
	-- Verify all modules exist
	local requiredModules = {"Config", "PlayerData", "DataStore", "Animations"}
	for _, moduleName in ipairs(requiredModules) do
		if not modules:FindFirstChild(moduleName) then
			error("Missing module: " .. moduleName)
		end
	end
	
	print("[STARTUP] ✓ All modules loaded")
end)

-- Step 2: Verify RemoteEvents
table.insert(startupSteps, function()
	print("[STARTUP] Verifying RemoteEvents...")
	local remotes = game:WaitForChild("ReplicatedStorage"):WaitForChild("Remotes")
	
	local requiredRemotes = {
		"UseGymMachine",
		"UpdateStats",
	}
	
	for _, remoteName in ipairs(requiredRemotes) do
		if not remotes:FindFirstChild(remoteName) then
			error("Missing RemoteEvent: " .. remoteName)
		end
	end
	
	print("[STARTUP] ✓ All RemoteEvents verified")
end)

-- Step 3: Verify game structure
table.insert(startupSteps, function()
	print("[STARTUP] Verifying game structure...")
	
	-- Check for machines
	local machinesFolder = game.Workspace:FindFirstChild("GymMachines")
	if machinesFolder then
		print("[STARTUP] ✓ Found " .. #machinesFolder:GetChildren() .. " machines")
	else
		warn("[STARTUP] No GymMachines folder found - you may need to run CreateMachines.lua")
	end
end)

-- Step 4: Check for required server scripts
table.insert(startupSteps, function()
	print("[STARTUP] Verifying server scripts...")
	
	local ServerScriptService = game.ServerScriptService
	
	-- Check for PlayerManager
	if not ServerScriptService:FindFirstChild("PlayerManager") then
		error("Missing PlayerManager script in ServerScriptService")
	end
	
	print("[STARTUP] ✓ All server scripts found")
end)

-- Step 5: Check DataStore access
table.insert(startupSteps, function()
	print("[STARTUP] Testing DataStore access...")
	
	local DataStoreService = game:GetService("DataStoreService")
	local testStore = DataStoreService:GetDataStore("__STARTUP_TEST__")
	
	local success = pcall(function()
		testStore:SetAsync("test", {test = true})
	end)
	
	if success then
		print("[STARTUP] ✓ DataStore access confirmed")
	else
		warn("[STARTUP] ! DataStore may not be accessible - check Studio settings")
	end
end)

-- ============================================
-- RUN STARTUP SEQUENCE
-- ============================================

local function runStartup()
	print("\n" .. string.rep("=", 50))
	print("GYM SYSTEM STARTUP SEQUENCE")
	print(string.rep("=", 50) .. "\n")
	
	for i, step in ipairs(startupSteps) do
		local success, err = pcall(step)
		
		if not success then
			print("[STARTUP] ✗ STEP " .. i .. " FAILED: " .. tostring(err))
			return false
		end
		
		wait(0.1)
	end
	
	print("\n" .. string.rep("=", 50))
	print("✓ STARTUP COMPLETE - SYSTEM READY")
	print(string.rep("=", 50) .. "\n")
	
	return true
end

-- Run startup when game loads
if RunService:IsServer() then
	runStartup()
end

-- ============================================
-- CONTINUOUS HEALTH CHECK
-- ============================================

local healthCheckInterval = 30 -- seconds

coroutine.wrap(function()
	while true do
		wait(healthCheckInterval)
		
		-- Check if critical systems are still running
		local PlayerManager = game.ServerScriptService:FindFirstChild("PlayerManager")
		
		if PlayerManager then
			-- System is healthy
		else
			warn("[HEALTH] PlayerManager not found - system may be compromised")
		end
	end
end)()

return {
	runStartup = runStartup,
}
