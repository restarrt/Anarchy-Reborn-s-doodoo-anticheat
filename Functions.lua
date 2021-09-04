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
			u6.Init = nil;
		end, 
		RunLast = function()
			u6.RunLast = nil;
		end, 
		Kill = l__client__2.Kill, 
		ESPFaces = { "Front", "Back", "Top", "Bottom", "Left", "Right" }
	};
	local l__ipairs__9 = ipairs;
	local l__service__10 = service;
	local l__Instance__11 = Instance;
	local l__Vector3__12 = Vector3;
	local l__UDim2__13 = UDim2;
	local l__Color3__14 = Color3;
	local l__string__15 = string;
	local l__math__16 = math;
	local l__coroutine__17 = coroutine;
	local l__game__18 = game;
	local l__workspace__19 = workspace;
	local l__pairs__20 = pairs;
	local l__table__21 = table;
	function v1.ESPify(p1, p2)
		for v2, v3 in l__ipairs__9(p1:GetChildren()) do
			if v3:IsA("BasePart") then
				if v3.Name == "Head" and not v3:FindFirstChild("__ADONIS_NAMETAG") then
					local v4 = l__service__10.Players:GetPlayerFromCharacter(v3.Parent);
					if v4 then
						local v5 = l__Instance__11.new("BillboardGui");
						v5.Name = "__ADONIS_NAMETAG";
						v5.Adornee = v3;
						v5.AlwaysOnTop = true;
						v5.StudsOffset = l__Vector3__12.new(0, 2, 0);
						v5.Size = l__UDim2__13.new(0, 100, 0, 40);
						local v6 = l__Instance__11.new("TextLabel");
						local v7 = l__service__10.Player:DistanceFromCharacter(v3.Position);
						v6.BackgroundTransparency = 1;
						v6.TextColor3 = l__Color3__14.new(1, 1, 1);
						v6.TextStrokeTransparency = 0;
						v6.Text = l__string__15.format("%s (@%s)\n> %s <", v4.DisplayName, v4.Name, v7 and l__math__16.floor(v7) or "N/A");
						v6.Size = l__UDim2__13.new(1, 0, 1, 0);
						v6.TextScaled = true;
						v6.TextWrapped = true;
						v6.Parent = v5;
						v5.Parent = v3;
						if v4 ~= l__service__10.Player then
							l__coroutine__17.wrap(function()
								while v3 do
									local v8 = l__service__10.Player:DistanceFromCharacter(v3.CFrame.Position);
									v6.Text = l__string__15.format("%s (@%s)\n> %s <", v4.DisplayName, v4.Name, v8 and l__math__16.floor(v8) or "N/A");
									l__service__10.RunService.Heartbeat:Wait();
									if not v3 then
										break;
									end;
									if not v5 then
										break;
									end;
									if not v6 then
										break;
									end;								
								end;
							end)();
						end;
					end;
				end;
				for v9, v10 in l__ipairs__9(u6.ESPFaces) do
					local v11 = l__Instance__11.new("SurfaceGui");
					v11.Name = "__ADONISESP";
					v11.AlwaysOnTop = true;
					v11.ResetOnSpawn = false;
					v11.Adornee = v3;
					v11.Face = v10;
					local v12 = l__Instance__11.new("Frame");
					v12.Size = l__UDim2__13.new(1, 0, 1, 0);
					v12.BackgroundColor3 = p2 or l__Color3__14.fromRGB(255, 0, 234);
					v12.Parent = v11;
					v11.Parent = v3;
					v11.AncestryChanged:Connect(function()
						local v13 = nil;
						local v14 = nil;
						local v15 = nil;
						local v16 = nil;
						local v17 = nil;
						local v18 = nil;
						local v19 = nil;
						local v20 = nil;
						local v21 = nil;
						local v22 = nil;
						local v23 = nil;
						local v24 = nil;
						local v25 = nil;
						if not l__game__18.IsDescendantOf(v11, l__workspace__19) then
							l__service__10.Debris:AddItem(v11, 0);
							local v26, v27, v28 = l__pairs__20(u5.ESPObjects);
							while true do
								local v29 = nil;
								v13, v29 = v26(v27, v28);
								if not v13 then
									break;
								end;
								v28 = v13;
								if v29 == v11 then
									v14 = l__table__21;
									v15 = "remove";
									v16 = v14;
									v17 = v15;
									v22 = v16[v17];
									v18 = u5;
									local v30 = "ESPObjects";
									v19 = v18;
									v20 = v30;
									local v31 = v19[v20];
									v21 = v13;
									local v32 = v21;
									v23 = v22;
									v24 = v31;
									v25 = v32;
									v23(v24, v25);
									return;
								end;							
							end;
							return;
						else
							return;
						end;
						v14 = l__table__21;
						v15 = "remove";
						v16 = v14;
						v17 = v15;
						v22 = v16[v17];
						v18 = u5;
						v30 = "ESPObjects";
						v19 = v18;
						v20 = v30;
						v31 = v19[v20];
						v21 = v13;
						v32 = v21;
						v23 = v22;
						v24 = v31;
						v25 = v32;
						v23(v24, v25);
					end);
					u5.ESPObjects[v11] = v3;
				end;
			end;
		end;
	end;
	function v1.CharacterESP(p3, p4, p5)
		if u5.ESPEvent then
			u5.ESPEvent:Disconnect();
			u5.ESPEvent = nil;
		end;
		for v33, v34 in l__pairs__20(u5.ESPObjects) do
			if not p3 or not p4 or p4 and v33:IsDescendantOf(p4) then
				local v35 = v33.Parent and v33.Parent:FindFirstChild("__ADONIS_NAMETAG");
				if v35 then
					v35:Destroy();
				end;
				l__service__10.Debris:AddItem(v33, 0);
				u5.ESPObjects[v33] = nil;
			end;
		end;
		if p3 == true then
			if p4 then
				u6.ESPify(p4, p5);
				return;
			end;
		else
			return;
		end;
		u5.ESPEvent = l__workspace__19.ChildAdded:Connect(function(p6)
			l__service__10.RunService.Heartbeat:Wait();
			if p6:IsA("Model") and l__service__10.Players:GetPlayerFromCharacter(p6) then
				l__coroutine__17.wrap(u6.ESPify)(p6, p5);
			end;
		end);
		local v36, v37, v38 = l__ipairs__9(l__workspace__19:GetChildren());
		while true do
			local v39, v40 = v36(v37, v38);
			if not v39 then
				break;
			end;
			if v40:IsA("Model") and l__service__10.Players:GetPlayerFromCharacter(v40) then
				l__coroutine__17.wrap(u6.ESPify)(v40, p5);
			end;		
		end;
	end;
	local l__type__22 = type;
	function v1.GetRandom(p7)
		local l__random__41 = l__math__16.random;
		local l__format__42 = l__string__15.format;
		local v43 = {};
		for v44 = 1, l__type__22(p7) == "number" and p7 or l__random__41(5, 10) do
			v43[v44] = l__format__42("%02x", l__random__41(255));
		end;
		return l__table__21.concat(v43);
	end;
	function v1.Round(p8)
		return l__math__16.floor(p8 + 0.5);
	end;
	function v1.SetView(p9)
		if p9 ~= "reset" then
			l__workspace__19.CurrentCamera.CameraSubject = p9;
			return;
		end;
		l__workspace__19.CurrentCamera.CameraType = "Custom";
		l__workspace__19.CurrentCamera.CameraSubject = l__service__10.Player.Character.Humanoid;
		l__workspace__19.CurrentCamera.FieldOfView = 70;
	end;
	function v1.AddAlias(p10, p11)
		u5.Aliases[p10:lower()] = p11;
		u8.Get("UpdateAliases", u5.Aliases);
		spawn(function()
			u1.MakeGui("Notification", {
				Time = 5, 
				Title = "Notification", 
				Message = "Alias added"
			});
		end);
	end;
	function v1.RemoveAlias(p12)
		if not l__client__2.Variables.Aliases[p12:lower()] then
			spawn(function()
				u1.MakeGui("Notification", {
					Time = 5, 
					Title = "Notification", 
					Message = "Alias not found"
				});
			end);
			return;
		end;
		u5.Aliases[p12:lower()] = nil;
		u8.Get("UpdateAliases", u5.Aliases);
		spawn(function()
			u1.MakeGui("Notification", {
				Time = 5, 
				Title = "Notification", 
				Message = "Alias removed"
			});
		end);
	end;
	function v1.Playlist()
		return l__client__2.Remote.Get("Playlist");
	end;
	function v1.UpdatePlaylist(p13)
		l__client__2.Remote.Get("UpdatePlaylist", p13);
	end;
	local l__tick__23 = tick;
	local l__CFrame__24 = CFrame;
	function v1.Dizzy(p14)
		l__service__10.StopLoop("DizzyLoop");
		if p14 then
			local u25 = l__tick__23();
			local u26 = 0;
			local l__CurrentCamera__27 = l__workspace__19.CurrentCamera;
			l__service__10.StartLoop("DizzyLoop", "RenderStepped", function()
				u26 = u26 - l__math__16.rad(p14 * (l__tick__23() - u25));
				if not (u26 >= 2.5) and u26 <= -2.5 then

				end;
				l__CurrentCamera__27.CoordinateFrame = l__CurrentCamera__27.CoordinateFrame * l__CFrame__24.Angles(0, 0, u26);
				u25 = l__tick__23();
			end);
		end;
	end;
	function v1.Base64Encode(p15)
		local l__gsub__45 = l__string__15.gsub;
		local l__char__46 = l__string__15.char;
		local l__byte__28 = l__string__15.byte;
		local l__sub__29 = l__string__15.sub;
		return l__gsub__45(l__gsub__45(p15, ".", function(p16)
			local v47 = nil;
			v47 = "";
			local v48 = l__byte__28(p16);
			for v49 = 8, 1, -1 do
				if v48 % 2 ^ v49 - v48 % 2 ^ (v49 - 1) > 0 then
					local v50 = "1";
				else
					v50 = "0";
				end;
				v47 = v47 .. v50;
			end;
			return local v51;
		end) .. "0000", "%d%d%d?%d?%d?%d?", function(p17)
			local v52 = nil;
			if #p17 < 6 then
				return "";
			end;
			v52 = 0;
			for v53 = 1, 6 do
				v52 = v52 + (l__sub__29(p17, v53, v53) == "1" and 2 ^ (6 - v53) or 0);
			end;
			return l__sub__29("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", local v54 + 1, v54 + 1);
		end) .. ({ "", "==", "=" })[#p15 % 3 + 1];
	end;
	function v1.Base64Decode(p18)
		local l__gsub__55 = l__string__15.gsub;
		p18 = l__gsub__55(p18, "[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]", "");
		local l__find__30 = l__string__15.find;
		local l__sub__31 = l__string__15.sub;
		local l__char__32 = l__string__15.char;
		return l__gsub__55(l__gsub__55(p18, ".", function(p19)
			local v56 = nil;
			if p19 == "=" then
				return "";
			end;
			v56 = "";
			local v57 = l__find__30("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", p19) - 1;
			for v58 = 6, 1, -1 do
				if v57 % 2 ^ v58 - v57 % 2 ^ (v58 - 1) > 0 then
					local v59 = "1";
				else
					v59 = "0";
				end;
				v56 = v56 .. v59;
			end;
			return local v60;
		end), "%d%d%d?%d?%d?%d?%d?%d?", function(p20)
			local v61 = nil;
			if #p20 ~= 8 then
				return "";
			end;
			v61 = 0;
			for v62 = 1, 8 do
				v61 = v61 + (l__sub__31(p20, v62, v62) == "1" and 2 ^ (8 - v62) or 0);
			end;
			return l__char__32(local v63);
		end);
	end;
	local l__next__33 = next;
	local l__pcall__34 = pcall;
	function v1.GetGuiData(p21)
		local v64 = {
			Properties = {
				Name = "ViewGuis", 
				ClassName = "Folder"
			}, 
			Children = {}
		};
		local u35 = { "ScreenGui", "GuiMain", "Frame", "TextButton", "TextLabel", "ImageButton", "ImageLabel", "ScrollingFrame", "TextBox", "BillboardGui", "SurfaceGui" };
		local u36 = { "AbsolutePosition", "AbsoluteSize", "ClassName", "Name", "Parent", "Archivable", "SelectionImageObject", "Active", "BackgroundColor3", "BackgroundTransparency", "BorderColor3", "BorderSizePixel", "Position", "Rotation", "Selectable", "Size", "SizeConstraint", "Style", "Visible", "ZIndex", "ClipsDescendants", "Draggable", "NextSelectionDown", "NextSelectionLeft", "NextSelectionRight", "NextSelectionUp", "AutoButtonColor", "Modal", "Image", "ImageColor3", "ImageRectOffset", "ImageRectSize", "ImageTransparency", "ScaleType", "SliceCenter", "Text", "TextColor3", "Font", "TextScaled", "TextStrokeColor3", "TextStrokeTransparency", "TextTransparency", "TextWrapped", "TextXAlignment", "TextYAlignment" };
		local u37 = false;
		local function u38(p22, p23)
			if not u3.ObjRLocked(p23) then
				local v65 = false;
				for v66, v67 in l__next__33, u35 do
					if p23:IsA(v67) then
						v65 = true;
					end;
				end;
				if v65 then
					local v68 = {
						Properties = {}, 
						Children = {}
					};
					for v69, v70 in l__next__33, u36 do
						l__pcall__34(function()
							v68.Properties[v70] = p23[v70];
						end);
					end;
					local v71, v72 = p23:GetChildren();
					while true do
						local v73, v74 = l__next__33(v71, v72);
						if not v73 then
							break;
						end;
						v72 = v73;
						u38(v68, v74);					
					end;
					l__table__21.insert(p22.Children, v68);
					return;
				end;
			else
				u37 = true;
			end;
		end;
		local v75, v76 = l__service__10.PlayerGui:GetChildren();
		while true do
			local v77, v78 = l__next__33(v75, v76);
			if not v77 then
				break;
			end;
			v76 = v77;
			l__pcall__34(u38, v64, v78);		
		end;
		return v64;
	end;
	function v1.LoadGuiData(p24)
		local function u39(p25)
			local l__Properties__79 = p25.Properties;
			local v80 = l__service__10.New(l__Properties__79.ClassName);
			for v81, v82 in l__next__33, l__Properties__79 do
				l__pcall__34(function()
					v80[v81] = v82;
				end);
			end;
			for v83, v84 in l__next__33, p25.Children do
				l__pcall__34(function()
					local v85 = u39(v84);
					if v85 then
						v85.Parent = v80;
					end;
				end);
			end;
			return v80;
		end;
		local v86 = l__Instance__11.new("Folder");
		local v87, v88 = l__service__10.PlayerGui:GetChildren();
		while true do
			local v89, v90 = l__next__33(v87, v88);
			if not v89 then
				break;
			end;
			v88 = v89;
			if not u1.Get(v90) then
				v90.Parent = v86;
			end;		
		end;
		u5.GuiViewFolder = v86;
		local v91 = l__service__10.New("Folder", {
			Parent = l__service__10.PlayerGui, 
			Name = "LoadedGuis"
		});
		for v92, v93 in l__next__33, p24.Children do
			l__pcall__34(function()
				local v94 = u39(v93);
				if v94 then
					v94.Parent = v91;
				end;
			end);
		end;
	end;
	function v1.UnLoadGuiData()
		local v95, v96 = l__service__10.PlayerGui:GetChildren();
		while true do
			local v97, v98 = l__next__33(v95, v96);
			if not v97 then
				break;
			end;
			v96 = v97;
			if v98.Name == "LoadedGuis" then
				v98:Destroy();
			end;		
		end;
		if u5.GuiViewFolder then
			local v99, v100 = u5.GuiViewFolder:GetChildren();
			while true do
				local v101, v102 = l__next__33(v99, v100);
				if not v101 then
					break;
				end;
				v100 = v101;
				v102.Parent = l__service__10.PlayerGui;			
			end;
			u5.GuiViewFolder:Destroy();
			u5.GuiViewFolder = nil;
		end;
	end;
	function v1.GetParticleContainer(p26)
		if p26 then
			local v103, v104 = l__service__10.LocalContainer():GetChildren();
			while true do
				local v105, v106 = l__next__33(v103, v104);
				if not v105 then
					break;
				end;
				v104 = v105;
				if v106.Name == p26:GetFullName() .. "PARTICLES" and v106:FindFirstChild("_OBJECT").Value == p26 then
					return v106;
				end;			
			end;
		end;
	end;
	function v1.NewParticle(p27, p28, p29)
		p29.Parent = p27;
		p29.Enabled = u5.ParticlesEnabled;
		local v107 = l__service__10.New(p28, p29);
		local v108 = u6.GetRandom();
		u5.Particles[v108] = v107;
		l__table__21.insert(u5.Particles, v107);
		v107.Changed:Connect(function()
			if not v107 or not v107.Parent or v107.Parent ~= p27 then
				l__pcall__34(function()
					v107:Destroy();
				end);
				u5.Particles[v108] = nil;
			end;
		end);
	end;
	function v1.RemoveParticle(p30, p31)
		for v109, v110 in l__next__33, u5.Particles do
			if v110.Parent == p30 and v110.Name == p31 then
				v110:Destroy();
				u5.Particles[v109] = nil;
			end;
		end;
	end;
	function v1.EnableParticles(p32)
		local l__Particles__111 = u5.Particles;
		local v112 = nil;
		while true do
			local v113 = nil;
			local v114 = nil;
			v114, v113 = l__next__33(l__Particles__111, v112);
			if not v114 then
				break;
			end;
			v112 = v114;
			if p32 then
				v113.Enabled = true;
			else
				v113.Enabled = false;
			end;		
		end;
	end;
	function v1.NewLocal(p33, p34, p35)
		local v115 = l__service__10.New(p33);
		for v116, v117 in l__next__33, p34 do
			v115[v116] = v117;
		end;
		if not p35 or p35 == "LocalContainer" then
			v115.Parent = l__service__10.LocalContainer();
			return;
		end;
		if p35 == "Camera" then
			v115.Parent = l__service__10.Workspace.CurrentCamera;
			return;
		end;
		if p35 == "PlayerGui" then
			v115.Parent = l__service__10.PlayerGui;
		end;
	end;
	function v1.MakeLocal(p36, p37, p38)
		if p36 then
			local v118 = p36;
			if p38 then
				v118 = v118:Clone();
			end;
			if not p37 or p37 == "LocalContainer" then
				v118.Parent = l__service__10.LocalContainer();
				return;
			end;
			if p37 == "Camera" then
				v118.Parent = l__service__10.Workspace.CurrentCamera;
				return;
			end;
			if p37 == "PlayerGui" then
				v118.Parent = l__service__10.PlayerGui;
			end;
		end;
	end;
	function v1.MoveLocal(p39, p40, p41)
		local v119 = nil;
		if not p40 or p40 == "LocalContainer" then
			v119 = l__service__10.LocalContainer();
		elseif p40 == "Camera" then
			v119 = l__service__10.Workspace.CurrentCamera;
		elseif p40 == "PlayerGui" then
			v119 = l__service__10.PlayerGui;
		end;
		local v120, v121 = v119:GetChildren();
		while true do
			local v122, v123 = l__next__33(v120, v121);
			if not v122 then
				break;
			end;
			v121 = v122;
			if v123.Name == p39 or v123 == v123 then
				v123.Parent = p41;
			end;		
		end;
	end;
	function v1.RemoveLocal(p42, p43, p44)
		local v124 = nil;
		if not p43 or p43 == "LocalContainer" then
			v124 = l__service__10.LocalContainer();
		elseif p43 == "Camera" then
			v124 = l__service__10.Workspace.CurrentCamera;
		elseif p43 == "PlayerGui" then
			v124 = l__service__10.PlayerGui;
		end;
		local v125, v126 = v124:GetChildren();
		while true do
			local v127, v128 = l__next__33(v125, v126);
			if not v127 then
				break;
			end;
			if not (not p44) and not (not l__string__15.match(v128.Name, p42)) or v128.Name == p42 or p42 == v128 then
				v128:Destroy();
			end;		
		end;
	end;
	local l__tonumber__40 = tonumber;
	local l__BrickColor__41 = BrickColor;
	function v1.NewCape(p45)
		local l__Parent__129 = p45.Parent;
		local v130 = p45.Reflectance and 0;
		local v131 = l__tonumber__40(p45.Decal and "");
		if l__Parent__129 then
			u6.RemoveCape(l__Parent__129);
			local v132 = l__Parent__129:FindFirstChild("Torso") or (l__Parent__129:FindFirstChild("UpperTorso") or l__Parent__129:FindFirstChild("HumanoidRootPart"));
			local v133 = v132.Name == "UpperTorso";
			if v132 then
				local v134 = l__service__10.New("Part");
				v134.Name = "ADONIS_CAPE";
				v134.Anchored = false;
				v134.Position = v132.Position;
				v134.Transparency = 0;
				v134.Material = p45.Material and "Neon";
				v134.CanCollide = false;
				v134.TopSurface = 0;
				v134.BottomSurface = 0;
				v134.Size = l__Vector3__12.new(2, 4, 0.1);
				v134.BrickColor = l__BrickColor__41.new(p45.Color and "White") or l__BrickColor__41.new("White");
				v134.Parent = l__service__10.LocalContainer();
				if v130 then
					v134.Reflectance = v130;
				end;
				local v135 = l__service__10.New("Motor", v134);
				v135.Part0 = v134;
				v135.Part1 = v132;
				v135.MaxVelocity = 0.01;
				v135.C0 = l__CFrame__24.new(0, 1.75, 0) * l__CFrame__24.Angles(0, l__math__16.rad(90), 0);
				if v133 then
					local v136 = 0.2;
				else
					v136 = 0;
				end;
				v135.C1 = l__CFrame__24.new(0, 1 - v136, v132.Size.Z / 2) * l__CFrame__24.Angles(0, l__math__16.rad(90), 0);
				l__service__10.New("BlockMesh", v134).Scale = l__Vector3__12.new(0.9, 0.87, 0.1);
				local v137 = nil;
				if v131 and v131 ~= 0 then
					v137 = l__service__10.New("Decal", v134);
					v137.Name = "Decal";
					v137.Face = 2;
					v137.Texture = "http://www.roblox.com/asset/?id=" .. v131;
					v137.Transparency = 0;
				end;
				local v138 = u6.GetRandom();
				u5.Capes[v138] = {
					Part = v134, 
					Motor = v135, 
					Enabled = true, 
					Parent = p45.Parent, 
					Torso = v132, 
					Decal = v137, 
					Data = p45, 
					Wave = true, 
					isR15 = v133
				};
				local v139 = l__service__10.Players:GetPlayerFromCharacter(p45.Parent);
				if v139 and v139 == l__service__10.Player then
					u5.Capes[v138].isPlayer = true;
				end;
				if not u5.CapesEnabled then
					v139.Transparency = 1;
					if v137 then
						v137.Transparency = 1;
					end;
					u5.Capes[v138].Enabled = false;
				end;
				u6.MoveCapes();
			end;
		end;
	end;
	function v1.RemoveCape(p46)
		for v140, v141 in l__next__33, u5.Capes do
			if v141.Parent == p46 or not v141.Parent or not v141.Parent.Parent then
				l__pcall__34(v141.Part.Destroy, v141.Part);
				u5.Capes[v140] = nil;
			end;
		end;
	end;
	function v1.HideCapes(p47)
		for v142, v143 in l__next__33, u5.Capes do
			local l__Torso__144 = v143.Torso;
			local l__Parent__145 = v143.Parent;
			local l__Part__146 = v143.Part;
			local l__Motor__147 = v143.Motor;
			local l__Wave__148 = v143.Wave;
			local l__Decal__149 = v143.Decal;
			if l__Parent__145 and l__Parent__145.Parent and l__Torso__144 and l__Torso__144.Parent and l__Part__146 and l__Part__146.Parent then
				if not p47 then
					l__Part__146.Transparency = 0;
					if l__Decal__149 then
						l__Decal__149.Transparency = 0;
					end;
					v143.Enabled = true;
				else
					l__Part__146.Transparency = 1;
					if l__Decal__149 then
						l__Decal__149.Transparency = 1;
					end;
					v143.Enabled = false;
				end;
			else
				l__pcall__34(l__Part__146.Destroy, l__Part__146);
				u5.Capes[v142] = nil;
			end;
		end;
	end;
	function v1.MoveCapes()
		l__service__10.StopLoop("CapeMover");
		l__service__10.StartLoop("CapeMover", 0.1, function()
			if u6.CountTable(u5.Capes) == 0 or not u5.CapesEnabled then
				l__service__10.StopLoop("CapeMover");
				return;
			end;
			for v150, v151 in l__next__33, u5.Capes do
				local l__Torso__152 = v151.Torso;
				local l__Parent__153 = v151.Parent;
				local l__isR15__154 = v151.isR15;
				local l__Part__155 = v151.Part;
				local l__Motor__156 = v151.Motor;
				local l__Decal__157 = v151.Decal;
				if l__Parent__153 and l__Parent__153.Parent and l__Torso__152 and l__Torso__152.Parent and l__Part__155 and l__Part__155.Parent then
					if v151.Enabled and u5.CapesEnabled then
						local v158 = nil;
						l__Part__155.Transparency = 0;
						if l__Decal__157 then
							l__Decal__157.Transparency = 0;
						end;
						local v159 = 0.1;
						if v151.Wave then
							if l__Torso__152.Velocity.Magnitude > 1 then
								v159 = v159 + l__Torso__152.Velocity.Magnitude / 10 * 0.05 + 0.05;
							end;
							v151.Wave = false;
						else
							v151.Wave = true;
						end;
						v158 = v159 + l__math__16.min(l__Torso__152.Velocity.Magnitude / 11, 0.8);
						l__Motor__156.MaxVelocity = l__math__16.min(l__Torso__152.Velocity.Magnitude / 111, 0.04) + 0.002;
						if v151.isPlayer then
							l__Motor__156.DesiredAngle = -v158;
						else
							l__Motor__156.CurrentAngle = -v158;
						end;
						if l__Motor__156.CurrentAngle < -0.2 and l__Motor__156.DesiredAngle > -0.2 then
							l__Motor__156.MaxVelocity = 0.04;
						end;
					else
						l__Part__155.Transparency = 1;
						if l__Decal__157 then
							l__Decal__157.Transparency = 1;
						end;
					end;
				else
					l__pcall__34(l__Part__155.Destroy, l__Part__155);
					u5.Capes[v150] = nil;
				end;
			end;
		end, true);
	end;
	function v1.CountTable(p48)
		local v160 = 0;
		for v161, v162 in l__next__33, p48 do
			v160 = v160 + 1;
		end;
		return v160;
	end;
	function v1.ClearAllInstances()
		local v163 = l__service__10.GetAdonisObjects();
		for v164, v165 in l__next__33, v163 do
			v164:Destroy();
			v163[v164] = nil;
		end;
	end;
	function v1.PlayAnimation(p49)
		if p49 == 0 then
			return;
		end;
		local v166 = l__service__10.Player.Character:FindFirstChildOfClass("Humanoid");
		local v167 = v166:FindFirstChildOfClass("Animator") or v166:WaitForChild("Animator");
		for v168, v169 in l__pairs__20(v167:GetPlayingAnimationTracks()) do
			v169:Stop();
		end;
		local v170 = l__service__10.New("Animation");
		v170.AnimationId = "rbxassetid://" .. p49;
		v170.Name = "ADONIS_Animation";
		v167:LoadAnimation(v170):Play();
	end;
	function v1.SetLighting(p50, p51)
		if l__service__10.Lighting[p50] ~= nil then
			l__service__10.Lighting[p50] = p51;
			u5.LightingSettings[p50] = p51;
		end;
	end;
	function v1.ChatMessage(p52, p53, p54, p55)
		local v171 = {
			Text = p52
		};
		if p53 then
			v171.Color = p53;
		end;
		if p54 then
			v171.Font = p54;
		end;
		if p55 then
			v171.Size = p55;
		end;
		l__service__10.StarterGui:SetCore("ChatMakeSystemMessage", v171);
		if u6.SendToChat then
			u6.SendToChat({
				Name = "::Adonis::"
			}, p52, "Private");
		end;
	end;
	function v1.SetCamProperty(p56, p57)
		local l__CurrentCamera__172 = l__workspace__19.CurrentCamera;
		if l__CurrentCamera__172[p56] then
			l__CurrentCamera__172[p56] = p57;
		end;
	end;
	function v1.SetFPS(p58)
		l__service__10.StopLoop("SetFPS");
		local v173 = l__tonumber__40(p58);
		if v173 then
			l__service__10.StartLoop("SetFPS", 0.1, function()
				while not (l__tick__23() + 1 / v173 <= l__tick__23()) do
				
				end;
			end);
		end;
	end;
	function v1.RestoreFPS()
		l__service__10.StopLoop("SetFPS");
	end;
	local l__tostring__42 = tostring;
	local l__print__43 = print;
	function v1.Crash()
		local l__RunService__44 = l__service__10.RunService;
		local u45 = 0;
		local function u46()
			l__RunService__44:BindToRenderStep(l__tostring__42(u45), 100, function()
				l__print__43("Stopping");
				u46();
			end);
			u45 = u45 + 1;
		end;
		u46();
	end;
	local l__wait__47 = wait;
	function v1.HardCrash()
		local u48 = l__service__10.New("ScreenGui", l__service__10.PlayerGui);
		local u49 = nil;
		local u50 = l__service__10.New("RemoteEvent", l__workspace__19.CurrentCamera);
		local function u51()
			for v174 = 1, 50 do
				l__service__10.Debris:AddItem(l__service__10.New("Part", l__workspace__19.CurrentCamera), (1 / 0));
				l__print__43("((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)((((**&&#@#$$$$$%%%%:)");
				l__service__10.New("Frame", u48).Size = l__UDim2__13.new(1, 0, 1, 0);
				spawn(function()
					l__table__21.insert(u49, l__string__15.rep(l__tostring__42(l__math__16.random()), 100));
				end);
				u50:FireServer("Hiiiiiiiiiiiiiiii");
				spawn(function()
					spawn(function()
						spawn(function()
							spawn(function()
								spawn(function()
									l__print__43("hi");
									spawn(u51);
								end);
							end);
						end);
					end);
				end);
			end;
			u49 = {};
		end;
		while l__wait__47(0.01) do
			for v175 = 1, 50000000 do
				cPcall(function()
					l__client__2.GPUCrash();
				end);
				cPcall(function()
					u51();
				end);
				l__print__43(1);
			end;		
		end;
	end;
	function v1.GPUCrash()
		local u52 = l__service__10.New("ScreenGui", l__service__10.PlayerGui);
		(function()
			while l__wait__47(0.01) do
				for v176 = 1, 500000 do
					l__service__10.New("Frame", u52).Size = l__UDim2__13.new(1, 0, 1, 0);
				end;			
			end;
		end)();
	end;
	function v1.RAMCrash()
		while l__wait__47(0.1) do
			for v177 = 1, 10000 do
				l__service__10.Debris:AddItem(l__service__10.New("Part", l__workspace__19.CurrentCamera), (1 / 0));
			end;		
		end;
	end;
	function v1.KillClient()
		l__client__2.Kill("KillClient called");
	end;
	local l__Enum__53 = Enum;
	function v1.KeyCodeToName(p59)
		local v178 = l__tonumber__40(p59);
		if v178 then
			local v179, v180 = l__Enum__53.KeyCode:GetEnumItems();
			while true do
				local v181, v182 = l__next__33(v179, v180);
				if not v181 then
					break;
				end;
				v180 = v181;
				if v182.Value == l__tonumber__40(v178) then
					return v182.Name;
				end;			
			end;
		end;
		return "UNKNOWN";
	end;
	function v1.KeyBindListener()
		if not u5 then
			l__wait__47();
		end;
		u5.KeyBinds = u8.Get("PlayerData").Keybinds or {};
		local u54 = 0;
		l__service__10.UserInputService.InputBegan:Connect(function(p60)
			local v183 = l__tostring__42(p60.KeyCode.Value);
			if u5.KeybindsEnabled and not l__service__10.UserInputService:GetFocusedTextBox() and v183 and u5.KeyBinds[v183] and not u5.WaitingForBind then
				if l__tick__23() - u54 > 5 or u8.Get("CheckAdmin") then
					u8.Send("ProcessCommand", u5.KeyBinds[v183], false, true);
					u1.Make("Hint", {
						Message = "[Ran] Key: " .. u6.KeyCodeToName(v183) .. " | Command: " .. l__tostring__42(u5.KeyBinds[v183])
					});
				end;
				u54 = l__tick__23();
			end;
		end);
	end;
	function v1.AddKeyBind(p61, p62)
		local v184 = l__tostring__42(p61);
		u5.KeyBinds[l__tostring__42(v184)] = p62;
		u8.Get("UpdateKeybinds", u5.KeyBinds);
		u1.Make("Hint", {
			Message = "Bound \"" .. u6.KeyCodeToName(v184) .. "\" to " .. p62
		});
	end;
	function v1.RemoveKeyBind(p63)
		local v185 = l__tostring__42(p63);
		if u5.KeyBinds[l__tostring__42(v185)] ~= nil then
			u5.KeyBinds[l__tostring__42(v185)] = nil;
			u8.Get("UpdateKeybinds", u5.KeyBinds);
			Routine(function()
				u1.Make("Hint", {
					Message = "Removed \"" .. u6.KeyCodeToName(v185) .. "\" from key binds"
				});
			end);
		end;
	end;
	function v1.BrickBlur(p64, p65, p66)
		local l__ADONIS_WINDOW_FUNC_BLUR__186 = l__service__10.LocalContainer():FindFirstChild("ADONIS_WINDOW_FUNC_BLUR");
		if l__ADONIS_WINDOW_FUNC_BLUR__186 then
			l__ADONIS_WINDOW_FUNC_BLUR__186:Destroy();
		end;
		if p64 then
			local v187 = l__Instance__11.new("Part", l__workspace__19.CurrentCamera);
			v187.Name = "ADONIS_WINDOW_FUNC_BLUR";
			v187.Material = "Neon";
			v187.BrickColor = p66 or l__BrickColor__41.Black();
			v187.Transparency = p65 and 0.5;
			v187.CanCollide = false;
			v187.Anchored = true;
			v187.FormFactor = "Custom";
			v187.Size = l__Vector3__12.new(100, 100, 0);
			while v187 and v187.Parent and l__wait__47(0.025) do
				v187.CFrame = l__workspace__19.CurrentCamera.CoordinateFrame * l__CFrame__24.new(0, 0, -2.5) * l__CFrame__24.Angles(12.6, 0, 0);			
			end;
		else
			local v188, v189 = l__workspace__19.CurrentCamera:GetChildren();
			while true do
				local v190, v191 = l__next__33(v188, v189);
				if not v190 then
					break;
				end;
				v189 = v190;
				if v191.Name == "ADONIS_WINDOW_FUNC_BLUR" then
					v191:Destroy();
				end;			
			end;
		end;
	end;
	function v1.PlayAudio(p67, p68, p69, p70)
		if u5.localSounds[l__tostring__42(p67)] then
			u5.localSounds[l__tostring__42(p67)]:Stop();
			u5.localSounds[l__tostring__42(p67)]:Destroy();
			u5.localSounds[l__tostring__42(p67)] = nil;
		end;
		local v192 = l__service__10.New("Sound");
		v192.SoundId = "rbxassetid://" .. p67;
		if p70 then
			v192.Looped = true;
		end;
		if p68 then
			v192.Volume = p68;
		end;
		if p69 then
			v192.Pitch = p69;
		end;
		v192.Name = "ADONI_LOCAL_SOUND " .. p67;
		v192.Parent = l__service__10.LocalContainer();
		u5.localSounds[l__tostring__42(p67)] = v192;
		v192:Play();
		l__wait__47(1);
		while true do
			l__wait__47(0.1);
			if not v192.IsPlaying then
				break;
			end;		
		end;
		v192:Destroy();
		u5.localSounds[l__tostring__42(p67)] = nil;
	end;
	function v1.StopAudio(p71)
		if u5.localSounds[l__tostring__42(p71)] then
			u5.localSounds[l__tostring__42(p71)]:Stop();
			u5.localSounds[l__tostring__42(p71)]:Destroy();
			u5.localSounds[l__tostring__42(p71)] = nil;
			return;
		end;
		if p71 == "all" then
			for v193, v194 in l__pairs__20(u5.localSounds) do
				u5.localSounds[v193]:Stop();
				u5.localSounds[v193]:Destroy();
				u5.localSounds[v193] = nil;
			end;
		end;
	end;
	function v1.FadeAudio(p72, p73, p74, p75, p76)
		if not p73 then
			local v195 = u5.localSounds[l__tostring__42(p72)];
			if v195 then
				for v196 = v195.Volume, 0, -0.01 do
					v195.Volume = v196;
					l__wait__47(p76 and 0.1);
				end;
				u6.StopAudio(p72);
				return;
			end;
		else
			u6.StopAudio(p72);
			u6.PlayAudio(p72, 0, p74, p75);
			local v197 = u5.localSounds[l__tostring__42(p72)];
			if v197 then
				for v198 = 0, p73, 0.01 do
					v197.Volume = v198;
					l__wait__47(p76 and 0.1);
				end;
			end;
		end;
	end;
	function v1.KillAllLocalAudio()
		for v199, v200 in l__next__33, u5.localSounds do
			v200:Stop();
			v200:Destroy();
			l__table__21.remove(u5.localSounds, v199);
		end;
	end;
	function v1.RemoveGuis()
		local v201, v202 = l__service__10.PlayerGui:GetChildren();
		while true do
			local v203, v204 = l__next__33(v201, v202);
			if not v203 then
				break;
			end;
			v202 = v203;
			if not u1.Get(v204) then
				v204:Destroy();
			end;		
		end;
	end;
	function v1.SetCoreGuiEnabled(p77, p78)
		l__service__10.StarterGui:SetCoreGuiEnabled(p77, p78);
	end;
	function v1.UnCape()
		local l__AdonisCape__205 = l__service__10.LocalContainer():FindFirstChild("::Adonis::Cape");
		if l__AdonisCape__205 then
			l__AdonisCape__205:Destroy();
		end;
	end;
	function v1.Cape(p79, p80, p81, p82)
		local l__HumanoidRootPart__206 = l__service__10.Player.Character:FindFirstChild("HumanoidRootPart");
		if l__HumanoidRootPart__206 then
			local v207 = l__service__10.New("Part", l__service__10.LocalContainer());
			v207.Name = "::Adonis::Cape";
			v207.Anchored = true;
			v207.Transparency = 0.1;
			v207.Material = p79;
			v207.CanCollide = false;
			v207.TopSurface = 0;
			v207.BottomSurface = 0;
			if l__type__22(p80) == "table" then
				p80 = l__Color3__14.new(p80[1], p80[2], p80[3]);
			end;
			v207.BrickColor = l__BrickColor__41.new(p80) or l__BrickColor__41.new("White");
			if p82 then
				v207.Reflectance = p82;
			end;
			if p81 and p81 ~= 0 then
				local v208 = l__service__10.New("Decal", v207);
				v208.Face = 2;
				v208.Texture = "http://www.roblox.com/asset/?id=" .. p81;
				v208.Transparency = 0;
			end;
			v207.formFactor = "Custom";
			v207.Size = l__Vector3__12.new(0.2, 0.2, 0.2);
			l__service__10.New("BlockMesh", v207).Scale = l__Vector3__12.new(9, 17.5, 0.5);
			l__wait__47(0.1);
			v207.Anchored = false;
			local v209 = l__service__10.New("Motor", v207);
			v209.Part0 = v207;
			v209.Part1 = l__HumanoidRootPart__206;
			v209.MaxVelocity = 0.01;
			v209.C0 = l__CFrame__24.new(0, 1.75, 0) * l__CFrame__24.Angles(0, l__math__16.rad(90), 0);
			v209.C1 = l__CFrame__24.new(0, 1, l__HumanoidRootPart__206.Size.Z / 2) * l__CFrame__24.Angles(0, l__math__16.rad(90), 0);
			local v210 = false;
			while true do
				l__wait__47(0.022727272727272728);
				local v211 = 0.1;
				local l__Magnitude__212 = l__HumanoidRootPart__206.Velocity.Magnitude;
				if v210 then
					v211 = v211 + l__HumanoidRootPart__206.Velocity.Magnitude / 10 * 0.05 + 0.05;
					local v213 = false;
				else
					v213 = true;
				end;
				v209.MaxVelocity = l__math__16.min(l__HumanoidRootPart__206.Velocity.Magnitude / 111, 0.04) + 0.002;
				v209.DesiredAngle = -(v211 + l__math__16.min(l__HumanoidRootPart__206.Velocity.Magnitude / 11, 0.5));
				if v209.CurrentAngle < -0.2 and v209.DesiredAngle > -0.2 then
					v209.MaxVelocity = 0.04;
				end;
				while true do
					l__wait__47();
					if v209.CurrentAngle == v209.DesiredAngle then
						break;
					end;
					if l__HumanoidRootPart__206.Velocity.Magnitude / 10 + 1 <= l__math__16.abs(l__HumanoidRootPart__206.Velocity.Magnitude - l__Magnitude__212) then
						break;
					end;				
				end;
				if l__HumanoidRootPart__206.Velocity.Magnitude < 0.1 then
					l__wait__47(0.1);
				end;
				if not v207 then
					break;
				end;
				if not v207.Parent then
					break;
				end;
				if v207.Parent ~= l__service__10.LocalContainer() then
					break;
				end;			
			end;
		end;
	end;
	function v1.TextToSpeech(p83)
		local v214 = l__Instance__11.new("Sound", l__service__10.LocalContainer());
		v214.SoundId = "rbxassetid://" .. 296333956;
		v214.Volume = 1;
		local v215 = l__Instance__11.new("Sound", l__service__10.LocalContainer());
		v215.SoundId = "rbxassetid://" .. 296333956;
		v215.Volume = 1;
		l__game__18:service("ContentProvider"):Preload("rbxassetid://" .. 296333956);
		local u55 = { {
				str = "%so", 
				func = { 17 }
			}, {
				str = "ing", 
				func = { 41 }
			}, {
				str = "oot", 
				func = { 4, 26 }
			}, {
				str = "or", 
				func = { 10 }
			}, {
				str = "oo", 
				func = { 3 }
			}, {
				str = "hi", 
				func = { 44, 19 }
			}, {
				str = "ie", 
				func = { 1 }
			}, {
				str = "eye", 
				func = { 19 }
			}, {
				str = "$Suy%s", 
				real = "uy", 
				func = { 19 }
			}, {
				str = "%Sey%s", 
				func = { 1 }
			}, {
				str = "%sye", 
				func = { 19 }
			}, {
				str = "the", 
				func = { 25, 15 }
			}, {
				str = "th", 
				func = { 32, 0.2395 }
			}, {
				str = "ow", 
				func = { 20 }
			}, {
				str = "qu", 
				func = { 21, 38 }
			}, {
				str = "ee", 
				func = { 1 }
			}, {
				str = "i%s", 
				delay = 0.5, 
				func = { 19 }
			}, {
				str = "ea", 
				func = { 1 }
			}, {
				str = "u(.*)e", 
				real = "u", 
				capture = true, 
				func = { 9 }
			}, {
				str = "ch", 
				func = { 24 }
			}, {
				str = "ere", 
				func = { 5 }
			}, {
				str = "ai", 
				func = { 6 }
			}, {
				str = "la", 
				func = { 39, 6 }
			}, {
				str = "oy", 
				func = { 8 }
			}, {
				str = "gh", 
				func = { 44 }
			}, {
				str = "sh", 
				func = { 22 }
			}, {
				str = "air", 
				func = { 18 }
			}, {
				str = "ar", 
				func = { 16 }
			}, {
				str = "ir", 
				func = { 11 }
			}, {
				str = "er", 
				func = { 12 }
			}, {
				str = "sio", 
				func = { 35 }
			}, {
				str = "ck", 
				func = { 21 }
			}, {
				str = "zy", 
				func = { 34, 1 }
			}, {
				str = "ny", 
				func = { 42, 1 }
			}, {
				str = "ly", 
				func = { 39, 1 }
			}, {
				str = "ey", 
				func = { 1 }
			}, {
				str = "ii", 
				func = { 19 }
			}, {
				str = "i", 
				func = { 2 }
			}, {
				str = "y", 
				func = { 37 }
			}, {
				str = "y", 
				func = { 37 }
			}, {
				str = "s", 
				func = { 23 }
			}, {
				str = "e", 
				func = { 13 }
			}, {
				str = "a", 
				func = { 14 }
			}, {
				str = "x", 
				func = { 21, 23 }
			}, {
				str = "u", 
				func = { 15 }
			}, {
				str = "o", 
				func = { 17 }
			}, {
				str = "c", 
				func = { 21 }
			}, {
				str = "k", 
				func = { 21 }
			}, {
				str = "t", 
				func = { 26 }
			}, {
				str = "f", 
				func = { 27 }
			}, {
				str = "i", 
				func = { 2 }
			}, {
				str = "p", 
				func = { 28 }
			}, {
				str = "b", 
				func = { 29 }
			}, {
				str = "v", 
				func = { 30 }
			}, {
				str = "d", 
				func = { 31 }
			}, {
				str = "j", 
				func = { 33 }
			}, {
				str = "z", 
				func = { 34 }
			}, {
				str = "g", 
				func = { 36 }
			}, {
				str = "w", 
				func = { 38 }
			}, {
				str = "l", 
				func = { 39 }
			}, {
				str = "r", 
				func = { 40 }
			}, {
				str = "n", 
				func = { 42 }
			}, {
				str = "m", 
				func = { 43 }
			}, {
				str = "h", 
				func = { 44 }
			}, {
				str = " ", 
				func = "wait"
			}, {
				str = "%.", 
				func = "wait"
			}, {
				str = "!", 
				func = "wait"
			}, {
				str = "?", 
				func = "wait"
			}, {
				str = ";", 
				func = "wait"
			}, {
				str = ":", 
				func = "wait"
			} };
		local function u56(p84)
			local u57 = p84;
			local u58 = {};
			local function u59()
				for v216, v217 in l__ipairs__9(u55) do
					local v218, v219 = l__string__15.find(l__string__15.lower(u57), "^" .. v217.str);
					if v218 then
						if v217.capture then
							local v220 = nil;
							local v221, v222 = l__string__15.find(l__string__15.lower(u57), v217.real);
							v220 = l__string__15.match(l__string__15.lower(u57), v217.str);
							if v222 < v218 then
								l__table__21.insert(u58, v217);
								u56(v220);
							else
								u56(v220);
								l__table__21.insert(u58, v217);
							end;
						else
							l__table__21.insert(u58, v217);
						end;
						u57 = l__string__15.sub(u57, v219 + 1);
						u59();
					end;
				end;
			end;
			u59();
			return u58;
		end;
		local v223 = u56(p83);
		local u60 = false;
		local function v224(p85)
			local v225 = v214;
			if u60 then
				v225 = v215;
			end;
			v225.TimePosition = p85;
		end;
		v214:Play();
		v215:Play();
		for v226, v227 in l__ipairs__9(v223) do
			if l__type__22(v227.func) == "string" then
				l__wait__47(0.5);
			elseif l__type__22(v227) == "table" then
				local v228, v229, v230 = l__ipairs__9(v227.func);
				while true do
					local v231, v232 = v228(v229, v230);
					if not v231 then
						break;
					end;
					if u60 then
						u60 = false;
					else
						u60 = true;
					end;
					v224(v232);
					if v227.delay then
						l__wait__47(v227.delay);
					else
						l__wait__47(0.1);
					end;				
				end;
			end;
		end;
		l__wait__47(0.5);
		v214:Stop();
		v215:Stop();
	end;
	function v1.IsValidTexture(p86)
		local u61 = l__tonumber__40(p86);
		local v233, v234 = l__pcall__34(function()
			return l__service__10.MarketPlace:GetProductInfo(u61);
		end);
		if v233 and v234 and v234.AssetTypeId == 1 then
			return true;
		end;
		return false;
	end;
	function v1.GetTexture(p87)
		local v235 = l__tonumber__40(p87);
		if v235 and u6.IsValidTexture(v235) then
			return v235;
		end;
		return 6825455804;
	end;
	l__client__2.Functions = v1;
end;

