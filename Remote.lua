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
	local l__delay__9 = delay;
	local l__service__10 = service;
	local l__warn__11 = warn;
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
			u8.Init = nil;
		end, 
		RunLast = function()
			u8.RunLast = nil;
		end, 
		RunAfterLoaded = function()
			log("~! Fire client loaded");
			l__client__2.Remote.Send("ClientLoaded");
			log("~! Start ClientCheck loop");
			l__delay__9(5, function()
				l__service__10.StartLoop("ClientCheck", 30, u8.CheckClient, true);
			end);
			log("Get settings");
			local v2 = l__client__2.Remote.Get("Setting", { "G_API", "Allowed_API_Calls", "HelpButtonImage" });
			if v2 then
				l__client__2.G_API = v2.G_API;
				l__client__2.Allowed_API_Calls = v2.Allowed_API_Calls;
				l__client__2.HelpButtonImage = v2.HelpButtonImage;
			else
				log("~! GET SETTINGS FAILED?");
				l__warn__11("FAILED TO GET SETTINGS FROM SERVER");
			end;
			u8.RunAfterLoaded = nil;
		end, 
		Returns = {}, 
		PendingReturns = {}, 
		EncodeCache = {}, 
		DecodeCache = {}, 
		Received = 0, 
		Sent = 0
	};
	local l__os__12 = os;
	function v1.CheckClient()
		if l__os__12.time() - u4.LastUpdate >= 10 then
			u8.Send("ClientCheck", {
				Sent = u8.Sent and 0, 
				Received = u8.Received
			}, l__client__2.DepsName);
		end;
	end;
	local v3 = {};
	local l__unpack__13 = unpack;
	function v3.Test(p1)
		return "HELLO FROM THE CLIENT SIDE :)! ", l__unpack__13(p1);
	end;
	function v3.Ping(p2)
		return u8.Ping();
	end;
	function v3.ClientHooked(p3)
		return u4.Special;
	end;
	local l__next__14 = next;
	local l__tostring__15 = tostring;
	local l__table__16 = table;
	function v3.TaskManager(p4)
		if p4[1] ~= "GetTasks" then
			return;
		end;
		local v4 = {};
		local v5, v6 = l__service__10.GetTasks();
		while true do
			local v7, v8 = l__next__14(v5, v6);
			if not v7 then
				break;
			end;
			v6 = v7;
			l__table__16.insert(v4, {
				Status = v8.Status, 
				Name = v8.Name, 
				Index = v8.Index, 
				Created = v8.Created, 
				CurrentTime = l__os__12.time(), 
				Function = l__tostring__15(v8.Function)
			});		
		end;
		return v4;
	end;
	function v3.LoadCode(p5)
		local v9 = u4.LoadCode(p5[1], GetEnv());
		if not v9 then
			return;
		end;
		return v9();
	end;
	local l__type__17 = type;
	function v3.Function(p6)
		local v10 = l__client__2.Functions[p6[1]];
		if not v10 or l__type__17(v10) ~= "function" then
			return;
		end;
		return v10(l__unpack__13(p6, 2));
	end;
	function v3.Handler(p7)
		local v11 = l__client__2.Handlers[p7[1]];
		if not v11 or l__type__17(v11) ~= "function" then
			return;
		end;
		return v11(l__unpack__13(p7, 2));
	end;
	function v3.UIKeepAlive(p8)
		if u5.UIKeepAlive then
			for v12, v13 in l__next__14, l__client__2.GUIs do
				if v13.KeepAlive then
					if v13.Class == "ScreenGui" or v13.Class == "GuiMain" then
						v13.Object.Parent = l__service__10.Player.PlayerGui;
					elseif v13.Class == "TextLabel" then
						v13.Object.Parent = u1.GetHolder();
					end;
					v13.KeepAlive = false;
				end;
			end;
		end;
		return true;
	end;
	function v3.UI(p9)
		local v14 = p9[2];
		u5.LastServerTheme = v14 or u5.LastServerTheme;
		return u1.Make(p9[1], p9[3], v14);
	end;
	function v3.InstanceList(p10)
		local v15 = {};
		for v16, v17 in l__next__14, l__service__10.GetAdonisObjects() do
			l__table__16.insert(v15, {
				Text = v17:GetFullName(), 
				Desc = v17.ClassName
			});
		end;
		return v15;
	end;
	local l__Enum__18 = Enum;
	local l__Color3__19 = Color3;
	function v3.ClientLog(p11)
		local u20 = {};
		local function v18(p12, p13, p14)
			local v19, v20 = l__service__10.ExtractLines(p12);
			while true do
				local v21, v22 = l__next__14(v19, v20);
				if not v21 then
					break;
				end;
				v20 = v21;
				l__table__16.insert(u20, {
					Text = v22, 
					Desc = p13 .. v22, 
					Color = p14
				});			
			end;
		end;
		local v23, v24 = l__service__10.LogService:GetLogHistory();
		while true do
			local v25, v26 = l__next__14(v23, v24);
			if not v25 then
				break;
			end;
			local l__messageType__27 = v26.messageType;
			if l__messageType__27 == l__Enum__18.MessageType.MessageWarning then
				local v28 = "Warning";
			elseif l__messageType__27 == l__Enum__18.MessageType.MessageInfo then
				v28 = "Info";
			elseif l__messageType__27 == l__Enum__18.MessageType.MessageError then
				v28 = "Error";
			else
				v28 = "Output";
			end;
			if l__messageType__27 == l__Enum__18.MessageType.MessageWarning then
				local v29 = l__Color3__19.new(0.866667, 0.733333, 0.0509804);
				if not v29 then
					if l__messageType__27 == l__Enum__18.MessageType.MessageInfo then
						v29 = l__Color3__19.new(0.054902, 0.305882, 1);
						if not v29 then
							v29 = false;
							if l__messageType__27 == l__Enum__18.MessageType.MessageError then
								v29 = l__Color3__19.new(1, 0.196078, 0.054902);
							end;
						end;
					else
						v29 = false;
						if l__messageType__27 == l__Enum__18.MessageType.MessageError then
							v29 = l__Color3__19.new(1, 0.196078, 0.054902);
						end;
					end;
				end;
			elseif l__messageType__27 == l__Enum__18.MessageType.MessageInfo then
				v29 = l__Color3__19.new(0.054902, 0.305882, 1);
				if not v29 then
					v29 = false;
					if l__messageType__27 == l__Enum__18.MessageType.MessageError then
						v29 = l__Color3__19.new(1, 0.196078, 0.054902);
					end;
				end;
			else
				v29 = false;
				if l__messageType__27 == l__Enum__18.MessageType.MessageError then
					v29 = l__Color3__19.new(1, 0.196078, 0.054902);
				end;
			end;
			v18(v26.message, v28 .. " - ", v29);		
		end;
		return u20;
	end;
	v1.Returnables = v3;
	local v30 = {};
	local l__print__21 = print;
	local l__wait__22 = wait;
	function v30.LightingChange(p15, p16)
		l__print__21(p15, "TICKLE ME!?");
		u5.LightingChanged = true;
		l__service__10.Lighting[p15] = p16;
		u3.LastChanges.Lighting = p15;
		l__wait__22(0.1);
		u5.LightingChanged = false;
		l__print__21("TICKLED :)", u5.LightingChanged);
		if u3.LastChanges.Lighting == p15 then
			u3.LastChanges.Lighting = nil;
		end;
	end;
	v1.UnEncrypted = v30;
	local v31 = {};
	local l__pcall__23 = pcall;
	function v31.GetReturn(p17)
		l__print__21("THE SERVER IS ASKING US FOR A RETURN");
		local v32 = p17[2];
		local v33 = { l__unpack__13(p17, 3) };
		local v34 = u8.Returnables[p17[1]];
		if v34 then
			local v35 = { l__pcall__23(v34, v33) } or {};
		else
			v35 = {};
		end;
		if v35[1] == true then
			l__print__21("SENT RETURN");
			u8.Send("GiveReturn", v32, l__unpack__13(v35, 2));
			return;
		end;
		logError(v35[2]);
		u8.Send("GiveReturn", v32, "__ADONIS_RETURN_ERROR", v35[2]);
	end;
	function v31.GiveReturn(p18)
		l__print__21("SERVER GAVE US A RETURN");
		if u8.PendingReturns[p18[1]] then
			l__print__21("VALID PENDING RETURN");
			u8.PendingReturns[p18[1]] = nil;
			l__service__10.Events[p18[1]]:fire(l__unpack__13(p18, 2));
		end;
	end;
	function v31.SessionData(p19)
		local v36 = p19[1];
		if v36 then
			l__service__10.Events.SessionData:Fire(v36, l__table__16.unpack(p19, 2));
		end;
	end;
	function v31.SetVariables(p20)
		for v37, v38 in l__next__14, p20[1] do
			u5[v37] = v38;
		end;
	end;
	function v31.Print(p21)
		l__print__21(l__unpack__13(p21));
	end;
	function v31.FireEvent(p22)
		l__service__10.FireEvent(l__unpack__13(p22));
	end;
	function v31.Test(p23)
		l__print__21("OK WE GOT COMMUNICATION!  ORGL: " .. l__tostring__15(p23[1]));
	end;
	local l__error__24 = error;
	function v31.TestError(p24)
		l__error__24("THIS IS A TEST ERROR");
	end;
	function v31.TestEvent(p25)
		u8.PlayerEvent(p25[1], l__unpack__13(p25, 2));
	end;
	function v31.LoadCode(p26)
		local v39 = u4.LoadCode(p26[1], GetEnv());
		if not v39 then
			return;
		end;
		return v39();
	end;
	function v31.LaunchAnti(p27)
		u3.Launch(p27[1], p27[2]);
	end;
	function v31.UI(p28)
		local v40 = p28[2];
		u5.LastServerTheme = v40 or u5.LastServerTheme;
		u1.Make(p28[1], p28[3], v40);
	end;
	function v31.RemoveUI(p29)
		u1.Remove(p29[1], p29[2]);
	end;
	function v31.StartLoop(p30)
		local v41 = p30[1];
		local v42 = p30[2];
		local v43 = p30[3];
		local v44 = u4.LoadCode(v43, GetEnv());
		if v41 and v42 and v43 and v44 then
			l__service__10.StartLoop(v41, v42, v44);
		end;
	end;
	function v31.StopLoop(p31)
		l__service__10.StopLoop(p31[1]);
	end;
	function v31.Function(p32)
		local v45 = l__client__2.Functions[p32[1]];
		if v45 and l__type__17(v45) == "function" then
			Pcall(v45, l__unpack__13(p32, 2));
		end;
	end;
	function v31.Handler(p33)
		local v46 = l__client__2.Handlers[p33[1]];
		if v46 and l__type__17(v46) == "function" then
			Pcall(v46, l__unpack__13(p33, 2));
		end;
	end;
	v1.Commands = v31;
	function v1.Fire(...)
		local l__RateLimits__47 = u7.RateLimits;
		local l__RemoteEvent__48 = u4.RemoteEvent;
		if l__RemoteEvent__48 and l__RemoteEvent__48.Object then
			local u25 = { ... };
			local u26 = l__RateLimits__47 and l__RateLimits__47.Remote or 0.01;
			l__service__10.Queue("REMOTE_SEND", function()
				u8.Sent = u8.Sent + 1;
				l__RemoteEvent__48.Object:FireServer({
					Mode = "Fire", 
					Module = l__client__2.Module, 
					Loader = l__client__2.Loader, 
					Sent = u8.Sent, 
					Received = u8.Received
				}, l__unpack__13(u25));
				l__wait__22(u26);
			end);
		end;
	end;
	function v1.Send(p34, ...)
		u4.LastUpdate = l__os__12.time();
		u8.Fire(u8.Encrypt(p34, u4.Key), ...);
	end;
	function v1.GetFire(...)
		local l__RemoteEvent__49 = u4.RemoteEvent;
		local l__RateLimits__50 = u7.RateLimits;
		if l__RemoteEvent__49 and l__RemoteEvent__49.Function then
			local u27 = nil;
			local u28 = { ... };
			local u29 = l__service__10.Yield();
			local u30 = l__RateLimits__50 and l__RateLimits__50.Remote or 0.02;
			l__service__10.Queue("REMOTE_SEND", function()
				u8.Sent = u8.Sent + 1;
				l__delay__9(0, function()
					u27 = { l__RemoteEvent__49.Function:InvokeServer({
							Mode = "Get", 
							Module = l__client__2.Module, 
							Loader = l__client__2.Loader, 
							Sent = u8.Sent, 
							Received = u8.Received
						}, l__unpack__13(u28)) };
					u29:Release(u27);
				end);
				l__wait__22(u30);
			end);
			if not u27 then
				u29:Wait();
			end;
			u29:Destroy();
			if u27 then
				return l__unpack__13(u27);
			end;
		end;
	end;
	function v1.RawGet(...)
		local l__RemoteEvent__51 = u4.RemoteEvent;
		if not l__RemoteEvent__51 or not l__RemoteEvent__51.Function then
			return;
		end;
		u8.Sent = u8.Sent + 1;
		return l__RemoteEvent__51.Function:InvokeServer({
			Mode = "Get", 
			Module = l__client__2.Module, 
			Loader = l__client__2.Loader, 
			Sent = u8.Sent, 
			Received = u8.Received
		}, l__unpack__13({ ... }));
	end;
	function v1.Get(p35, ...)
		u4.LastUpdate = l__os__12.time();
		local v52 = u8.GetFire(u8.Encrypt(p35, u4.Key), ...);
		if l__type__17(v52) ~= "table" then
			return v52;
		end;
		return l__unpack__13(v52);
	end;
	local l__string__31 = string;
	function v1.OldGet(p36, ...)
		local v53 = u6:GetRandom();
		local u32 = nil;
		local u33 = l__service__10.New("BindableEvent");
		local v54 = l__service__10.Events[v53]:Connect(function(...)
			l__print__21("WE ARE GETTING A RETURN!");
			u32 = { ... };
			u33:Fire();
			l__wait__22();
			u33:Fire();
			u33:Destroy();
		end);
		u8.PendingReturns[v53] = true;
		u8.Send("GetReturn", p36, v53, ...);
		l__print__21(l__string__31.format("GETTING RETURNS? %s", l__tostring__15(u32)));
		u33.Event:Wait();
		l__print__21(l__string__31.format("WE GOT IT! %s", l__tostring__15(u32)));
		v54:Disconnect();
		if not u32 then
			return nil;
		end;
		if u32[1] ~= "__ADONIS_RETURN_ERROR" then
			return l__unpack__13(u32);
		end;
		l__error__24(u32[2]);
	end;
	local l__tick__34 = tick;
	local l__math__35 = math;
	function v1.Ping()
		if not u8.Get("Ping") then
			return false;
		end;
		return l__math__35.floor((l__tick__34() - l__tick__34()) * 1000 + 0.5) / 1000 * 1000;
	end;
	function v1.PlayerEvent(p37, ...)
		u8.Send("PlayerEvent", p37, ...);
	end;
	function v1.Encrypt(p38, p39, p40)
		p40 = p40 or (u8.EncodeCache or {});
		if not p39 or not p38 then
			return p38;
		end;
		if p40[p39] and p40[p39][p38] then
			return p40[p39][p38];
		end;
		local l__byte__55 = l__string__31.byte;
		local l__sub__56 = l__string__31.sub;
		local l__char__57 = l__string__31.char;
		local v58 = p40[p39] or {};
		local v59 = {};
		for v60 = 1, #p38 do
			local v61 = v60 % #p39 + 1;
			v59[v60] = l__char__57((l__byte__55(l__sub__56(p38, v60, v60)) + l__byte__55(l__sub__56(p39, v61, v61))) % 126 + 1);
		end;
		local v62 = l__table__16.concat(v59);
		p40[p39] = v58;
		v58[p38] = v62;
		return v62;
	end;
	function v1.Decrypt(p41, p42, p43)
		p43 = p43 or (u8.DecodeCache or {});
		if not p42 or not p41 then
			return p41;
		end;
		if p43[p42] and p43[p42][p41] then
			return p43[p42][p41];
		end;
		local v63 = p43[p42] or {};
		local l__byte__64 = l__string__31.byte;
		local l__sub__65 = l__string__31.sub;
		local l__char__66 = l__string__31.char;
		local v67 = {};
		for v68 = 1, #p41 do
			local v69 = v68 % #p42 + 1;
			v67[v68] = l__char__66((l__byte__64(l__sub__65(p41, v68, v68)) - l__byte__64(l__sub__65(p42, v69, v69))) % 126 - 1);
		end;
		local v70 = l__table__16.concat(v67);
		p43[p42] = v63;
		v63[p41] = v70;
		return v70;
	end;
	l__client__2.Remote = v1;
end;

