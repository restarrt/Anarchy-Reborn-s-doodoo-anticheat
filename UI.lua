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
	local u9 = nil;
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
			u9 = l__client__2.Deps;
			u1.Init = nil;
		end, 
		RunLast = function()
			u1.DefaultTheme = u8.Get("Setting", "DefaultTheme");
			u1.RunLast = nil;
		end
	};
	local l__service__10 = service;
	local l__pcall__11 = pcall;
	function v1.GetHolder()
		if u1.Holder and u1.Holder.Parent == l__service__10.PlayerGui then
			return u1.Holder;
		end;
		l__pcall__11(function()
			if u1.Holder then
				u1.Holder:Destroy();
			end;
		end);
		local v2 = l__service__10.New("ScreenGui");
		v2.Name = u6.GetRandom();
		v2.Parent = l__service__10.PlayerGui;
		u1.Holder = v2;
		return u1.Holder;
	end;
	local l__Instance__12 = Instance;
	local l__UDim2__13 = UDim2;
	local l__next__14 = next;
	function v1.Prepare(p1)
		return p1;
	end;
	local l__require__15 = require;
	local l__type__16 = type;
	local l__setfenv__17 = setfenv;
	local l__unpack__18 = unpack;
	local l__warn__19 = warn;
	local l__tostring__20 = tostring;
	function v1.LoadModule(p2, p3, p4)
		local v3, v4 = l__pcall__11(l__require__15, p2);
		local v5 = GetEnv(p4);
		v5.script = p2;
		v5.client = l__service__10.CloneTable(l__client__2);
		v5.service = l__service__10:CloneTable();
		v5.service.Threads = l__service__10.CloneTable(l__service__10.Threads);
		for v6, v7 in l__next__14, v5.client do
			if l__type__16(v7) == "table" and v6 ~= "Variables" and v6 ~= "Handlers" then
				v5.client[v6] = l__service__10.CloneTable(v7);
			end;
		end;
		if not v3 then
			l__warn__19("Error while loading module " .. p2.Name, l__tostring__20(v4));
			return;
		end;
		local v8 = { l__service__10.TrackTask("UI: " .. p2:GetFullName(), l__setfenv__17(v4, v5), p3 or {}) };
		if v8[1] then
			return l__unpack__18(v8, 2);
		end;
		l__warn__19("Error while running module " .. p2.Name, l__tostring__20(v8[2]));
		l__client__2.LogError("Error loading " .. l__tostring__20(p2) .. " - " .. l__tostring__20(v8[2]));
	end;
	local l__UIFolder__21 = client.UIFolder;
	local l__table__22 = table;
	function v1.GetNew(p5, p6)
		local v9 = {};
		local v10 = {};
		local v11 = l__Instance__12.new("Folder");
		local u23 = {};
		local u24 = false;
		local function u25(p7, p8, p9)
			local v12 = (p9 and 11) - 1;
			local v13 = l__UIFolder__21:FindFirstChild(p7) or l__UIFolder__21.Default;
			if v13 then
				local l__Base_Theme__14 = v13:FindFirstChild("Base_Theme");
				local v15 = l__Base_Theme__14 and l__Base_Theme__14.Value;
				local v16 = v13:FindFirstChild(p8);
				if v16 then
					local l__Config__17 = v16:FindFirstChild("Config");
					l__table__22.insert(u23, {
						Theme = p7, 
						Folder = v13, 
						Name = p8, 
						Found = v16, 
						Config = l__Config__17, 
						isModule = v16:IsA("ModuleScript")
					});
					if l__Config__17 then
						local v18 = l__Config__17:FindFirstChild("BaseTheme") and v18;
						v15 = v18 and v18.Value;
					end;
				end;
				if v15 and v12 > 0 then
					if u1.DefaultTheme and v15 == "Default" and p7 ~= u1.DefaultTheme and not u24 then
						u25(u1.DefaultTheme, p8, v12);
						return;
					end;
					u24 = true;
					u25(v15, p8, v12);
				end;
			end;
		end;
		u25(p5, p6);
		v11.Name = "Config";
		if not (#u23 > 0) then
			return;
		end;
		for v19, v20 in l__next__14, u23 do
			if v20.Config then
				local v21, v22 = v20.Config:GetChildren();
				while true do
					local v23, v24 = l__next__14(v21, v22);
					if not v23 then
						break;
					end;
					v22 = v23;
					if not v9[v24.Name] then
						v9[v24.Name] = v24;
					end;				
				end;
			end;
		end;
		for v25, v26 in l__next__14, v9 do
			v26:Clone().Parent = v11;
		end;
		if u23[1].isModule then
			return u23[1].Found, u23[1].Folder, v11;
		end;
		if not v9.Code then
			l__warn__19("Window config missing code.lua. Are your Base_Themes correct? client.UI.GetNew line 236");
		end;
		local v27 = u23[1].Found:Clone();
		local l__Config__28 = v27:FindFirstChild("Config");
		if l__Config__28 then
			l__Config__28:Destroy();
		end;
		v11.Parent = v27;
		return v27, u23[1].Folder, v11;
	end;
	local l__print__26 = print;
	function v1.Make(p10, p11, p12)
		local v29 = p11 or {};
		local v30 = p12 or (u5.LastServerTheme or {
			Desktop = "Default", 
			Mobile = "Mobilius"
		});
		local v31 = u5.CustomTheme or (l__service__10.IsMobile() and v30.Mobile or v30.Desktop);
		local v32 = l__UIFolder__21:FindFirstChild(v31) or l__UIFolder__21.Default;
		local v33, v34, v35 = u1.GetNew(v31, p10);
		if v33 then
			local l__Config__36 = v33:FindFirstChild("Config");
			local v37 = l__Config__36 and l__Config__36:FindFirstChild("Modifier");
			if v33:IsA("ModuleScript") then
				return u1.LoadModule(v33, v29, {
					script = v33
				});
			end;
			if l__Config__36 and v35 and v35 ~= true then
				local v38 = v35.Code;
				local l__AllowMultiple__39 = v35.AllowMultiple;
				local l__CanKeepAlive__40 = v35.CanKeepAlive;
				local v41, v42 = u1.Get(p10);
				if not v41 or v42 and v42 > 0 and (l__AllowMultiple__39 and l__AllowMultiple__39.Value or true) then
					local v43, v44 = u1.Register(v33);
					local v45 = {};
					if v32:IsA("ModuleScript") then
						local v46 = nil;
						local v47 = nil;
						local v48 = nil;
						local v49 = nil;
						local v50 = nil;
						local v51 = nil;
						local v52 = nil;
						local v53 = nil;
						local v54 = nil;
						local v55 = nil;
						local v56 = nil;
						local v57 = nil;
						local v58 = nil;
						local v59 = nil;
						local v60 = nil;
						local v61 = nil;
						local v62 = nil;
						local v63 = nil;
						local v64 = nil;
						local v65 = nil;
						local v66 = nil;
						local v67 = nil;
						local v68 = nil;
						local v69 = nil;
						local v70 = nil;
						local v71 = nil;
						local v72 = nil;
						local v73 = nil;
						local v74 = nil;
						local v75 = nil;
						local v76 = nil;
						local v77 = nil;
						local v78 = nil;
						local v79 = nil;
						local v80 = nil;
						local v81 = nil;
						local v82 = nil;
						local v83 = nil;
						local v84 = nil;
						local v85 = nil;
						local v86 = nil;
						local v87 = nil;
						local v88 = nil;
						local v89 = nil;
						local v90 = nil;
						local v91 = nil;
						local v92 = nil;
						local v93 = nil;
						local v94 = nil;
						local v95 = nil;
						v45.script = v32;
						v45.gTable = v43;
						local v96, v97 = l__pcall__11(l__require__15, v32);
						local v98 = { l__pcall__11(l__setfenv__17(v97, (GetEnv(v45))), v33, v43, v29) };
						local v99 = v98[1];
						local v100 = v98[2];
						if v100 ~= nil then
							if l__type__16(v100) == "userdata" and u3.GetClassName(v100) == "ScreenGui" then
								if v100:FindFirstChild("Config") then
									local v101 = v100.Config:FindFirstChild("Code") or v38;
								else
									v101 = v38;
								end;
								v38 = v101;
								v46 = u5;
								v47 = "GUIHolder";
								v48 = v46;
								v49 = v47;
								v50 = v48[v49];
								local v102 = "Parent";
								v51 = v33;
								v52 = v102;
								v53 = v50;
								v51[v52] = v53;
								local v103 = u6;
								local v104 = "GetRandom";
								v54 = v103;
								v55 = v104;
								local v105 = v54[v55];
								v56 = v105;
								local v106 = v56();
								local v107 = "Name";
								v57 = v33;
								v58 = v107;
								v59 = v106;
								v57[v58] = v59;
								local v108 = "gIndex";
								v60 = v29;
								v61 = v108;
								v62 = v44;
								v60[v61] = v62;
								local v109 = "gTable";
								v63 = v29;
								v64 = v109;
								v65 = v43;
								v63[v64] = v65;
								local v110 = "Parent";
								v66 = v38;
								v67 = v110;
								v68 = l__Config__36;
								v66[v67] = v68;
								local v111 = "Name";
								v69 = v38;
								v70 = v111;
								v71 = p10;
								v69[v70] = v71;
								v72 = v37;
								if v72 then
									u1.LoadModule(v37, v29, {
										script = v37, 
										gTable = v43, 
										Data = v29, 
										GUI = v33
									});
								end;
								local v112 = u1;
								local v113 = "LoadModule";
								v73 = v112;
								v74 = v113;
								local v114 = v73[v74];
								v75 = v38;
								local v115 = v75;
								v76 = v29;
								v90 = v76;
								v77 = {};
								local v116 = "script";
								v78 = v77;
								v79 = v116;
								v80 = v38;
								v78[v79] = v80;
								local v117 = "gTable";
								v81 = v77;
								v82 = v117;
								v83 = v43;
								v81[v82] = v83;
								local v118 = "Data";
								v84 = v77;
								v85 = v118;
								v86 = v29;
								v84[v85] = v86;
								local v119 = "GUI";
								v87 = v77;
								v88 = v119;
								v89 = v33;
								v87[v88] = v89;
								v91 = v114;
								v92 = v115;
								v93 = v90;
								v94 = v77;
								v95 = v91(v92, v93, v94);
								return v95;
							else
								return v100;
							end;
						else
							v46 = u5;
							v47 = "GUIHolder";
							v48 = v46;
							v49 = v47;
							v50 = v48[v49];
							v102 = "Parent";
							v51 = v33;
							v52 = v102;
							v53 = v50;
							v51[v52] = v53;
							v103 = u6;
							v104 = "GetRandom";
							v54 = v103;
							v55 = v104;
							v105 = v54[v55];
							v56 = v105;
							v106 = v56();
							v107 = "Name";
							v57 = v33;
							v58 = v107;
							v59 = v106;
							v57[v58] = v59;
							v108 = "gIndex";
							v60 = v29;
							v61 = v108;
							v62 = v44;
							v60[v61] = v62;
							v109 = "gTable";
							v63 = v29;
							v64 = v109;
							v65 = v43;
							v63[v64] = v65;
							v110 = "Parent";
							v66 = v38;
							v67 = v110;
							v68 = l__Config__36;
							v66[v67] = v68;
							v111 = "Name";
							v69 = v38;
							v70 = v111;
							v71 = p10;
							v69[v70] = v71;
							v72 = v37;
							if v72 then
								u1.LoadModule(v37, v29, {
									script = v37, 
									gTable = v43, 
									Data = v29, 
									GUI = v33
								});
							end;
							v112 = u1;
							v113 = "LoadModule";
							v73 = v112;
							v74 = v113;
							v114 = v73[v74];
							v75 = v38;
							v115 = v75;
							v76 = v29;
							v90 = v76;
							v77 = {};
							v116 = "script";
							v78 = v77;
							v79 = v116;
							v80 = v38;
							v78[v79] = v80;
							v117 = "gTable";
							v81 = v77;
							v82 = v117;
							v83 = v43;
							v81[v82] = v83;
							v118 = "Data";
							v84 = v77;
							v85 = v118;
							v86 = v29;
							v84[v85] = v86;
							v119 = "GUI";
							v87 = v77;
							v88 = v119;
							v89 = v33;
							v87[v88] = v89;
							v91 = v114;
							v92 = v115;
							v93 = v90;
							v94 = v77;
							v95 = v91(v92, v93, v94);
							return v95;
						end;
					else
						v46 = u5;
						v47 = "GUIHolder";
						v48 = v46;
						v49 = v47;
						v50 = v48[v49];
						v102 = "Parent";
						v51 = v33;
						v52 = v102;
						v53 = v50;
						v51[v52] = v53;
						v103 = u6;
						v104 = "GetRandom";
						v54 = v103;
						v55 = v104;
						v105 = v54[v55];
						v56 = v105;
						v106 = v56();
						v107 = "Name";
						v57 = v33;
						v58 = v107;
						v59 = v106;
						v57[v58] = v59;
						v108 = "gIndex";
						v60 = v29;
						v61 = v108;
						v62 = v44;
						v60[v61] = v62;
						v109 = "gTable";
						v63 = v29;
						v64 = v109;
						v65 = v43;
						v63[v64] = v65;
						v110 = "Parent";
						v66 = v38;
						v67 = v110;
						v68 = l__Config__36;
						v66[v67] = v68;
						v111 = "Name";
						v69 = v38;
						v70 = v111;
						v71 = p10;
						v69[v70] = v71;
						v72 = v37;
						if v72 then
							u1.LoadModule(v37, v29, {
								script = v37, 
								gTable = v43, 
								Data = v29, 
								GUI = v33
							});
						end;
						v112 = u1;
						v113 = "LoadModule";
						v73 = v112;
						v74 = v113;
						v114 = v73[v74];
						v75 = v38;
						v115 = v75;
						v76 = v29;
						v90 = v76;
						v77 = {};
						v116 = "script";
						v78 = v77;
						v79 = v116;
						v80 = v38;
						v78[v79] = v80;
						v117 = "gTable";
						v81 = v77;
						v82 = v117;
						v83 = v43;
						v81[v82] = v83;
						v118 = "Data";
						v84 = v77;
						v85 = v118;
						v86 = v29;
						v84[v85] = v86;
						v119 = "GUI";
						v87 = v77;
						v88 = v119;
						v89 = v33;
						v87[v88] = v89;
						v91 = v114;
						v92 = v115;
						v93 = v90;
						v94 = v77;
						v95 = v91(v92, v93, v94);
						return v95;
					end;
				end;
			end;
		else
			l__print__26("GUI " .. l__tostring__20(p10) .. " not found");
		end;
	end;
	function v1.Get(p13, p14, p15)
		local v120 = {};
		local v121 = 0;
		if p13 then
			for v122, v123 in l__next__14, l__client__2.GUIs do
				if v123.Name ~= p14 and v123.Object ~= p14 and v123 ~= p14 then
					if l__type__16(p13) == "string" then
						if v123.Name == p13 then
							v120[v122] = v123;
							v121 = v121 + 1;
							if p15 then
								return v123;
							end;
						end;
					elseif l__type__16(p13) == "userdata" then
						if l__service__10.RawEqual(v123.Object, p13) then
							v120[v122] = v123;
							v121 = v121 + 1;
							if p15 then
								return v123;
							end;
						end;
					elseif l__type__16(p13) == "boolean" and p13 == true then
						v120[v122] = v123;
						v121 = v121 + 1;
						if p15 then
							return v123;
						end;
					end;
				end;
			end;
		end;
		if v121 < 1 then
			return false;
		end;
		return v120, v121;
	end;
	function v1.Remove(p16, p17)
		local v124 = u1.Get(p16, p17);
		if v124 then
			for v125, v126 in l__next__14, v124 do
				v126.Destroy();
			end;
		end;
	end;
	local l__rawequal__27 = rawequal;
	local l__wait__28 = wait;
	function v1.Register(p18, p19)
		local v127 = u6.GetRandom();
		local v128 = {
			Object = p18, 
			Config = p18:FindFirstChild("Config"), 
			Name = p18.Name, 
			Events = {}, 
			Class = p18.ClassName, 
			Index = v127, 
			Active = true
		};
		local u29 = nil;
		function v128.Ready()
			if u29.Config then
				u29.Config.Parent = nil;
			end;
			local v129, v130 = l__pcall__11(function()
				local l__Object__131 = u29.Object;
				if u29.Class ~= "ScreenGui" and u29.Class ~= "GuiMain" then
					l__Object__131.Parent = u1.GetHolder();
					return;
				end;
				if l__Object__131.DisplayOrder == 0 then
					l__Object__131.DisplayOrder = 90000;
				end;
				l__Object__131.Enabled = true;
				l__Object__131.Parent = l__service__10.PlayerGui;
			end);
			if v129 then
				u29.Active = true;
				return;
			end;
			l__warn__19("Something happened while trying to set the parent of " .. l__tostring__20(u29.Name));
			l__warn__19(l__tostring__20(v130));
			u29:Destroy();
		end;
		function v128.BindEvent(p20, p21)
			local v132 = p20:Connect(p21);
			local l__Disconnect__30 = v132.Disconnect;
			local l__Events__31 = u29.Events;
			local function v133()
				l__Disconnect__30(v132);
				for v134, v135 in l__next__14, l__Events__31 do
					if v135.Signal == v132 then
						l__table__22.remove(l__Events__31, v134);
					end;
				end;
			end;
			l__table__22.insert(l__Events__31, {
				Signal = v132, 
				Remove = v133
			});
			return {
				Disconnect = v133, 
				disconnect = v133, 
				wait = l__service__10.CheckProperty(v132, "wait") and v132.wait
			}, v132;
		end;
		function v128.ClearEvents()
			for v136, v137 in l__next__14, u29.Events do
				v137:Remove();
			end;
		end;
		function v128.Destroy()
			l__pcall__11(function()
				if u29.CustomDestroy then
					u29.CustomDestroy();
					return;
				end;
				l__service__10.UnWrap(u29.Object):Destroy();
			end);
			u29.Destroyed = true;
			u29.Active = false;
			l__client__2.GUIs[v127] = nil;
			u29.ClearEvents();
		end;
		function v128.UnRegister()
			l__client__2.GUIs[v127] = nil;
			if u29.AncestryEvent then
				u29.AncestryEvent:Disconnect();
			end;
		end;
		function v128.Register(p22, p23)
			if not p23 then
				p23 = p22;
			end;
			p23:SetSpecial("Destroy", u29.Destroy);
			u29.Object = l__service__10.Wrap(p23);
			u29.Class = p23.ClassName;
			if u29.AncestryEvent then
				u29.AncestryEvent:Disconnect();
			end;
			u29.AncestryEvent = p23.AncestryChanged:Connect(function(p24, p25)
				if l__client__2.GUIs[v127] then
					if l__rawequal__27(p24, u29.Object) and u29.Class == "TextLabel" and p25 == l__service__10.PlayerGui then
						l__wait__28();
						u29.Object.Parent = u1.GetHolder();
						return;
					end;
					if l__rawequal__27(p24, u29.Object) and p25 == nil and not u29.KeepAlive then
						u29:Destroy();
						return;
					end;
					if l__rawequal__27(p24, u29.Object) and p25 ~= nil then
						u29.Active = true;
						l__client__2.GUIs[v127] = u29;
					end;
				end;
			end);
			l__client__2.GUIs[v127] = u29;
		end;
		u29 = v128;
		if p19 then
			for v138, v139 in l__next__14, p19 do
				u29[v138] = v139;
			end;
		end;
		p18.Name = u6.GetRandom();
		u29:Register(p18);
		return u29, v127;
	end;
	l__client__2.UI = v1;
	l__client__2.UI.RegisterGui = l__client__2.UI.Register;
	l__client__2.UI.GetGui = l__client__2.UI.Get;
	l__client__2.UI.PrepareGui = l__client__2.UI.Prepare;
	l__client__2.UI.MakeGui = l__client__2.UI.Make;
end;

