local lib = {}
local IDGenerator = {}

local TriggerRemoteEvent = nil
local RegisterLocalEvent = nil

if SERVER then
	TriggerRemoteEvent = TriggerClientEvent
	RegisterLocalEvent = RegisterServerEvent
else
	TriggerRemoteEvent = TriggerServerEvent
	RegisterLocalEvent = RegisterNetEvent
end

function lib.newIDGenerator()
	local r = setmetatable({}, { __index = IDGenerator })
	r:construct()
	return r
end

function IDGenerator:construct()
	self:clear()
end

function IDGenerator:clear()
	self.max = 0
	self.ids = {}
end

function IDGenerator:gen()
	if #self.ids > 0 then
		return table.remove(self.ids)
	else
		local r = self.max
		self.max = self.max+1
		return r
	end
end

function IDGenerator:free(id)
	table.insert(self.ids,id)
end

lib.delays = {}

function lib.setDestDelay(dest,delay)
	lib.delays[dest] = { delay,0 }
end

local function lib_resolve(itable,key)
	local mtable = getmetatable(itable)
	local iname = mtable.name
	local ids = mtable.lib_ids
	local callbacks = mtable.lib_callbacks
	local identifier = mtable.identifier
	local fname = key
	local no_wait = false
	if string.sub(key,1,1) == "_" then
		fname = string.sub(key,2)
		no_wait = true
	end

	local fcall = function(...)
		local r = nil
		local profile

		local args = {...} 
		local dest = nil
		if SERVER then
			dest = args[1]
			args = {table.unpack(args,2,table.maxn(args))}
			if dest >= 0 and not no_wait then
				r = asynclib()
			end
		elseif not no_wait then
			r = asynclib()
		end

		local delay_data = nil
		if dest then delay_data = lib.delays[dest] end
		if delay_data == nil then
			delay_data = {0,0}
		end

		local add_delay = delay_data[1]
		delay_data[2] = delay_data[2]+add_delay

		if delay_data[2] > 0 then
			SetTimeout(delay_data[2], function()
				delay_data[2] = delay_data[2]-add_delay
				local rid = -1
				if r then
					rid = ids:gen()
					callbacks[rid] = r
				end

				if SERVER then
					TriggerRemoteEvent(iname..":lib_req",dest,fname,args,identifier,rid)
				else
					TriggerRemoteEvent(iname..":lib_req",fname,args,identifier,rid)
				end
			end)
		else
			local rid = -1
			if r then
				rid = ids:gen()
				callbacks[rid] = r
			end

			if SERVER then
				TriggerRemoteEvent(iname..":lib_req",dest,fname,args,identifier,rid)
			else
				TriggerRemoteEvent(iname..":lib_req",fname,args,identifier,rid)
			end
		end

		if r then
			if profile then
				local rets = { r:wait() }
				return table.unpack(rets,1,table.maxn(rets))
			else
				return r:wait()
			end
		end
	end

	itable[key] = fcall
	return fcall
end

function lib.registerModule(name,interface)
	RegisterLocalEvent(name..":lib_req")
	AddEventHandler(name..":lib_req",function(member,args,identifier,rid)
		local source = source

		local f = interface[member]

		local rets = {}
		if type(f) == "function" then
			rets = { f(table.unpack(args,1,table.maxn(args))) }
		end

		if rid >= 0 then
			if SERVER then
				TriggerRemoteEvent(name..":"..identifier..":lib_res",source,rid,rets)
			else
				TriggerRemoteEvent(name..":"..identifier..":lib_res",rid,rets)
			end
		end
	end)
end

function lib.getModule(name,identifier)
	if not identifier then identifier = GetCurrentResourceName() end
  
	local ids = lib.newIDGenerator()
	local callbacks = {}
	local r = setmetatable({},{ __index = lib_resolve, name = name, lib_ids = ids, lib_callbacks = callbacks, identifier = identifier })

	RegisterLocalEvent(name..":"..identifier..":lib_res")
	AddEventHandler(name..":"..identifier..":lib_res",function(rid,args)
		local callback = callbacks[rid]
		if callback then
			ids:free(rid)
			callbacks[rid] = nil
			callback(table.unpack(args,1,table.maxn(args)))
		end
	end)
	return r
end

return lib