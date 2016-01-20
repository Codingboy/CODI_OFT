if (isServer) then
{
	CODI_OFT_side = "";
	CODI_OFT_counter = [];
	CODI_OFT_groupColors = [];
	CODI_OFT_possibleMarkerColors = ["ColorBlue","ColorGreen","ColorOrange","ColorRed","ColorPink","ColorBrown","ColorGrey","ColorBlack","ColorWhite","ColorKhaki"];
};
CODI_OFT_markers = [];
if (hasInterface) then
{
	[] call CODI_OFT_fnc_requestMarkers;
	CODI_OFT_delPressed = false;
	CODI_OFT_mousePos = [0,0];
	CODI_OFT_markerCount = 0;
	CODI_OFT_markerType = "o_inf";
	CODI_OFT_markerColor = "ColorEAST";
	CODI_OFT_markerGroupSize = "group_1";
	CODI_Oft_markerText = "";
	CODI_OFT_lzCount = 0;
	CODI_OFT_wpCount = 0;
	CODI_OFT_medCount = 0;
	CODI_OFT_tCount = 0;
	CODI_OFT_measurePos = [0,0];
	CODI_OFT_mousePosWorld = [0,0];
	CODI_OFT_spotrepItems = ["Rangefinder", "ACE_Yardage450", "ACE_Vector", "Laserdesignator", "Laserdesignator_02", "Laserdesignator_03"];
	CODI_OFT_measurePlayer = true;
	waitUntil{!isNull player};
	CODI_OFT_side = side player;
	CODI_OFT_group = group player;
	if (isClass (configFile >> "CfgPatches" >> "CODI_OFT_ACE")) then
	{
		CODI_OFT_hasOFT = [player, "CODI_OFT_Tablet"] call ace_common_fnc_hasItem;
	}
	else
	{
		CODI_OFT_hasOFT = true;
	};
	player addAction["Spotrep", {call CODI_OFT_fnc_createSpotRep}, [], 10, false, true, "", "((currentWeapon _target) in CODI_OFT_spotrepItems) && CODI_OFT_hasOFT"];
	player addMPEventHandler["MPRespawn", {
		player addAction["Spotrep", {call CODI_OFT_fnc_createSpotRep}, [], 10, false, true, "", "((currentWeapon _target) in CODI_OFT_spotrepItems) && CODI_OFT_hasOFT"];
	}];
	[] spawn {
		private["_trackedUAV","_trackedVehicle"];
		_trackedUAV = [];
		_trackedVehicle = [];
		while {true} do
		{
			{
				if (!(_x in _trackedUAV)) then
				{
					_trackedUAV pushBack _x;
					_x addAction["Spotrep", {call CODI_OFT_fnc_createSpotRep}, [], 10, false, true, "", "(getConnectedUAV player) == _target && CODI_OFT_hasOFT"];
				};
			}
			forEach allUnitsUAV;
			{
				if (!(_x in _trackedVehicle)) then
				{
					_trackedVehicle pushBack _x;
					_x addAction["Spotrep", {call CODI_OFT_fnc_createSpotRep}, [], 10, false, true, "", "((gunner _target == player) || (commander _target == player)) && CODI_OFT_hasOFT"];
				};
			}
			forEach vehicles;
			sleep 60;
		};
	};
	[] spawn {
		private["_mapControl","_i","_mapDisplay"];
		disableSerialization;
		while {true} do
		{
			call CODI_OFT_fnc_handleMarkerAlpha;
			if (group player != CODI_OFT_group) then
			{
				CODI_OFT_group = group player;
				[] call CODI_OFT_fnc_requestGroupColor;
			};
			sleep 10;
		};
	};
	disableSerialization;
	waitUntil{!isNull(findDisplay 12)};
	_mapDisplay = findDisplay 12;
	_mapControl = _mapDisplay displayCtrl 51;
	_mapControl ctrlAddEventHandler ["MouseMoving", {_this call CODI_OFT_fnc_handleMouseMoving;}];
	_mapControl ctrlAddEventHandler ["MouseButtonDblClick", {_this call CODI_OFT_fnc_handleMouseButtonDblClick;}];
	_mapControl ctrlAddEventHandler ["MouseButtonClick", {_this call CODI_OFT_fnc_handleMouseButtonClick;}];
	_mapDisplay displayAddEventHandler ["KeyDown", {_this call CODI_OFT_fnc_handleKeyDown;}];
	_mapDisplay displayAddEventHandler ["KeyUp", {_this call CODI_OFT_fnc_handleKeyUp;}];
	_mapControl ctrlAddEventHandler ["MouseButtonDown", {_this call CODI_OFT_fnc_handleMouseButtonDown;}];
	_mapControl ctrlAddEventHandler ["MouseButtonUp", {_this call CODI_OFT_fnc_handleMouseButtonUp;}];
	[_mapControl] spawn {
		private["_control","_mapDisplay","_mapControl"];
		disableSerialization;
		_control = _this select 0;
		while {true} do
		{
			waitUntil{visibleMap};
			["CODI_OFT_recalculateDistance", "onEachFrame", {[] call CODI_OFT_fnc_recalculateDistance;}] call BIS_fnc_addStackedEventHandler;
			if (isClass (configFile >> "CfgPatches" >> "CODI_OFT_ACE")) then
			{
				if (!(CODI_OFT_hasOFT isEqualTo ([player, "CODI_OFT_Tablet"] call ace_common_fnc_hasItem))) then
				{
					CODI_OFT_hasOFT = !CODI_OFT_hasOFT;
					_mapDisplay = findDisplay  12;
					for "_i" from 5000 to 5148 do
					{
						_mapControl = _mapDisplay displayCtrl _i;
						_mapControl ctrlShow CODI_OFT_hasOFT;
						_mapControl ctrlCommit 0;
					};
				};
			};
			waitUntil{!visibleMap};
			["CODI_OFT_recalculateDistance", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		};
	};
	[] execVM "\CODI_OFT\ui.sqf";
};