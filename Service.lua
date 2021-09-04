server = nil;
client = nil;
Pcall = nil;
cPcall = nil;
Routine = nil;
local v1 = {};
local u1 = {};
local u2 = nil;
function v1.__index(p1, p2)
	return function(p3, ...)
		local v2, v3 = pcall(function()
			return p3.ClassName;
		end);
		if v2 and v3 and p3[p2] and type(p3[p2]) == "function" then
			if not u1[v3] then
				u1[v3] = {};
			end;
			if not u1[v3][p2] then
				u1[v3][p2] = p3[p2];
			end;
			if (u1[v3][p2] ~= p3[p2] or pcall(function()
				return coroutine.create(p3[p2]);
			end)) and u2 then
				u2("MethodError", debug.traceback() .. " || Cached method doesn't match found method: " .. tostring(p2), "Method: " .. tostring(p2), p2);
			end;
			return u1[v3][p2](p3, ...);
		end;
		return p3[p2](p3, ...);
	end;
end;
v1.__metatable = "Methods";
local u3 = nil;
local u4 = setmetatable({}, v1);
return function(p4, p5, p6)
	u3 = server or client;
	u2 = p4;
	server = nil;
	client = nil;
	local v4 = Instance.new("Folder");
	local v5 = Instance.new("Folder");
	local v6 = Instance.new("Folder");
	local v7 = Instance.new("Folder");
	local v8 = {};
	local u5 = nil;
	local l__new__6 = Instance.new;
	function v8.new(p7, p8)
		if u5 then
			local v9 = client and u5.Wrap(l__new__6(p7, u5.UnWrap(p8)), true) or l__new__6(p7, p8);
		else
			v9 = l__new__6(p7, p8);
		end;
		return v9;
	end;
	local v10 = {};
	local l__math__7 = math;
	local l__string__8 = string;
	local l__os__9 = os;
	local u10 = {};
	local l__pcall__11 = pcall;
	local l__unpack__12 = unpack;
	local l__coroutine__13 = coroutine;
	function v10.TrackTask(p9, p10, ...)
		local v11 = nil;
		if u3 and u3.Functions then
			local v12 = u3.Functions:GetRandom() or l__math__7.random();
		else
			v12 = l__math__7.random();
		end;
		local v13 = l__string__8.sub(p9, 1, 7) == "Thread:";
		local u14 = {
			Name = p9, 
			Status = "Waiting", 
			Function = p10, 
			isThread = v13, 
			Created = l__os__9.time(), 
			Index = v12
		};
		v11 = function(...)
			u10[v12] = u14;
			u14.Status = "Running";
			u14.Returns = { l__pcall__11(p10, ...) };
			if not u14.Returns[1] then
				u14.Status = "Errored";
			else
				u14.Status = "Finished";
			end;
			u10[v12] = nil;
			return l__unpack__12(u14.Returns);
		end;
		if not v13 then
			return v11(...);
		end;
		u14.Thread = l__coroutine__13.create(v11);
		return l__coroutine__13.resume(u14.Thread, ...);
	end;
	function v10.EventTask(p11, p12)
		local l__TrackTask__15 = u5.TrackTask;
		return function(...)
			return l__TrackTask__15(p11, p12, ...);
		end;
	end;
	function v10.GetTasks()
		return u10;
	end;
	local u16 = {};
	local l__next__17 = next;
	local l__table__18 = table;
	local l__wait__19 = wait;
	function v10.TaskScheduler(p13, p14)
		local v14 = p14 or {};
		if not v14.Temporary and u16[p13] then
			return u16[p13];
		end;
		local u20 = {
			Name = p13, 
			Running = true, 
			Properties = v14, 
			LinkedTasks = {}, 
			RunnerEvent = u5.New("BindableEvent"), 
			Trigger = function(p15, p16, ...)
				p16.Event:Fire(...);
			end, 
			Delete = function(p17, p18)
				if not v14.Temporary then
					u16[p13] = nil;
				end;
				u20.Running = false;
				u20.Event:Disconnect();
			end
		};
		u20.Event = u20.RunnerEvent.Event:Connect(function()
			for v15, v16 in l__next__17, u20.LinkedTasks do
				local v17, v18 = l__pcall__11(v16);
				if v18 then
					l__table__18.remove(u20.LinkedTasks, v15);
				end;
			end;
		end);
		if v14.Interval then
			while l__wait__19(v14.Interval) and u20.Running do
				u20:Trigger(l__os__9.time());			
			end;
		end;
		if not v14.Temporary then
			u16[p13] = u20;
		end;
		return u20;
	end;
	v10.Events = setmetatable({}, {
		__index = function(p19, p20)
			return u5.GetEvent(p20);
		end
	});
	local u21 = {};
	local l__tick__22 = tick;
	local u23 = {};
	local l__pairs__24 = pairs;
	function v10.CheckEvents(p21)
		return "Disabled";
	end;
	function v10.ForEach(p22, p23)
		for v19, v20 in l__next__17, p22 do
			p23(p22, v19, v20);
		end;
	end;
	local l__type__25 = type;
	function v10.WrapEventArgs(p24)
		local l__Wrap__21 = u5.Wrap;
		local l__UnWrap__22 = u5.UnWrap;
		local l__Wrapped__23 = u5.Wrapped;
		for v24, v25 in l__next__17, p24 do
			if l__type__25(v25) == "table" and v25.__ISWRAPPED and v25.__OBJECT then
				p24[v24] = l__Wrap__21(v25.__OBJECT);
			end;
		end;
		return p24;
	end;
	function v10.UnWrapEventArgs(p25)
		local l__Wrap__26 = u5.Wrap;
		local l__UnWrap__27 = u5.UnWrap;
		local l__Wrapped__28 = u5.Wrapped;
		for v29, v30 in l__next__17, p25 do
			if l__Wrapped__28(v30) then
				p25[v29] = {
					__ISWRAPPED = true, 
					__OBJECT = l__UnWrap__27(v30)
				};
			end;
		end;
		return p25;
	end;
	local l__warn__26 = warn;
	local l__tostring__27 = tostring;
	function v10.GetEvent(p26)
		if u23[p26] then
			return u23[p26];
		end;
		local l__Wrap__31 = u5.Wrap;
		local l__Wrapped__32 = u5.Wrapped;
		local v33 = l__Wrap__31(u5.New("BindableEvent"), client);
		local u28 = {};
		v33.Event:Connect(function(...)
			local v34, v35 = l__next__17(u28, nil);
			if not v34 then
				return;
			end;
			return v35.Function(...);
		end);
		local l__UnWrap__29 = u5.UnWrap;
		local l__WrapEventArgs__30 = u5.WrapEventArgs;
		v33:SetSpecial("Wait", function(p27, p28)
			local v36 = nil;
			local v37 = l__math__7.random();
			if p28 and l__type__25(p28) == "number" and p28 > 0 then
				local u31 = false;
				Routine(function()
					l__wait__19(p28);
					if not u31 then
						l__UnWrap__29(v33):Fire(v37);
					end;
				end);
			end;
			while true do
				v36 = { l__UnWrap__29(v33.Event):Wait() };
				if v36[1] == 2 then
					break;
				end;
				if v36[1] == v37 then
					break;
				end;			
			end;
			if v36[1] ~= v37 then
				return l__unpack__12(l__WrapEventArgs__30(v36), 2);
			end;
			l__warn__26("Event waiter timed out [" .. l__tostring__27(p28) .. "]");
			return nil;
		end);
		local l__UnWrapEventArgs__32 = u5.UnWrapEventArgs;
		v33:SetSpecial("Fire", function(p29, ...)
			l__UnWrap__29(v33):Fire(2, l__unpack__12(l__UnWrapEventArgs__32({ ... })));
		end);
		v33:SetSpecial("ConnectOnce", function(p30, p31)
			local u33 = nil;
			u33 = v33:Connect(function(...)
				u33:Disconnect();
				p31(...);
			end);
			return nil;
		end);
		v33:SetSpecial("Connect", function(p32, p33)
			local u34 = l__math__7.random();
			local v38 = l__Wrap__31(l__UnWrap__29(v33.Event):Connect(function(p34, ...)
				if p34 == 2 or p34 == u34 then
					p33(l__unpack__12(l__WrapEventArgs__30({ ... })));
				end;
			end), client);
			v38:SetSpecial("Fire", function(p35, ...)
				l__UnWrap__29(v33):Fire(u34, l__unpack__12(l__UnWrapEventArgs__32({ ... })));
			end);
			v38:SetSpecial("Wait", function(p36, p37)
				local v39 = nil;
				while true do
					v39 = { l__UnWrap__29(v33.Event):Wait(p37) };
					if v39[1] == 2 then
						break;
					end;
					if v39[1] == u34 then
						break;
					end;				
				end;
				return l__unpack__12(l__WrapEventArgs__30(v39), 2);
			end);
			v38:SetSpecial("wait", v33.Wait);
			v38:SetSpecial("disconnect", v38.Disconnect);
			return v38;
		end);
		v33:SetSpecial("fire", v33.Fire);
		v33:SetSpecial("wait", v33.Wait);
		v33:SetSpecial("connect", v33.Connect);
		v33:SetSpecial("connectOnce", v33.ConnectOnce);
		v33:SetSpecial("Event", u5.Wrap(v33.Event, client));
		v33.Event:SetSpecial("Wait", v33.Wait);
		v33.Event:SetSpecial("wait", v33.Wait);
		v33.Event:SetSpecial("Connect", v33.Connect);
		v33.Event:SetSpecial("connect", v33.Connect);
		u23[p26] = v33;
		return v33;
	end;
	function v10.HookEvent(p38, p39, p40)
		if l__type__25(p38) ~= "string" or l__type__25(p39) ~= "function" then
			l__warn__26("Invalid argument supplied; HookEvent(string, function)");
			return;
		end;
		return u5.GetEvent(p38):Connect(p39);
	end;
	function v10.FireEvent(p41, ...)
		local v40 = u23[p41];
		return v40 and v40:Fire(...);
	end;
	function v10.RemoveEvents(p42)
		local v41 = u23[p42];
		if v41 then
			u23[p42] = nil;
			v41:Destroy();
		end;
	end;
	local v42 = {
		Tasks = {}, 
		Threads = {}, 
		CheckTasks = function()
			for v43, v44 in l__next__17, u5.Threads.Tasks do
				if not v44.Thread or v44:Status() == "dead" then
					v44:Remove();
				end;
			end;
		end, 
		NewTask = function(p43, p44, p45)
			local v45 = l__math__7.random() * l__tick__22() / 1000;
			local v46 = v45 .. ":" .. l__tostring__27(p44);
			local v47 = {
				PID = v45, 
				Name = p43, 
				Index = v46, 
				Created = l__os__9.time(), 
				Changed = {}, 
				Timeout = p45 and 0, 
				Running = false, 
				Function = p44, 
				R_Status = "Idle", 
				Finished = {}
			};
			local u35 = nil;
			function v47.Function(...)
				u35.R_Status = "Running";
				u35.Running = true;
				local v48 = { p44(...) };
				u35.R_Status = "Finished";
				u35.Running = false;
				u35.Remove();
				return l__unpack__12(v48);
			end;
			function v47.Remove()
				u35.R_Status = "Removed";
				u35.Running = false;
				for v49, v50 in l__pairs__24(u5.Threads.Tasks) do
					if v50 == u35 then
						l__table__18.remove(u5.Threads.Tasks, v49);
					end;
				end;
				u35.Changed:fire("Removed");
				u35.Finished:fire();
				u5.RemoveEvents(v46 .. "_TASKCHANGED");
				u5.RemoveEvents(v46 .. "_TASKFINISHED");
				u35.Thread = nil;
			end;
			v47.Thread = u5.Threads.Create(function(...)
				return u35.Function(...);
			end);
			function v47.Resume(...)
				u35.R_Status = "Resumed";
				u35.Running = true;
				u35.Changed:fire("Resumed");
				local v51 = { u5.Threads.Resume(u35.Thread, ...) };
				if not v51[1] then
					u2("TaskError", v51[2]);
					u35.Changed:fire("Errored", v51[2]);
					u35.Remove();
				end;
				return l__unpack__12(v51);
			end;
			function v47.Status()
				if u35.Timeout ~= 0 and u35.Timeout < l__os__9.time() - u35.Created then
					u35:Stop();
					return "timeout";
				end;
				return u5.Threads.Status(u35.Thread);
			end;
			function v47.Pause()
				u35.R_Status = "Paused";
				u35.Running = false;
				u5.Threads.Pause(u35.Thread);
				u35.Changed:fire("Paused");
			end;
			function v47.Stop()
				u35.R_Status = "Stopping";
				u5.Threads.Stop(u35.Thread);
				u35.Changed:fire("Stopped");
				u35.Remove();
			end;
			function v47.Kill()
				u35.R_Status = "Killing";
				u5.Threads.End(u35.Thread);
				u35.Changed:fire("Killed");
				u35.Remove();
			end;
			u35 = v47;
			u35.Changed.Connect = function(p46, p47)
				return u5.Events[v46 .. "_TASKCHANGED"]:Connect(p47);
			end;
			u35.Changed.fire = function(p48, ...)
				u5.Events[v46 .. "_TASKCHANGED"]:fire(...);
			end;
			u35.Finished.Connect = function(p49, p50)
				return u5.Events[v46 .. "_TASKFINISHED"]:Connect(p50);
			end;
			u35.Finished.wait = function(p51)
				u5.Events[v46 .. "_TASKFINISHED"]:wait(0);
			end;
			u35.Finished.fire = function(p52, ...)
				u5.Events[v46 .. "_TASKFINISHED"]:fire(...);
			end;
			u35.End = u35.Stop;
			u35.Kill = u35.Stop;
			l__table__18.insert(u5.Threads.Tasks, u35);
			u5.Threads.CheckTasks();
			return u35.Resume, u35;
		end, 
		RunTask = function(p53, p54, ...)
			local v52, v53 = u5.Threads.NewTask(p53, p54);
			return v53, v52(...);
		end, 
		TimeoutRunTask = function(p55, p56, p57, ...)
			local v54, v55 = u5.Threads.NewTask(p55, p56, p57);
			return v55, v54(...);
		end, 
		WaitTask = function(p58, p59, ...)
			local v56, v57 = u5.Threads.NewTask(p58, p59);
			local v58 = { v56(...) };
			v57.Finished:wait();
			return v57, l__unpack__12(v58);
		end, 
		NewEventTask = function(p60, p61, p62)
			return function(...)
				if not u5.Running then
					return function()

					end;
				end;
				return u5.Threads.NewTask(p60, p61, p62)(...);
			end;
		end, 
		Stop = l__coroutine__13.yield, 
		Wait = l__coroutine__13.yield, 
		Pause = l__coroutine__13.yield, 
		Yield = l__coroutine__13.yield, 
		Status = l__coroutine__13.status, 
		Running = l__coroutine__13.running, 
		Create = l__coroutine__13.create, 
		Start = l__coroutine__13.resume, 
		Wrap = l__coroutine__13.wrap, 
		Get = l__coroutine__13.running, 
		New = function(p63)
			local v59 = l__coroutine__13.create(p63);
			l__table__18.insert(u5.Threads.Threads, v59);
			return v59;
		end, 
		End = function(p64)
			while p64 and u5.Threads.Status(p64) ~= "dead" do
				u5.Threads.Stop(p64);
				u5.Threads.Resume(p64);
				if not p64 then
					return;
				end;
				if u5.Threads.Status(p64) == "dead" then
					return;
				end;			
			end;
			p64 = false;
		end, 
		Wrap = function(p65, ...)
			local v60 = u5.Threads.New(p65);
			u5.Threads.Resume(p65, ...);
			return v60;
		end, 
		Resume = function(p66, ...)
			if not p66 or l__coroutine__13.status(p66) ~= "suspended" then
				return;
			end;
			return l__coroutine__13.resume(p66, ...);
		end, 
		Remove = function(p67)
			u5.Threads.Stop(p67);
			for v61, v62 in l__pairs__24(u5.Threads.Threads) do
				if v62 == p67 then
					l__table__18.remove(u5.Threads.Threads, v61);
				end;
			end;
		end, 
		StopAll = function()
			for v63, v64 in l__pairs__24(u5.Threads.Threads) do
				u5.Threads.Stop(v64);
				l__table__18.remove(u5.Threads.Threads, v63);
			end;
		end, 
		ResumeAll = function()
			for v65, v66 in l__pairs__24(u5.Threads.Threads) do
				u5.Threads.Resume(v66);
			end;
		end, 
		GetAll = function()
			return u5.Threads.Threads;
		end
	};
	local v67 = {};
	local l__setmetatable__36 = setmetatable;
	function v67.WrapIgnore(p68)
		return l__setmetatable__36(p68, {
			__metatable = "Ignore"
		});
	end;
	local u37 = setmetatable({}, {
		__mode = "kv"
	});
	function v67.CheckWrappers()
		for v68, v69 in l__next__17, u37 do
			if u5.IsDestroyed(v68) then
				u37[v68] = nil;
			end;
		end;
	end;
	local l__getmetatable__38 = getmetatable;
	function v67.Wrapped(p69)
		return l__getmetatable__38(p69) == "Adonis_Proxy";
	end;
	function v67.UnWrap(p70)
		if l__type__25(p70) ~= "table" then
			if u5.Wrapped(p70) then
				return p70:GetObject();
			else
				return p70;
			end;
		end;
		local v70 = {};
		for v71, v72 in l__next__17, p70 do
			v70[v71] = u5.UnWrap(v72);
		end;
		return v70;
	end;
	local l__typeof__39 = typeof;
	local l__newproxy__40 = newproxy;
	local u41 = setmetatable({}, {
		__mode = "v"
	});
	function v67.Wrap(p71, p72)
		local v73 = p72;
		if not v73 then
			v73 = false;
			if p72 == nil then
				v73 = client ~= nil;
			end;
		end;
		p72 = v73;
		if l__getmetatable__38(p71) == "Ignore" or l__getmetatable__38(p71) == "ReadOnly_Table" then
			return p71;
		end;
		if u37[p71] then
			return u37[p71];
		end;
		if l__type__25(p71) == "table" then
			local v74 = {};
			function v74.__eq(p73, p74)
				return p71;
			end;
			local v75 = l__setmetatable__36({}, v74);
			for v76, v77 in l__next__17, p71 do
				v75[v76] = u5.Wrap(v77, p72);
			end;
			return v75;
		end;
		if (l__typeof__39(p71) == "Instance" or l__typeof__39(p71) == "RBXScriptSignal" or l__typeof__39(p71) == "RBXScriptConnection") and not u5.Wrapped(p71) then
			if not p72 then
				local v78 = function(...)
					return ...;
				end;
				if not v78 then
					v78 = function(p75)
						return u5.Wrap(p75, p72);
					end;
				end;
			else
				v78 = function(p75)
					return u5.Wrap(p75, p72);
				end;
			end;
			local v79 = l__newproxy__40(true);
			local v80 = {};
			local u42 = l__getmetatable__38(v79);
			function v80.GetMetatable()
				return u42;
			end;
			function v80.AddToCache()
				u37[p71] = v79;
			end;
			function v80.IsRobloxLocked()
				return u3.Anti.RLocked(p71);
			end;
			function v80.RemoveFromCache()
				u37[p71] = nil;
			end;
			function v80.GetObject()
				return p71;
			end;
			local u43 = nil;
			function v80.SetSpecial(p76, p77, p78)
				u43[p77] = p78;
			end;
			function v80.Clone(p79, p80)
				local v81 = p71:Clone();
				if not p80 then
					l__table__18.insert(u41, v81);
				end;
				return u5.Wrap(v81);
			end;
			function v80.connect(p81, p82)
				return v78(p71:Connect(function(...)
					return p82(l__unpack__12(u5.Wrap({ ... })));
				end));
			end;
			function v80.wait(p83, ...)
				return v78(p71.wait)(p71, ...);
			end;
			u43 = v80;
			u43.Connect = u43.connect;
			u43.Wait = u43.wait;
			function u42.__tostring()
				return u43.ToString or l__tostring__27(p71);
			end;
			u42.__metatable = "Adonis_Proxy";
			local l__UnWrap__44 = u5.UnWrap;
			function u42.__index(p84, p85)
				local v82 = u43[p85] or p71[p85];
				if u43[p85] then
					return u43[p85];
				end;
				if l__type__25(v82) == "function" then
					return function(p86, ...)
						return l__unpack__12(v78({ u4[p85](p71, l__unpack__12(l__UnWrap__44({ ... }))) }));
					end;
				end;
				return v78(v82);
			end;
			function u42.__newindex(p87, p88, p89)
				p71[p88] = l__UnWrap__44(p89);
			end;
			function u42.__gc(p90)
				u43:RemoveFromCache();
			end;
			u42.__eq = u5.RawEqual;
			u43:AddToCache();
			return v79;
		end;
		return p71;
	end;
	local v83 = {
		CloneTable = function(p91)
			if l__getmetatable__38(p91) ~= nil then
				local v84 = {};
				function v84.__index(p92, p93)
					return p91[p93];
				end;
				local v85 = l__setmetatable__36({}, v84) or {};
			else
				v85 = {};
			end;
			for v86, v87 in l__next__17, p91 do
				v85[v86] = v87;
			end;
			return v85;
		end, 
		IsLocked = function(p94)
			return not l__pcall__11(function()
				p94.Name = p94.Name;
				return p94.Name;
			end);
		end, 
		Timer = function(p95, p96, p97)
			local u45 = l__tick__22();
			local u46 = nil;
			u46 = u5.RunService.RenderStepped:Connect(function()
				if p95 < l__tick__22() - u45 or p97 and p97() then
					p96();
					u46:Disconnect();
				end;
			end);
		end, 
		Unpack = function(p98, p99, p100)
			if not p100 and p98[p99 and 1] ~= nil or p100 and (p99 and 1) <= p100 then
				return p98[p99 and 1], u5.Unpack(p98, (p99 and 1) + 1, p100);
			end;
		end, 
		AltUnpack = function(p101, p102)
			if p102 then
				p102 = p102 - 1;
			end;
			return p101[1 + (p102 and 0)], p101[2 + (p102 and 0)], p101[3 + (p102 and 0)], p101[4 + (p102 and 0)], p101[5 + (p102 and 0)], p101[6 + (p102 and 0)], p101[7 + (p102 and 0)], p101[8 + (p102 and 0)], p101[9 + (p102 and 0)], p101[10 + (p102 and 0)];
		end, 
		ExtractLines = function(p103)
			local v88 = {};
			for v89 = 1, #p103 + 1 do
				if l__string__8.byte(p103:sub(v89, v89)) == 10 or v89 == #p103 + 1 then
					l__table__18.insert(v88, "");
					local v90 = "";
				else
					local v91 = p103:sub(v89, v89);
					if l__string__8.byte(v91) < 32 then
						v91 = "";
					end;
					v90 = "" .. v91;
				end;
			end;
			return v88;
		end, 
		Filter = function(p104, p105, p106)
			local v92 = nil;
			if not utf8.len(p104) then
				return "Filter Error";
			end;
			v92 = "";
			local v93 = u5.ExtractLines(p104);
			local v94 = #v93;
			local v95 = 1 - 1;
			while true do
				local v96 = nil;
				local u47 = v95;
				local v97, v98 = l__pcall__11(function()
					return u5.TextService:FilterStringAsync(v93[u47], p105.UserId):GetChatForUserAsync(p106.UserId);
				end);
				v96 = v97 and v98 or (v93[u47] or "");
				if u47 > 1 then
					local v99 = v92 .. "\n" .. v96;
				else
					v99 = v96;
				end;
				if 0 <= 1 then
					if not (u47 < v94) then
						break;
					end;
				elseif not (v94 < u47) then
					break;
				end;
				u47 = u47 + 1;			
			end;
			return v99 and "Filter Error";
		end
	};
	local l__tonumber__48 = tonumber;
	function v83.LaxFilter(p107, p108, p109)
		if l__tonumber__48(p107) then
			return p107;
		end;
		if l__type__25(p107) ~= "string" then
			return p107;
		end;
		if not utf8.len(p107) then
			return "Filter Error";
		end;
		if p109 and #u5.GetPlayers(p108, p107, {
			DontError = true
		}) > 0 then
			return p107;
		end;
		return u5.Filter(p107, p108, p108);
	end;
	function v83.BroadcastFilter(p110, p111)
		local v100 = nil;
		if not utf8.len(p110) then
			return "Filter Error";
		end;
		v100 = "";
		local v101 = u5.ExtractLines(p110);
		local v102 = #v101;
		local v103 = 1 - 1;
		while true do
			local v104 = nil;
			local u49 = v103;
			local v105, v106 = l__pcall__11(function()
				return u5.TextService:FilterStringAsync(v101[u49], p111.UserId):GetNonChatStringForBroadcastAsync();
			end);
			v104 = v105 and v106 or (v101[u49] or "");
			if u49 > 1 then
				local v107 = v100 .. "\n" .. v104;
			else
				v107 = v104;
			end;
			if 0 <= 1 then
				if not (u49 < v102) then
					break;
				end;
			elseif not (v102 < u49) then
				break;
			end;
			u49 = u49 + 1;		
		end;
		return v107 and "Filter Error";
	end;
	function v83.MetaFunc(p112)
		local v108 = {};
		function v108.__call(p113, ...)
			local v109 = { l__pcall__11(p112, ...) };
			if not v109[1] then
				l__warn__26(v109[2]);
				return;
			end;
			return l__unpack__12(v109, 2);
		end;
		return u5.NewProxy(v108);
	end;
	function v83.NewProxy(p114)
		local v110 = l__newproxy__40(true);
		local v111 = l__getmetatable__38(v110);
		v111.__metatable = false;
		for v112, v113 in l__next__17, p114 do
			v111[v112] = v113;
		end;
		return v110;
	end;
	function v83.GetUserType(p115)
		local v114, v115 = l__pcall__11(function()
			local v116 = p115[l__math__7.random()];
		end);
		if v114 then
			return "Unknown";
		end;
		return v115:match("%S+$");
	end;
	function v83.CountTable(p116)
		local v117 = 0;
		for v118, v119 in l__next__17, p116 do
			v117 = v117 + 1;
		end;
		return v117;
	end;
	local l__getfenv__50 = getfenv;
	local u51 = {};
	local l__error__52 = error;
	function v83.Debounce(p117, p118)
		local v120 = l__getfenv__50(2);
		local v121 = v120 and v120._ADONIS_DEBOUNCES or (u51 or {});
		if v120 then
			v120._ADONIS_DEBOUNCES = v120 and v120._ADONIS_DEBOUNCES or {};
		end;
		if v121[p117] then
			return false;
		end;
		v121[p117] = true;
		local v122, v123 = l__pcall__11(p118);
		v121[p117] = false;
		if not v122 then
			l__error__52(v123);
		end;
	end;
	local u53 = {};
	local l__select__54 = select;
	function v83.Queue(p119, p120, p121, p122)
		if not u53[p119] then
			u53[p119] = {
				Processing = false, 
				Functions = {}
			};
		end;
		local v124 = u53[p119];
		local v125 = {
			Time = l__os__9.time(), 
			Running = false, 
			Function = p120, 
			Timeout = p121, 
			Finished = false, 
			Yield = p122 and u5.Yield()
		};
		l__table__18.insert(v124.Functions, v125);
		if not v124.Processing then
			u5.TrackTask("Thread: QueueProcessor_" .. l__tostring__27(p119), u5.ProcessQueue, v124, p119);
		end;
		if not p122 or not (not v125.Finished) then
			return;
		end;
		return l__select__54(2, v125.Yield:Wait());
	end;
	local l__delay__55 = delay;
	function v83.ProcessQueue(p123, p124)
		if p123 then
			if p123.Processing then
				return "Processing";
			end;
			local v126 = u5.Yield();
			local l__Functions__56 = p123.Functions;
			local function v127()
				l__table__18.remove(l__Functions__56, 1);
				return l__Functions__56[1];
			end;
			p123.Processing = true;
			while l__Functions__56[1] ~= nil do
				local v128 = v127();
				v128.Running = true;
				if v128.Timeout then
					l__delay__55(v128.Timeout, function()
						if not v128.Finished then
							v126:Release();
							l__warn__26("Queue Timeout Reached for " .. l__tostring__27(p124 and "Unknown"));
							if v128.Yield then
								v128.Yield:Release(false, "Timeout Reached");
							end;
						end;
					end);
				end;
				u5.TrackTask("Thread: " .. l__tostring__27(p124 and "Unknown") .. "_QueuedFunction", function()
					local v129, v130 = l__pcall__11(v128.Function);
					if not v129 then
						v128.Error = v130;
						l__warn__26("Queue Error: " .. l__tostring__27(p124) .. ": " .. l__tostring__27(v130));
					end;
					v128.Running = false;
					v128.Finished = true;
					if v128.Yield then
						v128.Yield:Release(v129, v130);
					end;
					v126:Release();
				end);
				if v128.Running then
					v126:Wait();
				end;			
			end;
			v126:Destroy();
			p123.Processing = false;
			if p124 then
				u53[p124] = nil;
			end;
		end;
	end;
	local u57 = {};
	function v83.ProcessLoopQueue()
		for v131, v132 in l__next__17, u57 do
			if not v132.LastRun or v132.LastRun and v132.Delay < l__tick__22() - v132.LastRun then
				if v132.MaxRuns and v132.NumRuns and v132.MaxRuns <= v132.NumRuns then
					u57[v131] = nil;
				else
					if v132.MaxRuns and v132.NumRuns then
						v132.NumRuns = v132.NumRuns + 1;
					end;
					Pcall(v132.Function);
					v132.LastRun = l__tick__22();
				end;
			end;
		end;
	end;
	function v83.QueueItem(p125, p126)
		if p126.MaxRuns then
			p126.NumRuns = 0;
		end;
		u57[p125] = p126;
	end;
	function v83.RemoveQueue(p127)
		u57[p127] = nil;
	end;
	function v83.New(p128, p129)
		local v133 = v8.new(p128);
		if p129 then
			if l__type__25(p129) == "table" then
				local v134 = p129.Parent;
				if u5.Wrapped(v134) then
					v134 = v134:GetObject();
				end;
				p129.Parent = nil;
				for v135, v136 in l__pairs__24(p129) do
					v133[v135] = v136;
				end;
				if v134 then
					v133.Parent = v134;
				end;
			elseif l__type__25(p129) == "userdata" then
				if u5.Wrapped(p129) then
					v133.Parent = p129:GetObject();
				else
					v133.Parent = p129;
				end;
			end;
		end;
		if v133 then
			l__table__18.insert(u41, v133);
		end;
		return v133;
	end;
	function v83.Iterate(p130, p131)
		if p130 and l__type__25(p130) == "table" then
			for v137, v138 in l__next__17, p130 do
				local v139 = p131(v137, v138);
				if v139 ~= nil then
					return v139;
				end;
			end;
			return;
		end;
		if not p130 or l__type__25(p130) ~= "userdata" then
			l__error__52("Invalid table");
			return;
		end;
		local v140, v141 = p130:GetChildren();
		while true do
			local v142, v143 = l__next__17(v140, v141);
			if not v142 then
				break;
			end;
			v141 = v142;
			local v144 = p131(v143, v142);
			if v144 ~= nil then
				return v144;
			end;		
		end;
	end;
	function v83.GetTime()
		return l__os__9.time();
	end;
	function v83.FormatTime(p132, p133)
		local v145 = nil;
		if p133 then
			local v146 = "L LT";
		else
			v146 = "LT";
		end;
		v145 = DateTime.fromUnixTimestamp(p132 or u5.GetTime());
		if u5.RunService:IsServer() then
			return v145:FormatUniversalTime(v146, "en-gb");
		end;
		local l__LocaleId__58 = u5.Players.LocalPlayer.LocaleId;
		local v147, v148 = l__pcall__11(function()
			return v145:FormatLocalTime(v146, l__LocaleId__58);
		end);
		if not v148 then
			return;
		end;
		return v145:FormatLocalTime(v146, "en-gb");
	end;
	function v83.OwnsAsset(p134, p135)
		return u5.MarketPlace:PlayerOwnsAsset(p134, p135);
	end;
	function v83.MaxLen(p136, p137)
		if not (p137 < #p136) then
			return p136;
		end;
		return p136:sub(1, p137) .. "...";
	end;
	function v83.Yield()
		local v149 = {};
		local u59 = u5.New("BindableEvent");
		function v149.Release(...)
			u59:Fire(...);
		end;
		function v149.Wait(...)
			return u59.Event:Wait(...);
		end;
		function v149.Destroy()
			u59:Destroy();
		end;
		v149.Event = u59;
		return v149;
	end;
	local u60 = {};
	function v83.StartLoop(p138, p139, p140, p141)
		local v150 = nil;
		local u61 = {
			Name = p138, 
			Delay = p139, 
			Function = p140, 
			Running = true
		};
		local u62 = l__tostring__27(p138) .. " - " .. u3.Functions:GetRandom();
		local function u63()
			u61.Running = true;
			if u60[u62] == u61 then
				u60[u62] = nil;
			end;
		end;
		v150 = function()
			if l__tonumber__48(p139) then
				while true do
					p140();
					l__wait__19(l__tonumber__48(p139));
					if u60[u62] ~= u61 then
						break;
					end;
					if not u61.Running then
						break;
					end;				
				end;
				u63();
				return;
			end;
			if p139 == "Heartbeat" then
				while true do
					p140();
					u5.RunService.Heartbeat:wait();
					if u60[u62] ~= u61 then
						break;
					end;
					if not u61.Running then
						break;
					end;				
				end;
				u63();
				return;
			end;
			if p139 == "RenderStepped" then
				while true do
					p140();
					u5.RunService.RenderStepped:wait();
					if u60[u62] ~= u61 then
						break;
					end;
					if not u61.Running then
						break;
					end;				
				end;
				u63();
				return;
			end;
			if p139 ~= "Stepped" then
				u61.Running = false;
				return;
			end;
			while true do
				p140();
				u5.RunService.Stepped:wait();
				if u60[u62] ~= u61 then
					break;
				end;
				if not u61.Running then
					break;
				end;			
			end;
			u63();
		end;
		u61.Kill = u63;
		u60[u62] = u61;
		if p141 then
			u5.TrackTask("Thread: Loop: " .. p138, v150);
			return u61;
		end;
		u5.TrackTask("Loop: " .. p138, v150);
		return u61;
	end;
	function v83.StopLoop(p142)
		for v151, v152 in l__pairs__24(u60) do
			if p142 == v152.Function or p142 == v152.Name then
				v152.Running = false;
			end;
		end;
	end;
	function v83.FindClass(p143, p144)
		local v153, v154 = p143:GetChildren();
		while true do
			local v155, v156 = l__next__17(v153, v154);
			if not v155 then
				break;
			end;
			v154 = v155;
			if v156:IsA(p144) then
				return v156;
			end;		
		end;
	end;
	function v83.Immutable(...)
		local v157 = l__coroutine__13.wrap(function(...)
			while true do
				l__coroutine__13.yield(...);			
			end;
		end);
		v157(...);
		return v157;
	end;
	local l__rawset__64 = rawset;
	function v83.ReadOnly(p145, p146, p147, p148)
		local v158 = not p148 and u5.RunService:IsClient();
		local v159 = v158 and u5.Players.LocalPlayer;
		if v159 then
			local l__Kick__160 = v159.Kick;
		end;
		local l__resume__161 = l__coroutine__13.resume;
		local l__create__162 = l__coroutine__13.create;
		if v158 then
			local v163 = {
				secret500 = true, 
				getrawmetatable = true, 
				setreadonly = true, 
				full_access = true, 
				elysianexecute = true, 
				decompile = true, 
				make_writable = true
			};
		end;
		local v164 = {};
		local l__settings__65 = l__getfenv__50().settings;
		local u66 = v158 and l__getmetatable__38(l__getfenv__50());
		function v164.__index(p149, p150)
			local v165 = v158 and (l__getfenv__50 and l__getfenv__50(2));
			if not v158 or (not v158 or not l__pcall__11(l__settings__65)) and l__getfenv__50 == l__getfenv__50 and l__getmetatable__38 == l__getmetatable__38 and l__pcall__11 == l__pcall__11 and v165 and l__type__25(v165) == "table" and l__getmetatable__38(v165) == u66 then
				if p145[p150] ~= nil and l__type__25(p145[p150]) == "table" and (not p146 or not p146[p150] and not p146[p145[p150]]) then
					return u5.ReadOnly(p145[p150], p146, p147, p148);
				else
					return p145[p150];
				end;
			end;
			u2("ReadError", "Tampering with Client [read rt0001]", "[" .. l__tostring__27(p150) .. " " .. l__tostring__27(v165) .. " " .. l__tostring__27(v165 and l__getmetatable__38(v165)) .. "]\n" .. l__tostring__27(debug.traceback()));
		end;
		function v164.__newindex(p151, p152, p153)
			local v166 = v158 and (l__getfenv__50 and l__getfenv__50(2));
			if not v158 or (not v158 or not l__pcall__11(l__settings__65)) and l__getfenv__50 == l__getfenv__50 and l__getmetatable__38 == l__getmetatable__38 and l__pcall__11 == l__pcall__11 and v166 and l__type__25(v166) == "table" and l__getmetatable__38(v166) == u66 then
				if not p146 or not p146[p152] and not p146[p145[p152]] then
					if p147 then
						u2("ReadError", "Tampering with Client [write wt0005]", "[" .. l__tostring__27(p152) .. " " .. l__tostring__27(v166) .. " " .. l__tostring__27(v166 and l__getmetatable__38(v166)) .. "]\n" .. l__tostring__27(debug.traceback()));
					end;
					l__warn__26("Something attempted to set index " .. l__tostring__27(p152) .. " in a read-only table.");
					return;
				else
					l__rawset__64(p145, p152, p153);
					return;
				end;
			end;
			u2("ReadError", "Tampering with Client [write wt0003]", "[" .. l__tostring__27(p152) .. " " .. l__tostring__27(v166) .. " " .. l__tostring__27(v166 and l__getmetatable__38(v166)) .. "]\n" .. l__tostring__27(debug.traceback()));
		end;
		v164.__metatable = "ReadOnly_Table";
		function v164.__gc()

		end;
		return u5.NewProxy(v164);
	end;
	function v83.Wait(p154)
		if not p154 or p154 == "Stepped" then
			u5.RunService.Stepped:wait();
			return;
		end;
		if p154 == "Heartbeat" then
			u5.RunService.Heartbeat:wait();
			return;
		end;
		if p154 and l__tonumber__48(p154) then
			l__wait__19(l__tonumber__48(p154));
		end;
	end;
	function v83.ForEach(p155, p156)
		for v167, v168 in l__next__17, p155 do
			p156(p155, v167, v168);
		end;
		return p155;
	end;
	v83.OrigRawEqual = rawequal;
	function v83.ForEach(p157, p158)
		for v169, v170 in l__next__17, p157 do
			p158(p157, v169, v170);
		end;
		return p157;
	end;
	function v83.HasItem(p159, p160)
		return l__pcall__11(function()
			return p159[p160];
		end);
	end;
	local l__game__67 = game;
	function v83.IsDestroyed(p161)
		if l__type__25(p161) == "userdata" and u5.HasItem(p161, "Parent") and p161.Parent == nil then
			local v171, v172 = l__pcall__11(function()
				p161.Parent = l__game__67;
				p161.Parent = nil;
			end);
			if not v171 then
				if v172 and l__string__8.match(v172, "^The Parent property of (.*) is locked, current parent: NULL,") then
					return true;
				else
					return false;
				end;
			end;
		end;
		return false;
	end;
	function v83.Insert(p162, p163)
		local v173 = u5.InsertService:LoadAsset(p162);
		if not (not p163) or not v173:IsA("Model") or v173.Name ~= "Model" then
			return v173;
		end;
		local v174 = v173:GetChildren()[1];
		v174.Parent = v173.Parent;
		v173:Destroy();
		return v174;
	end;
	function v83.GetPlayers()
		return u5.Players:GetPlayers();
	end;
	function v83.IsAdonisObject(p164)
		for v175, v176 in l__next__17, u41 do
			if v176 == p164 then
				return true;
			end;
		end;
	end;
	function v83.GetAdonisObjects()
		return u41;
	end;
	local v177 = {};
	local u68 = {};
	function v177.Variables()
		return u68;
	end;
	v177.Routine = Routine;
	v177.Running = true;
	v177.Pcall = Pcall;
	v177.cPcall = cPcall;
	v177.Threads = v42;
	v177.DataModel = l__game__67;
	v177.WrapService = v4;
	v177.EventService = v7;
	v177.ThreadService = v5;
	v177.HelperService = v6;
	v177.MarketPlace = l__game__67:GetService("MarketplaceService");
	v177.GamepassService = l__game__67:GetService("GamePassService");
	v177.ChatService = l__game__67:GetService("Chat");
	v177.Gamepasses = l__game__67:GetService("GamePassService");
	function v177.Delete(p165, p166)
		l__game__67:GetService("Debris"):AddItem(p165, p166 and 0);
		l__pcall__11(p165.Destroy, p165);
	end;
	local u69 = {};
	function v177.RbxEvent(p167, p168)
		local v178 = p167:Connect(p168);
		l__table__18.insert(u69, v178);
		return v178;
	end;
	function v177.SelfEvent(p169, p170)
		local v179 = u5.RbxEvent(p169, function(...)
			p170(...);
		end);
	end;
	function v177.DelRbxEvent(p171)
		for v180, v181 in l__next__17, u69 do
			if v181 == p171 then
				v181:Disconnect();
				l__table__18.remove(u69, v180);
			end;
		end;
	end;
	function v177.SanitizeString(p172)
		p172 = u5.Trim(p172);
		local v182 = "";
		for v183 = 1, #p172 do
			if p172:sub(v183, v183) ~= "\n" and p172:sub(v183, v183) ~= "\000" then
				v182 = v182 .. p172:sub(v183, v183);
			end;
		end;
		return v182;
	end;
	function v177.Trim(p173)
		return p173:match("^%s*(.-)%s*$");
	end;
	function v177.Round(p174)
		return l__math__7.floor(p174 + 0.5);
	end;
	function v177.Localize(p175, p176)
		if l__type__25(p175) ~= "table" then
			return p175;
		end;
		local v184 = {};
		for v185, v186 in l__next__17, p175 do
			v184[v185] = u5.Localize(p175[v185], p176);
		end;
		return p176 and u5.ReadOnly(v184) or v184;
	end;
	function v177.RawEqual(p177, p178)
		return u5.UnWrap(p177) == u5.UnWrap(p178);
	end;
	function v177.CheckProperty(p179, p180)
		return l__pcall__11(function()
			return p179[p180];
		end);
	end;
	function v177.NewWaiter()
		local v187 = u5.New("BindableEvent");
		return {
			Wait = v187.wait, 
			Finish = v187.Fire
		};
	end;
	local v188 = {};
	function v188.__index(p181, p182)
		local v189 = nil;
		local v190 = p6 and p6[p182] or (v67[p182] or (v10[p182] or v83[p182]));
		if v190 then
			return v190;
		end;
		local v191 = nil;
		v191, v189 = l__pcall__11(function()
			local v192 = l__game__67:GetService(p182);
			return client ~= nil and u5.Wrap(v192, true) or v192;
		end);
		if not v191 or not v189 then
			return;
		end;
		u5[p182] = v189;
		return v189;
	end;
	v188.__tostring = "Service";
	v188.__metatable = "Service";
	u5 = l__setmetatable__36(v177, v188);
	local v193 = v67.Wrap(v4);
	local v194 = v67.Wrap(v6);
	local v195 = v67.Wrap(v5);
	local v196 = v67.Wrap(v7);
	u5.WrapService = v193;
	u5.HelperService = v194;
	u5.ThreadService = v195;
	u5.EventService = v196;
	if client ~= nil then
		for v197, v198 in l__next__17, u5 do
			if l__type__25(v198) == "userdata" then
				u5[v197] = u5.Wrap(v198, true);
			end;
		end;
	end;
	for v199, v200 in l__next__17, v67 do
		if l__type__25(v200) == "function" then
			v193:SetSpecial(v199, function(p183, ...)
				return v200(...);
			end);
		else
			v193:SetSpecial(v199, v200);
		end;
	end;
	for v201, v202 in l__next__17, v83 do
		if l__type__25(v202) == "function" then
			v194:SetSpecial(v201, function(p184, ...)
				return v202(...);
			end);
		else
			v194:SetSpecial(v201, v202);
		end;
	end;
	for v203, v204 in l__next__17, v42 do
		if l__type__25(v204) == "function" then
			v195:SetSpecial(v203, function(p185, ...)
				return v204(...);
			end);
		else
			v195:SetSpecial(v203, v204);
		end;
	end;
	for v205, v206 in l__next__17, v10 do
		if l__type__25(v206) == "function" then
			v196:SetSpecial(v205, function(p186, ...)
				return v206(...);
			end);
		else
			v196:SetSpecial(v205, v206);
		end;
	end;
	for v207, v208 in l__next__17, {
		WrapService = v193, 
		EventService = v196, 
		ThreadService = v195, 
		HelperService = v194
	} do
		v208:SetSpecial("ClassName", v207);
		v208:SetSpecial("ToString", v207);
		v208:SetSpecial("IsA", function(p187, p188)
			return p188 == v207;
		end);
	end;
	return nil;
end;

