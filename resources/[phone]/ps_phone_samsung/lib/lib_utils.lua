SERVER = IsDuplicityVersion()
CLIENT = not SERVER

function table.maxn(t)
	local max = 0
	for k,v in pairs(t) do
		local n = tonumber(k)
		if n and n > max then max = n end
	end
	return max
end

local modules = {}
function loadmodule(rsc, path)
	if path == nil then
		path = rsc
		rsc = GetCurrentResourceName()
	end

	local key = rsc..path
	local loadmodule = modules[key]
	if loadmodule then
		return loadmodule
	else
		local code = LoadResourceFile(rsc, path..".lua")
		if code then
			local f,err = load(code, rsc.."/"..path..".lua")
			if f then
				local ok, res = xpcall(f, debug.traceback)
				if ok then
					modules[key] = res
					return res
				else
					error("error loading module "..rsc.."/"..path..":"..res)
				end
			else
				error("error parsing module "..rsc.."/"..path..":"..debug.traceback(err))
			end
		else
			error("resource file "..rsc.."/"..path..".lua not found")
		end
	end
end

local function asyncwait(self)
	local rets = Citizen.Await(self.p)
	if not rets then
		rets = self.r 
	end
	return table.unpack(rets,1,table.maxn(rets))
end

local function asyncreturn(self, ...)
	self.r = {...}
	self.p:resolve(self.r)
end

function asynclib(func)
	if func then
		Citizen.CreateThreadNow(func)
	else
		return setmetatable({ wait = asyncwait, p = promise.new() }, { __call = asyncreturn })
	end
end