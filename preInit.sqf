CODI_OFT_fnc_createMarkerLocal = {
	private["_intended","_markerPos","_markerType","_markerColor","_markerGroupSize","_markerName","_marker","_marker2","_side","_markerText","_markerTime","_profileName","_CODI_OFT_markerCount","_CODI_OFT_tCount","_CODI_OFT_medCount","_CODI_OFT_wpCount","_CODI_OFT_lzCount"];
	_markerPos = _this select 0;
	_markerType = _this select 1;
	_markerColor = _this select 2;
	_markerGroupSize = _this select 3;
	_markerName = _this select 4;
	_side = _this select 5;
	_markerText = _this select 6;
	_profileName = _this select 7;
	_CODI_OFT_markerCount = _this select 8;
	_CODI_OFT_lzCount = _this select 9;
	_CODI_OFT_wpCount = _this select 10;
	_CODI_OFT_medCount = _this select 11;
	_CODI_OFT_tCount = _this select 12;
	_markerTime = param[13, time];
	_marker = "";
	_marker2 = "";
	_intended = false;
	if (hasInterface) then
	{
		if (_side == CODI_OFT_side) then
		{
			_intended = true;
			_marker = createMarkerLocal[_markerName, _markerPos];
			_marker setMarkerTypeLocal _markerType;
			_marker setMarkerTextLocal _markerText;
			if (isClass (configFile >> "CfgPatches" >> "CODI_OFT_ACE")) then
			{
				if ([player, "CODI_OFT_Tablet"] call ace_common_fnc_hasItem) then
				{
					_marker setMarkerAlphaLocal 1;
				}
				else
				{
					_marker setMarkerAlphaLocal 0;
				};
			}
			else
			{
				_marker setMarkerAlphaLocal 1;
			};
			if (!(_markerType in ["waypoint","hd_dot","MinefieldAP","hd_pickup","hd_destroy","KIA"])) then
			{
				if (_markerGroupSize == "") then
				{
					_markerGroupSize = "group_1";
				};
				_marker2 = createMarkerLocal[_markerName+"_groupSize", _markerPos];
				_marker2 setMarkerTypeLocal _markerGroupSize;
				if (isClass (configFile >> "CfgPatches" >> "CODI_OFT_ACE")) then
				{
					if ([player, "CODI_OFT_Tablet"] call ace_common_fnc_hasItem) then
					{
						_marker2 setMarkerAlphaLocal 1;
					}
					else
					{
						_marker2 setMarkerAlphaLocal 0;
					};
				}
				else
				{
					_marker2 setMarkerAlphaLocal 1;
				};
				_marker2 setMarkerSizeLocal [1.5, 1.5];
			};
			_marker setMarkerColorLocal _markerColor;
		};
	};
	if (!_intended) then
	{
		_marker = _markerName;
		if (!(_markerType in ["waypoint","hd_dot","MinefieldAP","hd_pickup","hd_destroy","KIA"])) then
		{
			_marker2 = _markerName+"_groupSize";
		};
	};
	if (isServer) then
	{
		{
			_entry = _x;
			if ((_entry select 0) == _profileName) then
			{
				_entry set [1, _CODI_OFT_markerCount];
				_entry set [2, _CODI_OFT_lzCount];
				_entry set [3, _CODI_OFT_wpCount];
				_entry set [4, _CODI_OFT_medCount];
				_entry set [5, _CODI_OFT_tCount];
				CODI_OFT_counter set [_forEachIndex, _entry];
			};
		}
		forEach CODI_OFT_counter;
	};
	CODI_OFT_markers pushBack [_marker, _marker2, _markerTime, _side, _markerPos, _markerType, _markerColor, _markerGroupSize, _markerText, "", -1];comment "TODO restructure per side";
};
CODI_OFT_fnc_createMarkerGlobal = {
	private["_markerPos","_markerType","_markerColor","_markerGroupSize"];
	_markerPos = _this select 0;
	_markerType = _this select 1;
	_markerColor = _this select 2;
	_markerGroupSize = _this select 3;
	_markerText = _this select 4;
	if (_markerType in ["hd_pickup"]) then
	{
		_markerText = toString[toArray(groupId(group player)) select 0] + str(CODI_OFT_lzCount);
	};
	if (_markerType in ["hd_dot"]) then
	{
		_markerText = toString[toArray(groupId(group player)) select 0] + str(CODI_OFT_wpCount);
	};
	if (_markerType in ["KIA"]) then
	{
		_markerText = toString[toArray(groupId(group player)) select 0] + str(CODI_OFT_medCount);
	};
	if (_markerType in ["hd_destroy"]) then
	{
		_markerText = toString[toArray(groupId(group player)) select 0] + str(CODI_OFT_tCount);
	};
	[[_markerPos, _markerType, _markerColor, _markerGroupSize, format["CODI_OFT_%1_%2", profileName, CODI_OFT_markerCount], CODI_OFT_side, _markerText, profileName, CODI_OFT_markerCount, CODI_OFT_lzCount, CODI_OFT_wpCount, CODI_OFT_medCount, CODI_OFT_tCount], "CODI_OFT_fnc_createMarkerLocal", true, false] call BIS_fnc_MP;
	CODI_OFT_markerCount = CODI_OFT_markerCount + 1;
	if (_markerType in ["hd_pickup"]) then
	{
		CODI_OFT_lzCount = CODI_OFT_lzCount + 1;
	};
	if (_markerType in ["hd_dot"]) then
	{
		CODI_OFT_wpCount = CODI_OFT_wpCount + 1;
	};
	if (_markerType in ["KIA"]) then
	{
		CODI_OFT_medCount = CODI_OFT_medCount + 1;
	};
	if (_markerType in ["hd_destroy"]) then
	{
		CODI_OFT_tCount = CODI_OFT_tCount + 1;
	};
};
CODI_OFT_fnc_deleteMarkerLocal = {
	private["_marker","_toBeDeletedIndex","_toBeDeleted","_side"];
	_marker = _this select 0;
	_side = _this select 1;
	_toBeDeletedIndex = -1;
	{
		if ((_x select 0) == _marker) then
		{
			_toBeDeletedIndex = _forEachIndex;
		};
	}
	forEach CODI_OFT_markers;
	if (_toBeDeletedIndex != -1) then
	{
		_toBeDeleted = CODI_OFT_markers select _toBeDeletedIndex;
		CODI_OFT_markers = [CODI_OFT_markers, _toBeDeletedIndex] call BIS_fnc_removeIndex;
		if (hasInterface) then
		{
			if (_side == CODI_OFT_side) then
			{
				deleteMarkerLocal (_toBeDeleted select 0);
				if ((_toBeDeleted select 1) != "") then
				{
					deleteMarkerLocal (_toBeDeleted select 1);
				};
				if ((_toBeDeleted select 9) != "") then
				{
					deleteMarkerLocal (_toBeDeleted select 9);
				};
			};
		};
	};
};
CODI_OFT_fnc_deleteMarkerGlobal = {
	private["_marker"];
	_marker = _this select 0;
	[[_marker, CODI_OFT_side], "CODI_OFT_fnc_deleteMarkerLocal", true, false] call BIS_fnc_MP;
};
CODI_OFT_fnc_setMarkerPosLocal = {
	private["_intended","_pos","_marker","_entry","_side"];
	_marker = _this select 0;
	_pos = _this select 1;
	_side = _this select 2;
	_intended = false;
	if (hasInterface) then
	{
		if (_side == CODI_OFT_side) then
		{
			_intended = true;
			{
				_entry = _x;
				if ((_entry select 0) == _marker) then
				{
					(_entry select 0) setMarkerPosLocal _pos;
					if (isClass (configFile >> "CfgPatches" >> "CODI_OFT_ACE")) then
					{
						if ([player, "CODI_OFT_Tablet"] call ace_common_fnc_hasItem) then
						{
							(_entry select 0) setMarkerAlphaLocal 1;
						}
						else
						{
							(_entry select 0) setMarkerAlphaLocal 0;
						};
					}
					else
					{
						(_entry select 0) setMarkerAlphaLocal 1;
					};
					if ((_entry select 1) != "") then
					{
						(_entry select 1) setMarkerPosLocal _pos;
						if (isClass (configFile >> "CfgPatches" >> "CODI_OFT_ACE")) then
						{
							if ([player, "CODI_OFT_Tablet"] call ace_common_fnc_hasItem) then
							{
								(_entry select 1) setMarkerAlphaLocal 1;
							}
							else
							{
								(_entry select 1) setMarkerAlphaLocal 0;
							};
						}
						else
						{
							(_entry select 1) setMarkerAlphaLocal 1;
						};
					};
					_entry set [2, time];
					_entry set [4, _pos];
					CODI_OFT_markers set [_forEachIndex, _entry];
				};
			}
			forEach CODI_OFT_markers;
		};
	};
	if (isServer && !_intended) then
	{
		{
			_entry = _x;
			if ((_entry select 0) == _marker) then
			{
				_entry set [2, time];
				_entry set [4, _pos];
				CODI_OFT_markers set [_forEachIndex, _entry];
			};
		}
		forEach CODI_OFT_markers;
	};
};
CODI_OFT_fnc_setMarkerPosGlobal = {
	private["_pos","_marker"];
	_marker = _this select 0;
	_pos = _this select 1;
	[[_marker, _pos, CODI_OFT_side], "CODI_OFT_fnc_setMarkerPosLocal", true, false] call BIS_fnc_MP;
};
CODI_OFT_fnc_requestMarkers = {
	[[profileName, groupId(group player)], "CODI_OFT_fnc_syncMarkers", false, false] call BIS_fnc_MP;
};
CODI_OFT_fnc_syncMarkers = {
	comment "TODO minimize transfered data";
	private["_groupName","_entry","_groupCount","_colorsCount","_colors","_color","_profileName","_count","_lzCount","_wpCount","_medCount","_tCount"];
	_profileName = _this select 0;
	_groupName = _this select 1;
	_count = 0;
	_lzCount = 0;
	_wpCount = 0;
	_medCount = 0;
	_tCount = 0;
	{
		_entry = _x;
		if ((_entry select 0) == _profileName) then
		{
			_count = _entry select 1;
			_lzCount = _entry select 2;
			_wpCount = _entry select 3;
			_medCount = _entry select 4;
			_tCount = _entry select 5;
		};
	}
	forEach CODI_OFT_counter;
	_color = "";
	{
		_entry = _x;
		if ((_entry select 0) == _groupName) then
		{
			_color = _entry select 1;
		};
	}
	forEach CODI_OFT_groupColors;
	if (_color == "") then
	{
		_colors = CODI_OFT_possibleMarkerColors;
		_colorsCount = count _colors;
		_groupCount = count CODI_OFT_groupColors;
		_groupCount = _groupCount mod _colorsCount;
		_color = _colors select _groupCount;
		CODI_OFT_groupColors pushBack [_groupName, _color];
	};
	[[_profileName, _count, _lzCount, _wpCount, _medCount, _tCount, CODI_OFT_markers, _color], "CODI_OFT_fnc_getMarkers", true, false] call BIS_fnc_MP;
};
CODI_OFT_fnc_getMarkers = {
	private["_time","_offset","_entry","_entryMarker1","_entryMarker2","_entrySide","_entryPos","_entryType","_entryColor","_entryGroupSize","_entryText","_entryTime"];
	if ((_this select 0) == profileName) then
	{
		CODI_OFT_markerCount = _this select 1;
		CODI_OFT_lzCount = _this select 2;
		CODI_OFT_wpCount = _this select 3;
		CODI_OFT_medCount = _this select 4;
		CODI_OFT_tCount = _this select 5;
		CODI_OFT_groupColor = _this select 7;
		_time = time;
		_offset = serverTime - _time;
		if (!isMultiplayer) then
		{
			_offset = 0;
		};
		{
			_entry = _x;
			_entryMarker1 = _entry select 0;
			_entryMarker2 = _entry select 1;
			_entryTime = _entry select 2;
			_entrySide = _entry select 3;
			_entryPos = _entry select 4;
			_entryType = _entry select 5;
			_entryColor = _entry select 6;
			_entryGroupSize = _entry select 7;
			_entryText = _entry select 8;
			_entryTime = _entryTime + _offset;
			[_entryPos, _entryType, _entryColor, _entryGroupSize, _entryMarker1, _entrySide, _entryText, profileName, CODI_OFT_markerCount, CODI_OFT_lzCount, CODI_OFT_wpCount, CODI_OFT_medCount, CODI_OFT_tCount, _entryTime] call CODI_OFT_fnc_createMarkerLocal;
		}
		forEach (_this select 6);
	};
};
CODI_OFT_fnc_requestGroupColor = {
	[[profileName, groupId(group player)], "CODI_OFT_fnc_syncGroupColor", false, false] call BIS_fnc_MP;
};
CODI_OFT_fnc_syncGroupColor = {
	private["_groupName","_entry","_groupCount","_colorsCount","_colors","_color","_profileName","_count"];
	_profileName = _this select 0;
	_groupName = _this select 1;
	_color = "";
	{
		_entry = _x;
		if ((_entry select 0) == _groupName) then
		{
			_color = _entry select 1;
		};
	}
	forEach CODI_OFT_groupColors;
	if (_color == "") then
	{
		_colors = CODI_OFT_possibleMarkerColors;
		_colorsCount = count _colors;
		_groupCount = count CODI_OFT_groupColors;
		_groupCount = _groupCount mod _colorsCount;
		_color = _colors select _groupCount;
		CODI_OFT_groupColors pushBack [_groupName, _color];
	};
	[[_profileName, _color], "CODI_OFT_fnc_getGroupColor", true, false] call BIS_fnc_MP;
};
CODI_OFT_fnc_getGroupColor = {
	if ((_this select 0) == profileName) then
	{
		CODI_OFT_groupColor = _this select 1;
	};
};
CODI_OFT_fnc_handleKeyDown = {
	private["_key","_handled"];
	_key = _this select 1;
	_handled = false;
	if (CODI_OFT_hasOFT) then
	{
		if (_key == 211) then
		{
			["CODI_OFT_tryDeleteMarkerGlobal", "onEachFrame", {[] call CODI_OFT_fnc_tryDeleteMarkerGlobal;}] call BIS_fnc_addStackedEventHandler;
		};
	};
	_handled
};
CODI_OFT_fnc_handleKeyUp = {
	private["_key","_handled"];
	_key = _this select 1;
	_handled = false;
	if (CODI_OFT_hasOFT) then
	{
		if (_key == 211) then
		{
			["CODI_OFT_tryDeleteMarkerGlobal", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		};
	};
	_handled
};
CODI_OFT_fnc_handleMouseButtonDblClick = {
	private["_handled","_ctrlPressed","_pos","_control"];
	_control = _this select 0;
	_pos = [_this select 2, _this select 3];
	_ctrlPressed = _this select 5;
	_handled = false;
	if (CODI_OFT_hasOFT) then
	{
		if (_ctrlPressed) then
		{
			_pos = _control ctrlMapScreenToWorld _pos;
			[_pos, CODI_OFT_markerType, CODI_OFT_markerColor, CODI_OFT_markerGroupSize, CODI_OFT_markerText] call CODI_OFT_fnc_createMarkerGlobal;
			_handled = true;
		};
	};
	_handled
};
CODI_OFT_fnc_handleMouseMoving = {
	private["_control"];
	_control = _this select 0;
	CODI_OFT_mousePos = [_this select 1, _this select 2];
	CODI_OFT_mousePosWorld = _control ctrlMapScreenToWorld CODI_OFT_mousePos;
	if (CODI_OFT_changeDirMarker != "") then
	{
		{
			if ((_x select 0) == CODI_OFT_changeDirMarker) then
			{
				_pos = _x select 4;
				_mapControl = (findDisplay  12) displayCtrl 51;
				_mousePos = _mapControl ctrlMapScreenToWorld CODI_OFT_mousePos;
				_dir = [_pos, _mousePos] call BIS_fnc_dirTo;
				_x set [10, _dir];
				CODI_OFT_markers set [_forEachIndex, _x];
			};
		}
		forEach CODI_OFT_markers;
	};
	false
};
CODI_OFT_fnc_tryDeleteMarkerGlobal = {
	private["_mapControl","_pos","_nearesIndex","_marker"];
	_mapControl = (findDisplay  12) displayCtrl 51;
	_pos = _mapControl ctrlMapScreenToWorld CODI_OFT_mousePos;
	_nearesIndex = [_pos] call CODI_OFT_fnc_getNearestMarker;
	if (_nearesIndex != -1) then
	{
		_marker = (CODI_OFT_markers select _nearesIndex) select 0;
		if ((CODI_OFT_mousePos distance (_mapControl ctrlMapWorldToScreen (getMarkerPos _marker))) < 0.02) then
		{
			[_marker] call CODI_OFT_fnc_deleteMarkerGlobal;
		};
	};
};
CODI_OFT_fnc_handleMouseButtonClick = {
	private["_entry","_shift","_handled","_ctrl","_button","_mapControl","_pos","_nearesIndex","_marker"];
	_mapControl = _this select 0;
	_button = _this select 1;
	_shift = _this select 4;
	_ctrl = _this select 5;
	_handled = false;
	if (_ctrl) then
	{
		if (_button == 1) then
		{
			_pos = _mapControl ctrlMapScreenToWorld CODI_OFT_mousePos;
			_nearesIndex = [_pos] call CODI_OFT_fnc_getNearestMarker;
			if (_nearesIndex != -1) then
			{
				_marker = (CODI_OFT_markers select _nearesIndex) select 0;
				if ((CODI_OFT_mousePos distance (_mapControl ctrlMapWorldToScreen (getMarkerPos _marker))) < 0.02) then
				{
					CODI_OFT_markerType = getMarkerType _marker;
					CODI_OFT_markerColor = getMarkerColor _marker;
					CODI_OFT_markerGroupSize = getMarkerType ((CODI_OFT_markers select _nearesIndex) select 1);
				};
			};
		};
		if (_button == 0) then
		{
			CODI_OFT_mousePos = [_this select 2, _this select 3];
			CODI_OFT_mousePosWorld = _mapControl ctrlMapScreenToWorld CODI_OFT_mousePos;
			CODI_OFT_measurePos = CODI_OFT_mousePosWorld;
			_display = findDisplay  12;
			if (((_mapControl ctrlMapWorldToScreen (getPos player)) distance2D CODI_OFT_mousePos) < 0.05) then
			{
				CODI_OFT_measurePlayer = true;
			}
			else
			{
				CODI_OFT_measurePlayer = false;
			};
		};
	};
	if (_shift) then
	{
		_pos = _mapControl ctrlMapScreenToWorld CODI_OFT_mousePos;
		_nearesIndex = [_pos] call CODI_OFT_fnc_getNearestMarker;
		if (_nearesIndex != -1) then
		{
			_entry = CODI_OFT_markers select _nearesIndex;
			_entry set [10, -1];
			CODI_OFT_markers set [_nearesIndex, _entry];
		};
	};
	_handled
};
CODI_OFT_fnc_handleMouseButtonDown = {
	private["_shift","_ctrl","_button","_mapControl","_pos","_nearesIndex","_marker"];
	_mapControl = _this select 0;
	_button = _this select 1;
	_shift = _this select 4;
	_ctrl = _this select 5;
	if (CODI_OFT_hasOFT) then
	{
		if (_button == 0) then
		{
			if (_ctrl) then
			{
				_pos = _mapControl ctrlMapScreenToWorld CODI_OFT_mousePos;
				_nearesIndex = [_pos] call CODI_OFT_fnc_getNearestMarker;
				if (_nearesIndex != -1) then
				{
					_marker = (CODI_OFT_markers select _nearesIndex) select 0;
					if ((CODI_OFT_mousePos distance (_mapControl ctrlMapWorldToScreen (getMarkerPos _marker))) < 0.02) then
					{
						CODI_OFT_draggedMarker = _marker;
					};
				};
			};
			if (_shift) then
			{
				_pos = _mapControl ctrlMapScreenToWorld CODI_OFT_mousePos;
				_nearesIndex = [_pos] call CODI_OFT_fnc_getNearestMarker;
				if (_nearesIndex != -1) then
				{
					if (!((getMarkerType ((CODI_OFT_markers select _nearesIndex) select 0)) in ["waypoint","hd_dot","hd_pickup","hd_destroy","KIA"])) then
					{
						CODI_OFT_changeDirMarker = (CODI_OFT_markers select _nearesIndex) select 0;
					};
				};
			};
		};
	};
};
CODI_OFT_fnc_getNearestMarker = {
	private["_distance","_nearestDistance","_nearesIndex","_pos"];
	_pos = _this select 0;
	_nearesIndex = -1;
	_nearestDistance = 999999;
	{
		if ((_x select 3) == CODI_OFT_side) then
		{
			_distance = _pos distance (getMarkerPos (_x select 0));
			if (_distance < _nearestDistance) then
			{
				_nearestDistance = _distance;
				_nearesIndex = _forEachIndex;
			};
		};
	}
	forEach CODI_OFT_markers;
	_nearesIndex
};
CODI_OFT_fnc_handleMouseButtonUp = {
	private["_shift","_markerColor","_markerType","_pos","_mapControl","_button","_ctrl"];
	_mapControl = _this select 0;
	_button = _this select 1;
	_shift = _this select 4;
	_ctrl = _this select 5;
	if (CODI_OFT_hasOFT) then
	{
		if (_button == 0) then
		{
			if (_ctrl) then
			{
				if (CODI_OFT_draggedMarker != "") then
				{
					_pos = [_this select 2, _this select 3];
					_pos = _mapControl ctrlMapScreenToWorld _pos;
					_markerType = getMarkerType CODI_OFT_draggedMarker;
					if (_markerType in ["waypoint","hd_dot","hd_pickup","hd_destroy","KIA"]) then
					{
						_markerColor = getMarkerColor CODI_OFT_draggedMarker;
						if (_markerColor != CODI_OFT_groupColor || (toArray(markerText CODI_OFT_draggedMarker) select 0) != (toArray(groupId(group player)) select 0)) then
						{
							[_pos, _markerType, CODI_OFT_groupColor, "", ""] call CODI_OFT_fnc_createMarkerGlobal;
							[CODI_OFT_draggedMarker] call CODI_OFT_fnc_deleteMarkerGlobal;
						}
						else
						{
							[CODI_OFT_draggedMarker, _pos] call CODI_OFT_fnc_setMarkerPosGlobal;
						};
					}
					else
					{
						[CODI_OFT_draggedMarker, _pos] call CODI_OFT_fnc_setMarkerPosGlobal;
					};
					CODI_OFT_draggedMarker = "";
				};
			};
			if (_shift) then
			{
				if (CODI_OFT_changeDirMarker != "") then
				{
					{
						if ((_x select 0) == CODI_OFT_changeDirMarker) then
						{
							[CODI_OFT_changeDirMarker, _x select 10] call CODI_OFT_fnc_setMarkerDirGlobal;
						};
					}
					forEach CODI_OFT_markers;
				};
			};
			CODI_OFT_changeDirMarker = "";
		};
	};
};
CODI_OFT_fnc_handleMarkerAlpha = {
	private["_alpha"];
	{
		if ((_x select 3) == CODI_OFT_side) then
		{
			if (isClass (configFile >> "CfgPatches" >> "CODI_OFT_ACE")) then
			{
				if ([player, "CODI_OFT_Tablet"] call ace_common_fnc_hasItem) then
				{
					if (!((_x select 5) in ["waypoint","hd_dot","MinefieldAP","hd_pickup","hd_destroy","KIA"])) then
					{
						_alpha = time - (_x select 2);
						_alpha = _alpha / (30.0*60);
						_alpha = 1 - _alpha;
						_alpha = 0.75*_alpha;
						if (_alpha < 0.25) then
						{
							_alpha = 0.25;
						};
						_alpha = _alpha + 0.25;
						(_x select 0) setMarkerAlphaLocal _alpha;
						if ((_x select 1) != "") then
						{
							(_x select 1) setMarkerAlphaLocal _alpha;
						};
						if ((_x select 9) != "") then
						{
							(_x select 9) setMarkerAlphaLocal _alpha;
						};
					}
					else
					{
						(_x select 0) setMarkerAlphaLocal 1;
					};
				}
				else
				{
					(_x select 0) setMarkerAlphaLocal 0;
					if ((_x select 1) != "") then
					{
						(_x select 1) setMarkerAlphaLocal 0;
					};
				};
			}
			else
			{
				if (!((_x select 5) in ["waypoint","hd_dot","MinefieldAP","hd_pickup","hd_destroy","KIA"])) then
				{
					_alpha = time - (_x select 2);
					_alpha = _alpha / (30.0*60);
					_alpha = 1 - _alpha;
					_alpha = 0.75*_alpha;
					if (_alpha < 0.25) then
					{
						_alpha = 0.25;
					};
					_alpha = _alpha + 0.25;
					(_x select 0) setMarkerAlphaLocal _alpha;
					if ((_x select 1) != "") then
					{
						(_x select 1) setMarkerAlphaLocal _alpha;
					};
					if ((_x select 9) != "") then
					{
						(_x select 9) setMarkerAlphaLocal _alpha;
					};
				};
			};
		};
	}
	forEach CODI_OFT_markers;
};
CODI_OFT_fnc_createSpotRep = {
	private["_src","_dst","_intersections"];
	_src = AGLToASL positionCameraToWorld[0,0,1];
	_dst = AGLToASL positionCameraToWorld[0,0,3001];
	_intersections = lineIntersectsSurfaces [_src, _dst, objNull, objNull, true, 1];
	if (count _intersections > 0) then
	{
		[(_intersections select 0) select 0, CODI_OFT_markerType, CODI_OFT_markerColor, CODI_OFT_markerGroupSize, CODI_OFT_markerText] call CODI_OFT_fnc_createMarkerGlobal;
	};
};
CODI_OFT_fnc_dist = {
	private["_p1","_p2","_control"];
	_p1 = _this select 0;
	_p2 = _this select 1;
	_control = (findDisplay 12) displayCtrl 51;
	_p1 = _control ctrlMapWorldToScreen _p1;
	_p2 = _control ctrlMapWorldToScreen _p2;
	sqrt(((_p2 select 0) - (_p1 select 0))^2 + ((_p2 select 1) - (_p1 select 1))^2)
};
CODI_OFT_fnc_recalculateDistance = {
	private["_control","_display"];
	disableSerialization;
	if (CODI_OFT_measurePlayer) then
	{
		CODI_OFT_measurePos = getPos player;
	};
	_display = findDisplay  12;
	_control = _display displayCtrl 4999;
	_control ctrlSetText (str(round(CODI_OFT_measurePos distance2D CODI_OFT_mousePosWorld))+"m");
	_control = _display displayCtrl 4998;
	_control ctrlSetText (str(round([CODI_OFT_measurePos, CODI_OFT_mousePosWorld] call BIS_fnc_dirTo))+"°");
};
CODI_OFT_fnc_setMarkerDirLocal = {
	private["_dir","_marker","_entry"];
	_marker = _this select 0;
	_dir = _this select 1;
	{
		_entry = _x;
		if ((_entry select 0) == _marker) then
		{
			_entry set [2, time];
			_entry set [10, _dir];
			(_entry select 0) setMarkerAlphaLocal 1;
			if ((_entry select 1) != "") then
			{
				(_entry select 1) setMarkerAlphaLocal 1;
			};
			if ((_entry select 9) != "") then
			{
				(_entry select 9) setMarkerAlphaLocal 1;
			};
			CODI_OFT_markers set [_forEachIndex, _entry];
		};
	}
	forEach CODI_OFT_markers;
};
CODI_OFT_fnc_setMarkerDirGlobal = {
	private["_dir","_marker"];
	_marker = _this select 0;
	_dir = _this select 1;
	[[_marker, _dir], "CODI_OFT_fnc_setMarkerDirLocal", true, false] call BIS_fnc_MP;
};
CODI_OFT_fnc_handleDir = {
	private["_markerName","_dist","_control","_dir","_pos","_marker"];
	disableSerialization;
	{
		_side = _x select 3;
		_pos = _x select 4;
		_marker = _x select 9;
		_dir = _x select 10;
		_control = (findDisplay 12) displayCtrl 51;
		_dist = 0.05;
		if (_side == CODI_OFT_side) then
		{
			if (_marker == "") then
			{
				if (_dir != -1) then
				{
					_pos = _control ctrlMapWorldToScreen _pos;
					_pos = [(_pos select 0)+_dist*sin(_dir), (_pos select 1)-_dist*cos(_dir)];
					_pos = _control ctrlMapScreenToWorld _pos;
					_markerName = (_x select 0)+"_dir";
					_marker = createMarkerLocal[_markerName, _pos];
					_marker setMarkerTypeLocal "hd_arrow";
					_marker setMarkerColorLocal (_x select 6);
					_marker setMarkerDirLocal _dir;
					_x set [9, _marker];
					CODI_OFT_markers set [_forEachIndex, _x];
				};
			}
			else
			{
				if (_dir == -1) then
				{
					deleteMarkerLocal _marker;
					_x set [9, ""];
					CODI_OFT_markers set [_forEachIndex, _x];
				}
				else
				{
					_pos = _control ctrlMapWorldToScreen _pos;
					_pos = [(_pos select 0)+_dist*sin(_dir), (_pos select 1)-_dist*cos(_dir)];
					_pos = _control ctrlMapScreenToWorld _pos;
					_marker setMarkerPosLocal _pos;
					_marker setMarkerDirLocal _dir;
				};
			};
		};
	}
	forEach CODI_OFT_markers;
};