local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServiceHelper = require(ReplicatedStorage.ClientModules.ServiceHelper)

ServiceHelper.Boot(ServerScriptService.Server)
