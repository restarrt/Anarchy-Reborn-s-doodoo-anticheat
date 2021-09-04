
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
			u7.Init = nil;
		end, 
		RunLast = function()
			u7.RunLast = nil;
		end, 
		RunAfterLoaded = function(p1)
			l__service__9.Player.Chatted:Connect(l__service__9.EventTask("Event: ProcessChat", u7.Chat));
			l__service__9.Player.CharacterRemoving:Connect(l__service__9.EventTask("Event: CharacterRemoving", u7.CharacterRemoving));
			l__service__9.Player.CharacterAdded:Connect(l__service__9.Threads.NewEventTask("Event: CharacterAdded", u7.CharacterAdded));
			l__service__9.LogService.MessageOut:Connect(u7.LogService);
			l__service__9.ScriptContext.Error:Connect(u7.ErrorMessage);
			u7.RateLimits = u8.Get("RateLimits") or u7.RateLimits;
			u7.RunAfterLoaded = nil;
		end, 
		RateLimits = {
			Remote = 0.02, 
			Command = 0.1, 
			Chat = 0.1, 
			RateLog = 10
		}
	};
	local l__type__10 = type;
	local l__unpack__11 = unpack;
	function v1.Remote(p2, p3, ...)
		local v2 = { ... };
		u8.Received = u8.Received + 1;
		if l__type__10(p3) == "string" then
			if p3 == l__client__2.DepsName .. "GIVE_KEY" then
				if not u4.Key then
					log("~! Set remote key");
					u4.Key = v2[1];
					log("~! Call Finish_Loading()");
					l__client__2.Finish_Loading();
					return;
				end;
			else
				if u8.UnEncrypted[p3] then
					return { u8.UnEncrypted[p3](...) };
				end;
				if u4.Key then
					local v3 = u8.Decrypt(p3, u4.Key);
					local v4 = p2.Mode == "Get" and u8.Returnables[v3] or u8.Commands[v3];
					if v4 then
						local v5 = { l__service__9.TrackTask("Remote: " .. v3, v4, v2) };
						if not v5[1] then
							logError(v5[2]);
							return;
						else
							return { l__unpack__11(v5, 2) };
						end;
					end;
				end;
			end;
		end;
	end;
	function v1.LogService(p4, p5)

	end;
	local l__string__12 = string;
	local l__script__13 = script;
	local l__tostring__14 = tostring;
	function v1.ErrorMessage(p6, p7, p8)
		if p6 and p6 ~= "nil" and p6 ~= "" and (not (not l__string__12.find(p6, "::Adonis::")) or not (not l__string__12.find(p6, l__script__13.Name)) or p8 == l__script__13) then
			logError(l__tostring__14(p6) .. " - " .. l__tostring__14(p7));
		end;
		if (p8 == nil or not p7 or p7 == "") and p7 and not l__string__12.find(p7, "CoreGui.RobloxGui") then

		end;
	end;
	function v1.Chat(p9)
		if not l__service__9.Player or l__service__9.Player.Parent ~= l__service__9.Players then
			u8.Fire("ProcessChat", p9);
		end;
	end;
	function v1.CharacterAdded()
		u1.GetHolder();
		l__service__9.Events.CharacterAdded:fire();
	end;
	local l__next__15 = next;
	local l__pcall__16 = pcall;
	function v1.CharacterRemoving()
		if u5.UIKeepAlive then
			for v6, v7 in l__next__15, l__client__2.GUIs do
				if v7.Class == "ScreenGui" or v7.Class == "GuiMain" or v7.Class == "TextLabel" then
					if (not v7.Object:IsA("ScreenGui") or v7.Object.ResetOnSpawn) and v7.CanKeepAlive then
						v7.KeepAlive = true;
						v7.KeepParent = v7.Object.Parent;
						v7.Object.Parent = nil;
					elseif not v7.CanKeepAlive then
						l__pcall__16(v7.Destroy, v7);
					end;
				end;
			end;
		end;
		if u5.GuiViewFolder then
			u5.GuiViewFolder:Destroy();
			u5.GuiViewFolder = nil;
		end;
		if u5.ChatEnabled then
			l__service__9.StarterGui:SetCoreGuiEnabled("Chat", true);
		end;
		if u5.PlayerListEnabled then
			l__service__9.StarterGui:SetCoreGuiEnabled("PlayerList", true);
		end;
		local v8 = l__service__9.UserInputService:GetFocusedTextBox();
		if v8 then
			v8:ReleaseFocus();
		end;
		l__service__9.Events.CharacterRemoving:fire();
	end;
	l__client__2.Process = v1;
end;

