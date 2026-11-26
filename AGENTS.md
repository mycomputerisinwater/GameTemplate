This is a roblox studio game project. You have access to the roblox studio MCP. Code editing should be done exclusively through the file system.
This project uses rokit and the tools this project uses are listed in rokit.toml.

# Organisation
The Packages directory is for wally installed packages.
'src' is where code lives.
The boot directory contains scripts which call 'src/clientModules/ServiceHelper.luau' (`ServiceHelper.Boot`) to load services under client and server directories respectively.
Additionally there are clientModules and serverModules directories. These are for scripts that do not need to be initialised like services.
'clientModules' are for client and server. 'serverModules' are only for server.

# Packages
Wally dependencies are installed into the Packages directory (gitignored); run `wally install` after editing wally.toml. Currently installed:
- `Networker`: remotes and networking.
- `DataService`: player data persistence.

Use these instead of writing your own remotes or data saving.

# Services
Services are ModuleScripts returning a table, usually with a colon-method `Init`:

```lua
local FooService = {}

function FooService:Init()
end

return FooService
```

`ServiceHelper.Boot` requires every module in the folder, then calls each `Init` with `task.spawn`, so an `Init` runs in its own thread and may yield freely without blocking other services. However, another service's `Init` may not have started or finished by the time yours runs: init order is not guaranteed. Modules without an `Init` are still required.

After an `Init` returns, `ServiceHelper` marks the service initialised. To depend on another service, call `ServiceHelper.WaitUntilInitialised(service)` (yields until its `Init` has finished) inside your own `Init`; `ServiceHelper.IsInitialised(service)` is the non-yielding check.

# Naming
- Server services live in 'src/server' and are named `FooService`.
- Client services live in 'src/client' and are named `FooServiceClient`.
