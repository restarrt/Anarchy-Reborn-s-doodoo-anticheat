
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
	getfenv().client = nil;
	getfenv().service = nil;
	getfenv().script = nil;
	l__client__2.GUIs = {};
	l__client__2.GUIHolder = service.New("Folder");
	l__client__2.Variables = {
		Init = function()
			u1 = l__client__2.UI;
			u3 = l__client__2.Anti;
			u4 = l__client__2.Core;
			u5 = l__client__2.Variables;
			u6 = l__client__2.Functions;
			u7 = l__client__2.Process;
			u8 = l__client__2.Remote;
			u5.Init = nil;
		end, 
		RunLast = function()
			u5.RunLast = nil;
		end, 
		RunAfterLoaded = function()
			l__client__2.Variables.CodeName = l__client__2.Remote.Get("Variable", "CodeName");
			u5.RunAfterLoaded = nil;
		end, 
		CodeName = "", 
		UIKeepAlive = true, 
		KeybindsEnabled = true, 
		ParticlesEnabled = true, 
		CapesEnabled = true, 
		HideChatCommands = false, 
		Particles = {}, 
		KeyBinds = {}, 
		Aliases = {}, 
		Capes = {}, 
		savedUI = {}, 
		localSounds = {}, 
		ESPObjects = {}, 
		LightingSettings = {
			Ambient = service.Lighting.Ambient, 
			Brightness = service.Lighting.Brightness, 
			ColorShift_Bottom = service.Lighting.ColorShift_Bottom, 
			ColorShift_Top = service.Lighting.ColorShift_Top, 
			GlobalShadows = service.Lighting.GlobalShadows, 
			OutdoorAmbient = service.Lighting.OutdoorAmbient, 
			Outlines = service.Lighting.Outlines, 
			ShadowColor = service.Lighting.ShadowColor, 
			GeographicLatitude = service.Lighting.GeographicLatitude, 
			Name = service.Lighting.Name, 
			TimeOfDay = service.Lighting.TimeOfDay, 
			FogColor = service.Lighting.FogColor, 
			FogEnd = service.Lighting.FogEnd, 
			FogStart = service.Lighting.FogStart
		}
	};
end;

