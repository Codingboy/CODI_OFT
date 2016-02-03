disableSerialization;
waitUntil{!isNull(findDisplay  12)};
_mapDisplay = findDisplay  12;
_mapControl = _mapDisplay displayCtrl 51;
_width = 0.029;
_height = 0.029;
_posXAnchor = 1-0*_width;
_posYAnchor = 0.034;
_posX = _posXAnchor-_width;
_posY = _posYAnchor;
_id = 4998;
_btnActions = _mapDisplay ctrlCreate ["RscText", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	(_posXAnchor-6*_width) * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width*2 * safezoneW,
	_height * safezoneH
];
_btnActions ctrlShow true;
_btnActions ctrlCommit 0;
_btnActions = _mapDisplay ctrlCreate ["RscText", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	(_posXAnchor-6*_width) * safezoneW + safezoneX,
	(_posY+_height) * safezoneH + safezoneY,
	_width*2 * safezoneW,
	_height * safezoneH
];
_btnActions ctrlShow true;
_btnActions ctrlCommit 0;

_type = [localize "STR_CODI_OFT_unknown",localize "STR_CODI_OFT_inf",localize "STR_CODI_OFT_motInf",localize "STR_CODI_OFT_mechInf",localize "STR_CODI_OFT_tank",localize "STR_CODI_OFT_rec",localize "STR_CODI_OFT_heli",localize "STR_CODI_OFT_plane",localize "STR_CODI_OFT_uav",localize "STR_CODI_OFT_arty",localize "STR_CODI_OFT_mortar",localize "STR_CODI_OFT_naval",localize "STR_CODI_OFT_hq",localize "STR_CODI_OFT_inst",localize "STR_CODI_OFT_support"];
_color = [(profilenamespace getvariable ['Map_BLUFOR_R',0]), (profilenamespace getvariable ['Map_BLUFOR_G',1]), (profilenamespace getvariable ['Map_BLUFOR_B',1]), (profilenamespace getvariable ['Map_BLUFOR_A',0.8])];
{
	_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlShow CODI_OFT_hasOFT;
	call compile format["_btnActions ctrlAddEventHandler [""ButtonClick"", ""CODI_OFT_markerColor = 'ColorBLUFOR'; CODI_OFT_markerType = '%1'; CODI_OFT_markerText = '';""];", _x];
	_btnActions ctrlCommit 0;
	_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlSetText "\A3\ui_f\data\map\markers\nato\"+_x+".paa";
	_btnActions ctrlSetTextColor _color;
	_btnActions ctrlShow CODI_OFT_hasOFT;
	_btnActions ctrlSetTooltip format["%1 %2", localize "STR_CODI_OFT_blufor", _type select _forEachIndex];
	_btnActions ctrlCommit 0;
	_posY = _posY + _height;
}
forEach ["b_unknown","b_inf","b_motor_inf","b_mech_inf","b_armor","b_recon","b_air","b_plane","b_uav","b_art","b_mortar","b_naval","b_hq","b_installation","b_support"];
_posX = _posXAnchor-_width-_width;
_posY = _posYAnchor;
_color = [(profilenamespace getvariable ['Map_Independent_R',0]), (profilenamespace getvariable ['Map_Independent_G',1]), (profilenamespace getvariable ['Map_Independent_B',1]), (profilenamespace getvariable ['Map_Independent_A',0.8])];
{
	_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlShow CODI_OFT_hasOFT;
	call compile format["_btnActions ctrlAddEventHandler [""ButtonClick"", ""CODI_OFT_markerColor = 'ColorIndependent'; CODI_OFT_markerType = '%1'; CODI_OFT_markerText = '';""];", _x];
	_btnActions ctrlCommit 0;
	_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlSetText "\A3\ui_f\data\map\markers\nato\"+_x+".paa";
	_btnActions ctrlSetTextColor _color;
	_btnActions ctrlShow CODI_OFT_hasOFT;
	_btnActions ctrlSetTooltip format["%1 %2", localize "STR_CODI_OFT_independent", _type select _forEachIndex];
	_btnActions ctrlCommit 0;
	_posY = _posY + _height;
}
forEach ["n_unknown","n_inf","n_motor_inf","n_mech_inf","n_armor","n_recon","n_air","n_plane","n_uav","n_art","n_mortar","n_naval","n_hq","n_installation","n_support"];
_posX = _posXAnchor-_width-_width-_width;
_posY = _posYAnchor;
_color = [(profilenamespace getvariable ['Map_OPFOR_R',0]), (profilenamespace getvariable ['Map_OPFOR_G',1]), (profilenamespace getvariable ['Map_OPFOR_B',1]), (profilenamespace getvariable ['Map_OPFOR_A',0.8])];
{
	_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlShow CODI_OFT_hasOFT;
	call compile format["_btnActions ctrlAddEventHandler [""ButtonClick"", ""CODI_OFT_markerColor = 'ColorOPFOR'; CODI_OFT_markerType = '%1'; CODI_OFT_markerText = '';""];", _x];
	_btnActions ctrlCommit 0;
	_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlSetText "\A3\ui_f\data\map\markers\nato\"+_x+".paa";
	_btnActions ctrlSetTextColor _color;
	_btnActions ctrlShow CODI_OFT_hasOFT;
	_btnActions ctrlSetTooltip format["%1 %2", localize "STR_CODI_OFT_opfor", _type select _forEachIndex];
	_btnActions ctrlCommit 0;
	_posY = _posY + _height;
}
forEach ["o_unknown","o_inf","o_motor_inf","o_mech_inf","o_armor","o_recon","o_air","o_plane","o_uav","o_art","o_mortar","o_naval","o_hq","o_installation","o_support"];
_posX = _posXAnchor-_width-_width-_width-_width;
_posY = _posYAnchor;
_color = [(profilenamespace getvariable ['Map_Unknown_R',0]), (profilenamespace getvariable ['Map_Unknown_G',1]), (profilenamespace getvariable ['Map_Unknown_B',1]), (profilenamespace getvariable ['Map_Unknown_A',0.8])];
{
	_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlShow CODI_OFT_hasOFT;
	call compile format["_btnActions ctrlAddEventHandler [""ButtonClick"", ""CODI_OFT_markerColor = 'ColorUNKNOWN'; CODI_OFT_markerType = '%1'; CODI_OFT_markerText = '';""];", _x];
	_btnActions ctrlCommit 0;
	_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlSetText "\A3\ui_f\data\map\markers\nato\"+_x+".paa";
	_btnActions ctrlSetTextColor _color;
	_btnActions ctrlShow CODI_OFT_hasOFT;
	_btnActions ctrlSetTooltip format["%1 %2", localize "STR_CODI_OFT_unknown", _type select _forEachIndex];
	_btnActions ctrlCommit 0;
	_posY = _posY + _height;
}
forEach ["n_unknown","n_inf","n_motor_inf","n_mech_inf","n_armor","n_recon","n_air","n_plane","n_uav","n_art","n_mortar","n_naval","n_hq","n_installation","n_support"];
_posX = _posXAnchor-_width;
_posY = _posYAnchor+15*_height;
_type = [localize "STR_CODI_OFT_grp0",localize "STR_CODI_OFT_grp1",localize "STR_CODI_OFT_grp2",localize "STR_CODI_OFT_grp3",localize "STR_CODI_OFT_grp4",localize "STR_CODI_OFT_grp5",localize "STR_CODI_OFT_grp6"];
{
	_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlShow CODI_OFT_hasOFT;
	call compile format["_btnActions ctrlAddEventHandler [""ButtonClick"", ""CODI_OFT_markerGroupSize = '%1';""];", _x];
	_btnActions ctrlCommit 0;
	_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlSetText "\A3\ui_f\data\map\markers\nato\"+_x+".paa";
	_btnActions ctrlShow CODI_OFT_hasOFT;
	_btnActions ctrlSetTooltip format["%1", _type select _forEachIndex];
	_btnActions ctrlCommit 0;
	_posY = _posY + _height;
}
forEach ["group_0","group_1","group_2","group_3","group_4","group_5","group_6"];
_posX = _posXAnchor-_width-_width;
_posY = _posYAnchor+15*_height;
_type = [localize "STR_CODI_OFT_inf",localize "STR_CODI_OFT_car",localize "STR_CODI_OFT_boat",localize "STR_CODI_OFT_heli2",localize "STR_CODI_OFT_plane2"];
_color = [(profilenamespace getvariable ['Map_Civilian_R',0]), (profilenamespace getvariable ['Map_Civilian_G',1]), (profilenamespace getvariable ['Map_Civilian_B',1]), (profilenamespace getvariable ['Map_Civilian_A',0.8])];
{
	_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlShow CODI_OFT_hasOFT;
	call compile format["_btnActions ctrlAddEventHandler [""ButtonClick"", ""CODI_OFT_markerColor = 'ColorCivilian'; CODI_OFT_markerType = '%1'; CODI_OFT_markerText = '';""];", _x];
	_btnActions ctrlCommit 0;
	_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
	_id = _id + 1;
	_btnActions ctrlSetPosition [
		_posX * safezoneW + safezoneX,
		_posY * safezoneH + safezoneY,
		_width * safezoneW,
		_height * safezoneH
	];
	_btnActions ctrlSetText "\A3\ui_f\data\map\markers\nato\"+_x+".paa";
	_btnActions ctrlSetTextColor _color;
	_btnActions ctrlShow CODI_OFT_hasOFT;
	_btnActions ctrlSetTooltip format["%1 %2", localize "STR_CODI_OFT_civilian", _type select _forEachIndex];
	_btnActions ctrlCommit 0;
	_posY = _posY + _height;
}
forEach ["c_unknown","c_car","c_ship","c_air","c_plane"];
_posX = _posXAnchor-_width-_width-_width;
_posY = _posYAnchor+15*_height;



_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlAddEventHandler ["ButtonClick", "CODI_OFT_markerColor = CODI_OFT_groupColor; CODI_OFT_markerType = 'waypoint'; CODI_OFT_markerText = '';"];
_btnActions ctrlCommit 0;
_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlSetText "\A3\ui_f\data\map\groupicons\waypoint.paa";
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlSetTooltip (localize "STR_CODI_OFT_wp");
_btnActions ctrlCommit 0;
_posY = _posY + _height;



_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlAddEventHandler ["ButtonClick", "CODI_OFT_markerColor = CODI_OFT_groupColor; CODI_OFT_markerType = 'hd_dot'; CODI_OFT_markerText = str(CODI_OFT_wpCount);"];
_btnActions ctrlCommit 0;
_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlSetText "\A3\ui_f\data\map\markers\handdrawn\dot_ca.paa";
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlSetTooltip (localize "STR_CODI_OFT_wp2");
_btnActions ctrlCommit 0;
_posY = _posY + _height;



_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlAddEventHandler ["ButtonClick", "CODI_OFT_markerColor = CODI_OFT_groupColor; CODI_OFT_markerType = 'hd_pickup'; CODI_OFT_markerText = str(CODI_OFT_lzCount);"];
_btnActions ctrlCommit 0;
_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlSetText "\A3\ui_f\data\map\markers\handdrawn\pickup_ca.paa";
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlSetTooltip (localize "STR_CODI_OFT_lz");
_btnActions ctrlCommit 0;
_posY = _posY + _height;



_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlAddEventHandler ["ButtonClick", "CODI_OFT_markerColor = CODI_OFT_groupColor; CODI_OFT_markerType = 'hd_destroy'; CODI_OFT_markerText = str(CODI_OFT_tCount);"];
_btnActions ctrlCommit 0;
_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlSetText "\A3\ui_f\data\map\markers\handdrawn\destroy_ca.paa";
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlSetTooltip (localize "STR_CODI_OFT_artyTarget");
_btnActions ctrlCommit 0;
_posY = _posY + _height;



_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlAddEventHandler ["ButtonClick", "CODI_OFT_markerColor = CODI_OFT_groupColor; CODI_OFT_markerType = 'KIA'; CODI_OFT_markerText = str(CODI_OFT_medCount);"];
_btnActions ctrlCommit 0;
_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlSetText "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa";
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlSetTooltip (localize "STR_CODI_OFT_grave");
_btnActions ctrlCommit 0;
_posY = _posY + _height;



_btnActions = _mapDisplay ctrlCreate ["RscButton", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlAddEventHandler ["ButtonClick", "CODI_OFT_markerColor = 'ColorRed'; CODI_OFT_markerType = 'MinefieldAP'; CODI_OFT_markerText = '';"];
_btnActions ctrlCommit 0;
_btnActions = _mapDisplay ctrlCreate ["RscPictureKeepAspect", _id];
_id = _id + 1;
_btnActions ctrlSetPosition [
	_posX * safezoneW + safezoneX,
	_posY * safezoneH + safezoneY,
	_width * safezoneW,
	_height * safezoneH
];
_btnActions ctrlSetText "\a3\Ui_F_Curator\Data\CfgMarkers\minefieldAP_ca.paa";
_btnActions ctrlSetTextColor [1,0,0,1];
_btnActions ctrlShow CODI_OFT_hasOFT;
_btnActions ctrlSetTooltip (localize "STR_CODI_OFT_mine");
_btnActions ctrlCommit 0;
_posY = _posY + _height;