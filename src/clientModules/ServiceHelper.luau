local ServiceHelper = {}

function ServiceHelper.Boot(f: Instance): ()
	local modules = {}

	for _, moduleScript in f:GetChildren() do
		if not moduleScript:IsA("ModuleScript") then
			continue
		end

		local ok, result = pcall(require, moduleScript)
		if not ok then
			warn(`[Loader] failed to require {moduleScript:GetFullName()}: {result}`)
			continue
		end

		table.insert(modules, result)
	end

	for _, module in modules do
		if module.Init then
			task.spawn(function()
				module:Init()
				module._initialised = true
			end)
		end
	end
end

function ServiceHelper.IsInitialised(service): boolean
	return service._initialised
end

function ServiceHelper.WaitUntilInitialised(service)
	while not service._initialised do
		task.wait()
	end
end

return ServiceHelper
