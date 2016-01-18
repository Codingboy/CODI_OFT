class CfgPatches
{
	class CODI_OFT
	{
		authors[] = {"Coding"};
		version = 0.1;
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {};
		license = "CC-BY-NC-SA 4.0";
		licenseURL = "http://creativecommons.org/licenses/by-nc-sa/4.0/";
	};
};
class Extended_PreInit_EventHandlers
{
	class CODI_OFT_Init
	{
		init = "[] call compile preprocessFileLineNumbers '\CODI_OFT\preInit.sqf';";
	};
};
class Extended_PostInit_EventHandlers
{
	class CODI_OFT_Init
	{
		init = "[] execVM '\CODI_OFT\postInit.sqf';";
	};
};