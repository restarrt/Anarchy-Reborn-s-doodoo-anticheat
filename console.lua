client = nil;
cPcall = nil;
Pcall = nil;
Routine = nil;
service = nil;
gTable = nil;
return function(p1)
	local l__PlayerGui__1 = service.Players.LocalPlayer.PlayerGui;
	local l__Parent__2 = script.Parent.Parent;
	local l__Frame__3 = l__Parent__2.Frame;
	local l__ScrollingFrame__4 = l__Parent__2.Frame.ScrollingFrame;
	local v5 = client.Remote.Get("Setting", { "SplitKey", "ConsoleKeyCode", "BatchKey", "Prefix" });
	local v6 = client.Remote.Get("FormattedCommands") or {};
	local v7 = TweenInfo.new(0.15);
	local v8 = service.TweenService:Create(l__Frame__3, v7, {
		Size = UDim2.new(1, 0, 0, 140)
	});
	local v9 = service.TweenService:Create(l__Frame__3, v7, {
		Size = UDim2.new(1, 0, 0, 40)
	});
	l__Frame__3.Position = UDim2.new(0, 0, 0, -200);
	l__Frame__3.Visible = false;
	l__Frame__3.Size = UDim2.new(1, 0, 0, 40);
	l__ScrollingFrame__4.Visible = false;
	if client.Variables.ConsoleOpen then
		if client.Variables.ChatEnabled then
			service.StarterGui:SetCoreGuiEnabled("Chat", true);
		end;
		if client.Variables.PlayerListEnabled then
			service.StarterGui:SetCoreGuiEnabled("PlayerList", true);
		end;
		if client.UI.Get("Notif") then
			client.UI.Get("Notif", nil, true).Object.LABEL.Visible = true;
		end;
		local v10 = client.UI.Get("Chat", nil, true);
		if v10 then
			v10.Object.Drag.Visible = true;
		end;
		local v11 = client.UI.Get("PlayerList", nil, true);
		if v11 then
			v11.Object.Drag.Visible = true;
		end;
		local v12 = client.UI.Get("HintHolder", nil, true);
		if v12 then
			v12.Object.Frame.Visible = true;
		end;
	end;
	client.Variables.ChatEnabled = service.StarterGui:GetCoreGuiEnabled("Chat");
	client.Variables.PlayerListEnabled = service.StarterGui:GetCoreGuiEnabled("PlayerList");
	local u1 = false;
	local l__PlayerList__2 = l__Parent__2.Frame.PlayerList;
	local u3 = service.TweenService:Create(l__Frame__3, v7, {
		Position = UDim2.new(0, 0, 0, -200)
	});
	local u4 = false;
	local u5 = service.TweenService:Create(l__Frame__3, v7, {
		Position = UDim2.new(0, 0, 0, 0)
	});
	local l__TextBox__6 = l__Parent__2.Frame.TextBox;
	local function u7()
		if l__Parent__2:IsDescendantOf(game) and not u1 then
			u1 = true;
			l__ScrollingFrame__4:ClearAllChildren();
			l__ScrollingFrame__4.CanvasSize = UDim2.new(0, 0, 0, 0);
			l__ScrollingFrame__4.ScrollingEnabled = false;
			l__Frame__3.Size = UDim2.new(1, 0, 0, 40);
			l__ScrollingFrame__4.Visible = false;
			l__PlayerList__2.Visible = false;
			scrollOpen = false;
			if client.Variables.ChatEnabled then
				service.StarterGui:SetCoreGuiEnabled("Chat", true);
			end;
			if client.Variables.PlayerListEnabled then
				service.StarterGui:SetCoreGuiEnabled("PlayerList", true);
			end;
			if client.UI.Get("Notif") then
				client.UI.Get("Notif", nil, true).Object.LABEL.Visible = true;
			end;
			local v13 = client.UI.Get("Chat", nil, true);
			if v13 then
				v13.Object.Drag.Visible = true;
			end;
			local v14 = client.UI.Get("PlayerList", nil, true);
			if v14 then
				v14.Object.Drag.Visible = true;
			end;
			local v15 = client.UI.Get("HintHolder", nil, true);
			if v15 then
				v15.Object.Frame.Visible = true;
			end;
			u3:Play();
			u1 = false;
			u4 = false;
		end;
	end;
	l__TextBox__6.FocusLost:Connect(function(p2)
		if p2 and l__TextBox__6.Text ~= "" and string.len(l__TextBox__6.Text) > 1 then
			client.Remote.Send("ProcessCommand", l__TextBox__6.Text);
		end;
		u7();
	end);
	local function u8()
		if l__Parent__2:IsDescendantOf(game) and not u1 then
			u1 = true;
			client.Variables.ChatEnabled = service.StarterGui:GetCoreGuiEnabled("Chat");
			client.Variables.PlayerListEnabled = service.StarterGui:GetCoreGuiEnabled("PlayerList");
			service.StarterGui:SetCoreGuiEnabled("Chat", false);
			service.StarterGui:SetCoreGuiEnabled("PlayerList", false);
			l__ScrollingFrame__4.ScrollingEnabled = true;
			l__PlayerList__2.ScrollingEnabled = true;
			if client.UI.Get("Notif") then
				client.UI.Get("Notif", nil, true).Object.LABEL.Visible = false;
			end;
			local v16 = client.UI.Get("Chat", nil, true);
			if v16 then
				v16.Object.Drag.Visible = false;
			end;
			local v17 = client.UI.Get("PlayerList", nil, true);
			if v17 then
				v17.Object.Drag.Visible = false;
			end;
			local v18 = client.UI.Get("HintHolder", nil, true);
			if v18 then
				v18.Object.Frame.Visible = false;
			end;
			u5:Play();
			l__Frame__3.Size = UDim2.new(1, 0, 0, 40);
			l__ScrollingFrame__4.Visible = false;
			l__PlayerList__2.Visible = false;
			scrollOpen = false;
			l__TextBox__6.Text = "";
			l__Frame__3.Visible = true;
			l__Frame__3.Position = UDim2.new(0, 0, 0, 0);
			l__TextBox__6:CaptureFocus();
			l__TextBox__6.Text = "";
			wait();
			l__TextBox__6.Text = "";
			u1 = false;
			u4 = true;
		end;
	end;
	local l__Prefix__9 = v5.Prefix;
	local l__BatchKey__10 = v5.BatchKey;
	local l__SplitKey__11 = v5.SplitKey;
	local l__Entry__12 = l__Parent__2.Entry;
	l__TextBox__6.Changed:Connect(function(p3)
		if p3 ~= "Text" or l__TextBox__6.Text == "" or not u8 then
			if p3 == "Text" and l__TextBox__6.Text == "" and u4 then
				v9:Play();
				l__ScrollingFrame__4.Visible = false;
				l__PlayerList__2.Visible = false;
				scrollOpen = false;
				l__ScrollingFrame__4:ClearAllChildren();
				l__ScrollingFrame__4.CanvasSize = UDim2.new(0, 0, 0, 0);
			end;
			return;
		end;
		if string.sub(l__TextBox__6.Text, string.len(l__TextBox__6.Text)) == "\t" then
			if l__PlayerList__2:FindFirstChild("Entry 0") then
				l__TextBox__6.Text = (string.sub(l__TextBox__6.Text, 1, string.len(l__TextBox__6.Text) - 1) .. l__PlayerList__2["Entry 0"].Text) .. " ";
			elseif l__ScrollingFrame__4:FindFirstChild("Entry 0") then
				l__TextBox__6.Text = string.split(l__ScrollingFrame__4["Entry 0"].Text, "<")[1];
			else
				l__TextBox__6.Text = l__TextBox__6.Text .. l__Prefix__9;
			end;
			l__TextBox__6.CursorPosition = string.len(l__TextBox__6.Text) + 1;
			l__TextBox__6.Text = string.gsub(l__TextBox__6.Text, "\t", "");
		end;
		l__ScrollingFrame__4:ClearAllChildren();
		l__PlayerList__2:ClearAllChildren();
		local v19 = l__TextBox__6.Text;
		if string.match(v19, ".*" .. l__BatchKey__10 .. "([^']+)") then
			v19 = string.match(string.match(v19, ".*" .. l__BatchKey__10 .. "([^']+)"), "^%s*(.-)%s*$");
		end;
		local v20 = 0;
		local v21 = string.match(v19, ".+" .. l__SplitKey__11 .. "(.*)$");
		local l__next__22 = next;
		local v23, v24 = service.Players:GetPlayers();
		while true do
			local v25, v26 = l__next__22(v23, v24);
			if not v25 then
				break;
			end;
			v24 = v25;
			if v21 then
				if string.sub(string.lower(tostring(v26)), 1, #v21) == string.lower(v21) or string.match(v19, l__SplitKey__11 .. "$") then
					local v27 = l__Entry__12:Clone();
					v27.Text = tostring(v26);
					v27.Name = "Entry " .. v20;
					v27.TextXAlignment = "Right";
					v27.Visible = true;
					v27.Parent = l__PlayerList__2;
					v27.Position = UDim2.new(0, 0, 0, 20 * v20);
					v27.MouseButton1Down:Connect(function()
						l__TextBox__6.Text = l__TextBox__6.Text .. tostring(v26);
						l__TextBox__6:CaptureFocus();
					end);
					v20 = v20 + 1;
				end;
			elseif string.match(v19, l__SplitKey__11 .. "$") then
				v27 = l__Entry__12:Clone();
				v27.Text = tostring(v26);
				v27.Name = "Entry " .. v20;
				v27.TextXAlignment = "Right";
				v27.Visible = true;
				v27.Parent = l__PlayerList__2;
				v27.Position = UDim2.new(0, 0, 0, 20 * v20);
				v27.MouseButton1Down:Connect(function()
					l__TextBox__6.Text = l__TextBox__6.Text .. tostring(v26);
					l__TextBox__6:CaptureFocus();
				end);
				v20 = v20 + 1;
			end;		
		end;
		l__PlayerList__2.CanvasSize = UDim2.new(0, 0, 0, v20 * 20);
		local v28 = 0;
		for v29, v30 in next, v6 do
			if string.sub(string.lower(v30), 1, #v19) == string.lower(v19) or string.find(string.lower(v30), string.match(string.lower(v19), "^(.-)" .. l__SplitKey__11) or string.lower(v19), 1, true) then
				if not scrollOpen then
					v8:Play();
					l__ScrollingFrame__4.Visible = true;
					l__PlayerList__2.Visible = true;
					scrollOpen = true;
				end;
				local v31 = l__Entry__12:Clone();
				v31.Visible = true;
				v31.Parent = l__ScrollingFrame__4;
				v31.Text = v30;
				v31.Name = "Entry " .. v28;
				v31.Position = UDim2.new(0, 0, 0, 20 * v28);
				v31.MouseButton1Down:Connect(function()
					l__TextBox__6.Text = v31.Text;
					l__TextBox__6:CaptureFocus();
				end);
				v28 = v28 + 1;
			end;
		end;
		l__Frame__3.Size = UDim2.new(1, 0, 0, math.clamp(v28 * 20 + 40, 40, 140));
		l__ScrollingFrame__4.CanvasSize = UDim2.new(0, 0, 0, v28 * 20);
	end);
	local l__ConsoleKeyCode__13 = v5.ConsoleKeyCode;
	gTable.BindEvent(service.UserInputService.InputBegan, function(p4)
		if not service.UserInputService:GetFocusedTextBox() and rawequal(p4.UserInputType, Enum.UserInputType.Keyboard) and p4.KeyCode.Name == (client.Variables.CustomConsoleKey or l__ConsoleKeyCode__13) then
			if u4 then
				u7();
			else
				u8();
			end;
			client.Variables.ConsoleOpen = u4;
		end;
	end);
	gTable:Ready();
end;

