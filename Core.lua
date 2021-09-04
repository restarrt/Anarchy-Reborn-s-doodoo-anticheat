client = nil;
service = nil;
cPcall = nil;
Pcall = nil;
Routine = nil;
GetEnv = nil;
origEnv = nil;
logError = nil;
return function()
	local u1 = nil;
	local l__client__2 = client;
	local u3 = nil;
	local u4 = nil;
	local u5 = nil;
	local u6 = nil;
	local u7 = nil;
	local u8 = nil;
	local l__service__9 = service;
	getfenv().client = nil;
	getfenv().service = nil;
	getfenv().script = nil;
	local v1 = {
		Init = function()
			u1 = l__client__2.UI;
			u3 = l__client__2.Anti;
			u4 = l__client__2.Core;
			u5 = l__client__2.Variables;
			u6 = l__client__2.Functions;
			u7 = l__client__2.Process;
			u8 = l__client__2.Remote;
			u4.Name = "\000";
			u4.Special = l__client__2.DepsName;
			u4.MakeGui = u1.Make;
			u4.GetGui = u1.Get;
			u4.RemoveGui = u1.Remove;
			u4.Init = nil;
		end, 
		RunLast = function()
			if l__service__9.NetworkClient then
				l__service__9.TrackTask("Thread: API Manager", u4.StartAPI);
			end;
			u4.RunLast = nil;
		end, 
		RunAfterLoaded = RunAfterLoaded, 
		RunAfterPlugins = function(p1)
			u4.GetEvent();
			u4.RunAfterPlugins = nil;
		end, 
		Name = script.Name, 
		Special = script.Name, 
		ScriptCache = {}
	};
	local l__next__10 = next;
	local l__wait__11 = wait;
	local l__warn__12 = warn;
	function v1.GetEvent()
		if u4.RemoteEvent then
			log("Disconnect old RemoteEvent");
			for v2, v3 in l__next__10, u4.RemoteEvent.Events do
				v3:Disconnect();
			end;
			u4.RemoteEvent = nil;
		end;
		log("Getting RemoteEvent");
		local v4 = {};
		local l__ReplicatedStorage__5 = l__service__9.ReplicatedStorage;
		local v6 = l__ReplicatedStorage__5:WaitForChild(l__client__2.RemoteName, 300);
		if not v6 then
			u3.Detected("Kick", "RemoteEvent Not Found");
			return;
		end;
		log("Getting RemoteFunction");
		local l____FUNCTION__7 = v6:WaitForChild("__FUNCTION", 120);
		if not l____FUNCTION__7 then
			u3.Detected("Kick", "RemoteFunction Not Found");
			return;
		end;
		local v8 = {};
		l____FUNCTION__7.OnClientInvoke = u7.Remote;
		v4.Object = v6;
		v4.Function = l____FUNCTION__7;
		v4.FireServer = v6.FireServer;
		v4.Events = v8;
		v8.ProcessRemote = v6.OnClientEvent:Connect(u7.Remote);
		v8.ParentChildRemoved = l__ReplicatedStorage__5.ChildRemoved:Connect(function(p2)
			if u4.RemoteEvent == v4 and p2 == v6 and l__wait__11() then
				l__warn__12("::ADONIS:: REMOTE EVENT REMOVED? RE-GRABBING");
				log("~! REMOTEEVENT WAS REMOVED?");
				u4.GetEvent();
			end;
		end);
		u4.RemoteEvent = v4;
		if not u4.Key then
			log("~! Getting key from server");
			u8.Fire(l__client__2.DepsName .. "GET_KEY");
		end;
	end;
	local l__require__13 = require;
	local l__setfenv__14 = setfenv;
	local l__getfenv__15 = getfenv;
	function v1.LoadPlugin(p3)
		local v9 = l__require__13(p3);
		cPcall((l__setfenv__14(v9, GetEnv(l__getfenv__15(v9)))));
	end;
	function v1.LoadBytecode(p4, p5)
		return l__require__13(l__client__2.Shared.FiOne)(p4, p5);
	end;
	function v1.LoadCode(p6, p7)
		return u4.LoadBytecode(p6, p7);
	end;
	local l___G__16 = _G;
	local l__setmetatable__17 = setmetatable;
	local l__type__18 = type;
	local l__print__19 = print;
	local l__error__20 = error;
	local l__pairs__21 = pairs;
	local l__table__22 = table;
	local l__rawset__23 = rawset;
	local l__rawget__24 = rawget;
	local l__tostring__25 = tostring;
	local l__getmetatable__26 = getmetatable;
	function v1.StartAPI()
		local l__GetFire__10 = u8.GetFire;
		local l__MetaFunc__11 = l__service__9.MetaFunc;
		local l__ReadOnly__12 = l__service__9.ReadOnly;
		local l__ReadOnly__13 = l__service__9.ReadOnly;
		local v14 = {};
		l__setfenv__14(1, l__setmetatable__17({}, {
			__metatable = l__getmetatable__26(l__getfenv__15())
		}));
		local v15 = {};
		local v16 = {};
		function v16.Test()
			l__print__19("We ran the api specific stuff");
		end;
		v15.API_Specific = v16;
		v15.Service = nil;
		local v17 = {
			Access = l__ReadOnly__13({}, nil, nil, true)
		};
		local v18 = {};
		local l__ScriptCache__27 = u4.ScriptCache;
		local l__UnWrap__28 = l__service__9.UnWrap;
		local l__Get__29 = u8.Get;
		local l__FiOne__30 = l__client__2.Shared.FiOne;
		function v18.ExecutePermission(p8, p9)
			local v19 = nil;
			for v20, v21 in l__next__10, l__ScriptCache__27 do
				if l__UnWrap__28(v21.Script) == p8 then
					v19 = v21;
				end;
			end;
			if v19 and v19.noCache ~= true and (not v19.runLimit or v19.runLimit and v19.Executions <= v19.runLimit) then
				v19.Executions = v19.Executions + 1;
				return v19.Source, v19.Loadstring;
			end;
			local v22 = l__Get__29("ExecutePermission", p8, p9, true);
			if not v22 or not v22.Source then
				return;
			end;
			if not v19 then
				local v23 = l__require__13(l__FiOne__30:Clone());
				l__table__22.insert(l__ScriptCache__27, {
					Script = p8, 
					Source = v22.Source, 
					Loadstring = v23, 
					noCache = v22.noCache, 
					runLimit = v22.runLimit, 
					Executions = v22.Executions
				});
			else
				v23 = v19.Loadstring;
				v19.Source = v22.Source;
			end;
			return v22.Source, v23;
		end;
		v18.ReportLBI = l__MetaFunc__11(function(p10, p11)
			if p11 ~= "Local" then
				return;
			end;
			return true;
		end);
		v17.Scripts = l__ReadOnly__13(v18, nil, nil, true);
		local v24 = {};
		local l__G_API__31 = l__client__2.G_API;
		local l__Allowed_API_Calls__32 = l__client__2.Allowed_API_Calls;
		function v24.__index(p12, p13)
			if p13 == "Scripts" then
				return v17.Scripts;
			end;
			if not l__G_API__31 or l__Allowed_API_Calls__32.Client ~= true then
				l__error__20("_G API is disabled");
				return;
			end;
			if l__type__18(v17[p13]) ~= "function" then
				return v17[p13];
			end;
			return l__MetaFunc__11(v17[p13]);
		end;
		function v24.__newindex(p14, p15, p16)
			l__error__20("Read-only");
		end;
		v24.__metatable = "API";
		AdonisGTable = l__service__9.NewProxy(v24);
		if not l___G__16.Adonis then
			l__rawset__23(l___G__16, "Adonis", AdonisGTable);
			l__service__9.StartLoop("APICheck", 1, function()
				l__rawset__23(l___G__16, "Adonis", AdonisGTable);
			end, true);
		end;
	end;
	l__client__2.Core = v1;
end;

