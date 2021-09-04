
-- Decompiled with the Synapse X Luau decompiler.

client = nil;
service = nil;
cPcall = nil;
Pcall = nil;
Routine = nil;
GetEnv = nil;
origEnv = nil;
logError = nil;
return function()
	local l__LocalPlayer__1 = service.Players.LocalPlayer;
	local v2 = tostring(getfenv);
	local u1 = nil;
	local l__client__2 = client;
	local u3 = nil;
	local u4 = nil;
	local u5 = nil;
	local l__service__6 = service;
	local l__wait__7 = wait;
	getfenv().client = nil;
	getfenv().service = nil;
	getfenv().script = nil;
	local l__NetworkClient__8 = service.NetworkClient;
	local l__pcall__9 = pcall;
	local l__Send__10 = client.Remote.Send;
	local l__Disconnect__11 = client.Disconnect;
	local l__Kill__12 = client.Kill;
	local v3 = getfenv();
	local l__game__13 = game;
	local v4, v5 = l__pcall__9(function()
		return l__game__13:________();
	end);
	local function u14(p1, p2, p3)
		if l__NetworkClient__8 and p1 ~= "_" then
			l__pcall__9(l__Send__10, "Detected", p1, p2);
			l__wait__7(0.5);
			if p1 == "kick" then
				if not l__service__6.RunService:IsStudio() then
					if p3 then
						l__LocalPlayer__1:Kick(p2);
					else
						l__Disconnect__11(p2);
					end;
				end;
			elseif p1 == "crash" then
				l__Kill__12(p2);
			end;
		end;
		return true;
	end;
	local u15 = v4;
	local l__rawequal__16 = rawequal;
	local u17 = v5;
	local u18 = v3;
	local l__Kick__19 = l__LocalPlayer__1.Kick;
	local l__xpcall__20 = xpcall;
	local l__pairs__21 = pairs;
	Routine(function()
		while l__wait__7(5) do
			if not u14("_", "_", true) then
				while true do
				
				end;
			end;
			if not (not u15) or not l__rawequal__16(u15, u15) or not l__rawequal__16(u17, u17) or not (not l__rawequal__16(u17, "new")) or not u17 == u17 or u17 == "new" or not (not l__rawequal__16(u18, { 1 })) or (u18 == { 1 } or not u18 == u18) then
				u14("crash", "Tamper Protection 658947");
				l__wait__7(1);
				l__pcall__9(l__Disconnect__11, "Adonis_658947");
				l__pcall__9(l__Kill__12, "Adonis_658947");
				l__pcall__9(l__Kick__19, l__LocalPlayer__1, "Adonis_658947");
			end;
			if l__xpcall__20(function()
				return l__game__13:________();
			end, function()

			end) then
				u14("crash", "Tamper Protection 906287");
				l__wait__7(1);
				l__pcall__9(l__Disconnect__11, "Adonis_906287");
				l__pcall__9(l__Kill__12, "Adonis_906287");
				l__pcall__9(l__Kick__19, l__LocalPlayer__1, "Adonis_906287");
			end;
			local v6, v7 = l__pcall__9(function()
				return l__game__13:________();
			end);
			if not v6 == u15 or not u17 == v7 then
				u14("kick", "Methamethod tampering 456456");
			end;
			local v8, v9, v10 = l__pairs__21({ "SentinelSpy", "ScriptDumper", "VehicleNoclip", "Strong Stand" });
			while true do
				local v11, v12 = v8(v9, v10);
				if not v11 then
					break;
				end;
				local v13 = l__LocalPlayer__1;
				if v13 then
					v13 = false;
					if l__LocalPlayer__1.Name ~= v12 then
						v13 = l__game__13:FindFirstChild(v12, true);
					end;
				end;
				if v13 then
					u14("log", "Malicious Object?: " .. v12);
				end;			
			end;		
		end;
	end);
	u18 = l__service__6.ReadOnly;
	u15 = {};
	local l__workspace__22 = workspace;
	local l__tonumber__23 = tonumber;
	u17 = function(p4)
		l__service__6.StartLoop("AntiSpeed", 1, function()
			if l__tonumber__23(p4.Speed) < l__workspace__22:GetRealPhysicsFPS() then
				u14("kill", "Speed exploiting");
			end;
		end);
	end;
	u15.Speed = u17;
	u17 = function(p5)
		local l__RealName__24 = p5.RealName;
		local l__RealID__25 = p5.RealID;
		l__service__6.StartLoop("NameIDCheck", 10, function()
			if l__service__6.Player.Name ~= l__RealName__24 then
				u14("log", "Local username does not match server username");
			end;
			if l__service__6.Player.userId ~= l__RealID__25 then
				u14("log", "Local userID does not match server userID");
			end;
		end);
	end;
	u15.NameId = u17;
	u17 = function()
		l__service__6.Player.DescendantAdded:Connect(function(p6)
			if p6:IsA("GuiMain") or p6:IsA("PlayerGui") and l__rawequal__16(p6.Parent, l__service__6.PlayerGui) and not u1.Get(p6) then
				p6:Destroy();
				u14("log", "Unknown GUI detected and destroyed");
			end;
		end);
	end;
	u15.AntiGui = u17;
	local l__Enum__26 = Enum;
	u17 = function()
		if l__service__6.Player:WaitForChild("Backpack", 120) then
			local function v14(p7)
				if (p7:IsA("Tool") or p7.ClassName == "HopperBin") and not p7:FindFirstChild(u4.CodeName) and l__client__2.AntiBuildingTools and p7.ClassName == "HopperBin" and (not (not l__rawequal__16(p7.BinType, l__Enum__26.BinType.Grab)) or not (not l__rawequal__16(p7.BinType, l__Enum__26.BinType.Clone)) or not (not l__rawequal__16(p7.BinType, l__Enum__26.BinType.Hammer)) or l__rawequal__16(p7.BinType, l__Enum__26.BinType.GameTool)) then
					p7.Active = false;
					p7:Destroy();
					u14("log", "HopperBin detected (Building Tools)");
				end;
			end;
			for v15, v16 in l__pairs__21(l__service__6.Player.Backpack:GetChildren()) do
				v14(v16);
			end;
			l__service__6.Player.Backpack.ChildAdded:Connect(v14);
		end;
	end;
	u15.AntiTools = u17;
	u17 = function()
		l__wait__7(1);
		local v17 = l__service__6.Player.Character:WaitForChild("Humanoid", 2) or l__service__6.Player.Character:FindFirstChildOfClass("Humanoid");
		if v17 then
			local u27 = true;
			local u28 = nil;
			u28 = v17.StateChanged:Connect(function(p8, p9)
				if not u27 then
					u28:Disconnect();
				end;
				if l__rawequal__16(p9, l__Enum__26.HumanoidStateType.StrafingNoPhysics) and u27 then
					u27 = false;
					u14("kill", "Noclipping");
					u28:Disconnect();
				end;
			end);
			while v17 and v17.Parent and v17.Parent.Parent and u27 do
				if not l__wait__7(0.1) then
					break;
				end;
				if l__rawequal__16(v17:GetState(), l__Enum__26.HumanoidStateType.StrafingNoPhysics) and u27 then
					u27 = false;
					u14("kill", "Noclipping");
				end;			
			end;
		end;
	end;
	u15.HumanoidState = u17;
	u17 = function()
		l__wait__7(1);
		local l__Character__18 = l__service__6.Player.Character;
		local l__Head__19 = l__Character__18:WaitForChild("Head");
		local l__HumanoidRootPart__20 = l__Character__18:WaitForChild("HumanoidRootPart", 2);
		local l__Humanoid__21 = l__Character__18:WaitForChild("Humanoid", 2);
		while l__Humanoid__21 and l__Head__19 and l__HumanoidRootPart__20 and l__rawequal__16(l__Head__19.Parent, l__Character__18) do
			if not l__rawequal__16(l__HumanoidRootPart__20.Parent, l__Character__18) then
				break;
			end;
			if l__Character__18.Parent == nil then
				break;
			end;
			if not (l__Humanoid__21.Health > 0) then
				break;
			end;
			if not l__Humanoid__21 then
				break;
			end;
			if not l__Humanoid__21.Parent then
				break;
			end;
			if not l__wait__7(1) then
				break;
			end;
			if (l__HumanoidRootPart__20.Position - l__Head__19.Position).Magnitude > 10 and l__Humanoid__21 and l__Humanoid__21.Health > 0 then
				u14("kill", "HumanoidRootPart too far from Torso (Paranoid?)");
			end;		
		end;
	end;
	u15.Paranoid = u17;
	local l__select__29 = select;
	local l__tick__30 = tick;
	local l__string__31 = string;
	local l__tostring__32 = tostring;
	local l__next__33 = next;
	local l__ipairs__34 = ipairs;
	local l__loadstring__35 = loadstring;
	local l__Instance__36 = Instance;
	u17 = function()
		local v22 = l__tick__30();
		local v23 = l__service__6.ReadOnly({
			FriendStatus = true, 
			ImageButton = false, 
			ButtonHoverText = true, 
			HoverMid = true, 
			HoverLeft = true, 
			HoverRight = true, 
			ButtonHoverTextLabel = true, 
			Icon = true, 
			ImageLabel = true, 
			NameLabel = true, 
			Players = true, 
			ColumnValue = true, 
			ColumnName = true, 
			Frame = false, 
			StatText = false
		});
		local u37 = { "current identity is 0", "gui made by kujo", "tetanus reloaded hooked", "newcclosure" };
		local u38 = l__select__29(2, l__pcall__9(l__service__6.RunService.IsStudio, l__service__6.RunService));
		local l__FindService__39 = l__service__6.DataModel.FindService;
		local l__DataModel__40 = l__service__6.DataModel;
		local function v24()
			if not l__pcall__9(function()
				if not u38 and (l__FindService__39("ServerStorage", l__DataModel__40) or l__FindService__39("ServerScriptService", l__DataModel__40)) then
					u14("crash", "Disallowed Services Detected");
				end;
			end) then
				u14("kick", "Finding Error");
			end;
		end;
		local u41 = { 5032588119 };
		v24();
		l__service__6.DataModel.ChildAdded:Connect(v24);
		local u42 = {};
		l__service__6.Events.CharacterRemoving:Connect(function()
			for v25, v26 in l__next__33, u42 do
				if v23[v25] then
					u42[v25] = 0;
				end;
			end;
		end);
		l__service__6.ScriptContext.ChildAdded:Connect(function(p10)
			if u3.GetClassName(p10) == "LocalScript" then
				u14("kick", "Localscript Detected; " .. l__tostring__32(p10));
			end;
		end);
		local function u43(p11)
			for v27, v28 in l__pairs__21(u41) do
				if p11.SoundId then
					if l__string__31.find(l__string__31.lower(l__tostring__32(p11.SoundId)), l__tostring__32(v28)) then
						return true;
					end;
					if p11.SoundId == l__tostring__32(v28) then
						return true;
					end;
				end;
			end;
			return false;
		end;
		l__service__6.PolicyService.ChildAdded:Connect(function(p12)
			if p12:IsA("Sound") then
				if not u43(p12) then
					l__wait__7();
					if u43(p12) then
						u14("crash", "CMDx Detected; " .. l__tostring__32(p12));
					end;
					return;
				end;
			else
				return;
			end;
			u14("crash", "CMDx Detected; " .. l__tostring__32(p12));
		end);
		l__service__6.ReplicatedFirst.ChildAdded:Connect(function(p13)
			if u3.GetClassName(p13) == "LocalScript" then
				u14("kick", "Localscript Detected; " .. l__tostring__32(p13));
			end;
		end);
		local function u44(p14)
			for v29, v30 in l__pairs__21(u37) do
				if l__string__31.find(l__string__31.lower(p14), l__string__31.lower(v30)) and not l__string__31.find(l__string__31.lower(p14), "failed to load") then
					return true;
				end;
			end;
		end;
		l__service__6.LogService.MessageOut:Connect(function(p15)
			if u44(p15) then
				u14("crash", "Exploit detected; " .. p15);
			end;
		end);
		l__service__6.Selection.SelectionChanged:Connect(function()
			u14("kick", "Selection changed");
		end);
		l__service__6.ScriptContext.Error:Connect(function(p16, p17, p18)
			local v31 = l__tostring__32(p16);
			local v32 = l__tostring__32(p17);
			local v33 = l__tostring__32(p18);
			if v33 and v33 == "tpircsnaisyle" then
				u14("kick", "Elysian");
				return;
			end;
			if not (not u44(v31)) or not (not u44(v32)) or u44(v33) then
				u14("crash", "Exploit detected; " .. v31 .. " " .. v32 .. " " .. v33);
				return;
			end;
			if not v33 or not v32 or v32 == "" then
				local v34 = l__service__6.LogService:GetLogHistory();
				local v35 = false;
				if v33 then
					for v36, v37 in l__next__33, v34 do
						if v37.message == v31 and v34[v36 + 1] and v34[v36 + 1].message == v32 then
							v35 = true;
						end;
					end;
				else
					v35 = true;
				end;
				if v35 then
					if not l__string__31.match(v32, "CoreGui") then
						if not (not l__string__31.match(v32, "PlayerScripts")) or not (not l__string__31.match(v32, "Animation_Scripts")) or l__string__31.match(v32, "^(%S*)%.(%S*)") then
							return;
						end;
						u14("log", "Traceless/Scriptless error");
					else
						return;
					end;
				end;
			end;
		end);
		local u45 = v22;
		l__service__6.RunService.Stepped:Connect(function()
			u45 = l__tick__30();
		end);
		if l__service__6.Player:WaitForChild("Backpack", 120) then
			l__service__6.Player.Backpack.ChildAdded:Connect(function(p19)
				if (p19:IsA("Tool") or p19.ClassName == "HopperBin") and not p19:FindFirstChild(u4.CodeName) and (l__service__6.Player:FindFirstChild("Backpack") and p19:IsDescendantOf(l__service__6.Player.Backpack) and p19.ClassName == "HopperBin") and (not (not l__rawequal__16(p19.BinType, l__Enum__26.BinType.Grab)) or not (not l__rawequal__16(p19.BinType, l__Enum__26.BinType.Clone)) or not (not l__rawequal__16(p19.BinType, l__Enum__26.BinType.Hammer)) or l__rawequal__16(p19.BinType, l__Enum__26.BinType.GameTool)) then
					u14("log", "Building tools detected; " .. l__tostring__32(p19.BinType));
				end;
			end);
		end;
		l__service__6.StartLoop("Detection", 10, function()
			if l__service__6.Player.Parent ~= l__service__6.Players then
				u14("crash", "Parent not players");
			end;
			local v38, v39 = l__pcall__9(function()
				l__service__6.ScriptContext.Name = "ScriptContext";
			end);
			if not v38 then
				u14("log", "ScriptContext error?");
			end;
			local v40 = l__service__6.LogService:GetLogHistory();
			if not v40[1] then
				l__client__2.OldPrint(" ");
				l__client__2.OldPrint(" ");
				v40 = l__service__6.LogService:GetLogHistory();
				local v41 = v40[1];
			end;
			for v42, v43 in l__ipairs__34(v40) do
				if u44(v43.message) then
					u14("crash", "Exploit detected");
				end;
			end;
			local v44, v45 = l__pcall__9(function()
				local v46, v47 = l__loadstring__35("print('LOADSTRING TEST')");
			end);
			if v44 then
				u14("crash", "Exploit detected; Loadstring usable");
			end;
			local v48, v49 = l__pcall__9(function()
				l__Instance__36.new("StringValue").RobloxLocked = true;
			end);
			if v48 then
				u14("crash", "RobloxLocked usable");
			end;
		end);
	end;
	u15.MainDetection = u17;
	u17 = false;
	u18 = u18(u15, u17, true);
	u15 = function(p20, p21)
		if u3.Detectors[p20] and l__service__6.NetworkClient then
			u3.Detectors[p20](p21);
		end;
	end;
	u17 = l__service__6.ReadOnly;
	local v50 = {
		LastChanges = {
			Lighting = {}
		}, 
		Init = function()
			u1 = l__client__2.UI;
			u3 = l__client__2.Anti;
			u4 = l__client__2.Variables;
			u5 = l__client__2.Process;
			u3.Init = nil;
		end, 
		RunLast = function()
			u3.RunLast = nil;
		end, 
		RunAfterLoaded = function()
			l__service__6.Player.Changed:Connect(function()
				if l__service__6.Player.Parent ~= l__service__6.Players then
					l__wait__7(5);
					return;
				end;
				if u3.RLocked(l__service__6.Player) then
					u3.Detected("kick", "Roblox Locked");
				end;
			end);
			u3.RunAfterLoaded = nil;
		end, 
		Launch = u15, 
		Detected = u14, 
		Detectors = u18
	};
	local l__math__46 = math;
	function v50.GetClassName(p22)
		local u47 = l__tostring__32(l__math__46.random() .. l__math__46.random());
		local v51, v52 = l__pcall__9(function()
			local v53 = p22[u47];
		end);
		if v52 then
			local v54 = l__string__31.match(v52, u47 .. " is not a valid member of (.*)");
			if v54 then
				return v54;
			end;
		end;
	end;
	function v50.RLocked(p23)
		return not l__pcall__9(function()
			return p23:GetFullName();
		end);
	end;
	function v50.ObjRLocked(p24)
		return not l__pcall__9(function()
			return p24:GetFullName();
		end);
	end;
	function v50.CoreRLocked(p25)
		local u48 = l__tostring__32(l__math__46.random() .. l__math__46.random());
		local v55, v56 = l__pcall__9(function()
			l__game__13:GetService("GuiService"):AddSelectionParent(u48, p25);
			l__game__13:GetService("GuiService"):RemoveSelectionGroup(u48);
		end);
		if v56 and l__string__31.find(v56, u48) and l__string__31.find(v56, "GuiService:") then
			return true;
		end;
		l__wait__7(0.5);
		local v57, v58 = l__service__6.LogService:GetLogHistory();
		while true do
			local v59, v60 = l__next__33(v57, v58);
			if not v59 then
				break;
			end;
			v58 = v59;
			if l__string__31.find(v60.message, u48) and l__string__31.find(v60.message, "GuiService:") then
				return true;
			end;		
		end;
	end;
	u17 = u17(v50, {
		Init = true, 
		RunLast = true, 
		RunAfterLoaded = true
	}, true);
	u3 = u17;
	l__client__2.Anti = u3;
	u17 = l__service__6.MetaFunc;
	local v61 = u17(l__tick__30);
	local u49 = u17(l__wait__7);
	local l__coroutine__50 = coroutine;
	local l__Core__51 = client.Core;
	local l__Remote__52 = client.Remote;
	local l__Functions__53 = client.Functions;
	local l__Get__54 = client.Remote.Get;
	local u55 = u17(l__pcall__9);
	u17(l__service__6.TrackTask)("Thread: TableCheck", u17(function()
		while u49(1) do
			local v62, v63, v64, v65, v66, v67, v68, v69, v70, v71 = l__coroutine__50.resume(l__coroutine__50.create(function()
				return l__client__2.Core, l__client__2.Remote, l__client__2.Functions, l__client__2.Anti, l__client__2.Remote.Send, l__client__2.Remote.Get, l__client__2.Anti.Detected, l__client__2.Disconnect, l__client__2.Kill;
			end));
			if not v62 or v63 ~= l__Core__51 or v64 ~= l__Remote__52 or v65 ~= l__Functions__53 or v66 ~= u3 or v67 ~= l__Send__10 or v68 ~= l__Get__54 or v69 ~= u14 or v70 ~= l__Disconnect__11 or v71 ~= l__Kill__12 then
				u55(u14, "crash", "Tamper Protection 10042");
				u49(1);
				u55(l__Disconnect__11, "Adonis_10042");
				u55(l__Kill__12, "Adonis_10042");
				u55(l__Kick__19, l__LocalPlayer__1, "Adonis_10042");
			end;		
		end;
	end));
end;

