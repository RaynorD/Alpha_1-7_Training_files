
params [["_object",objNull,[objNull]],["_spawnObj",objNull,[objNull]],["_vehicles","",["",[]]]];

//if(_object != sign1) exitWith {};

call compile preprocessFileLineNumbers "RaynorsVehicleSpawn\!spawnerList.sqf";

if(isNil '_vehicles') exitWith {systemChat "_vehicles was nil"};

_vehiclesArr = [[],[],[],[]];
_vehiclesArrSorted = [];

if(typeName _vehicles == "STRING") then {
	_vehiclesArrInput = missionNamespace getVariable _vehicles;
	if(isNil '_vehiclesArrInput') exitWith {diag_log format ["Raynor Vehicle Spawner: _vehicles value was not found in spawnerList: %1", _vehicles]};
	
	diag_log format ["Raynor's Vehicle Spawn List: %1", _vehicles];
	
	{
		_config = (configFile >> "CfgVehicles" >> _x);
		_side = (getNumber (_config >> "side"));
		
		(_vehiclesArr select _side) pushback [getText (_config >> "displayName"), _x];
	} foreach _vehiclesArrInput;

} else { //typeName _vehicles == "ARRAY"
	_filter = [ // [string - startswith filter, bool - include root]
		["FIR_F16C", true],
		["FIR_F16D", true],
		["FIR_F15C", true],
		["FIR_F15D", true],
		["FIR_F15E", true],
		["FIR_F15J", false],
		["FIR_F15K", false],
		["RHS_T50", true],
		["RHS_TU95", false]
	];
	
	
	// [0 - east], [1 - west], [2 - resist], [3 - civilian];
	{
		_config = _x;
		_className = configName _config;
		//diag_log format ["_className: %1",_className];
		_ignore = false;
		{
			_x params ["_filterStr","_includeRoot"];
			//diag_log format ["_filterStr: %1",_filterStr];
			if((_className find _filterStr) == 0) then {
				if(_includeRoot) then {
					if(_className != _filterStr) then {
						_ignore = true;
					};
				} else {
					_ignore = true;
				};
			};
		} foreach _filter;
		if(!_ignore) then {
			_push = true;
			_side = (getNumber (_x >> "side"));
			{
				_x params ["_displayName", "_testConfig"];
				if(getText (_config >> "displayName") == getText (_testConfig >> "displayName")) then {
					_push = false;
				};
			} foreach (_vehiclesArr select _side);
			
			if(_push) then {
				(_vehiclesArr select _side) pushback [getText (_x >> "displayName"), _x];
			};
		};
	} foreach (format ["(getNumber (_x >> 'side') in [0,1,2,3]) &&(getNumber (_x >> 'scope') >= 2) && (configName _x isKindOf '%1')", _vehicles select 0] configClasses (configFile >> "CfgVehicles"));

	diag_log format ["Raynor's Vehicle Spawn List: Generated - Filter: %1 - List: %2", _vehicles, _vehiclesArr];
};

_east = _vehiclesArr select 0;
_vehiclesArr set [0, _vehiclesArr select 1];
_vehiclesArr set [1, _east];

{
	_arr = _x sort true;
	_vehiclesArrSorted = _vehiclesArrSorted + _x;
} foreach _vehiclesArr;

_object allowDamage false;
_object enableSimulation false;

{
	_x params ["_displayName", "_veh"];
	
	_config = if(typeName _veh == "STRING") then {(configFile >> "CfgVehicles" >> _veh)} else {_veh};
	_name = getText (_config >> "displayName");
	_side = getNumber (_config >> "side");
	
	_color = "#ffffff";
	switch(_side) do {
		case 0: {_color = "#ff6666";}; //east
		case 1: {_color = "#6bb5ff";}; //west
		case 2: {_color = "#77ff77";}; //ind
		case 3: {_color = "#e789ff";}; //civ
	};
	
	if(_name == "") then {
		_object addAction [format["<t color='#777777'>%1</t>", _config], "RaynorsVehicleSpawn\VehicleSpawn.sqf", [_spawnObj, configName _config, false],10,false,false]; 
	} else {
		_object addAction [format["<t color='%1'>%2</t>", _color, _name], "RaynorsVehicleSpawn\VehicleSpawn.sqf", [_spawnObj, configName _config, true],10,false,false]; 
	};
} foreach _vehiclesArrSorted;

_object addAction [format["<t color='#ffff55'>%1</t>", "Clear Spawn Area"], "RaynorsVehicleSpawn\VehicleSpawn.sqf", [_spawnObj, "Clear", true],10,false,false]; 


