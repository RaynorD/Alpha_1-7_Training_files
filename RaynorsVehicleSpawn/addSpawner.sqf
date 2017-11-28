
params [["_object",objNull,[objNull]],["_spawnObj",objNull,[objNull]],["_vehicles","",[""]]];

call compile preprocessFileLineNumbers "RaynorsVehicleSpawn\!spawnerList.sqf";

if(isNil '_vehicles') exitWith {systemChat "_vehicles was empty"};

_vehiclesArr = missionNamespace getVariable _vehicles;

if(isNil '_vehiclesArr') exitWith {systemChat "_vehicles value was not found in spawnerList"};

_object allowDamage false;
_object enableSimulation false;

{
	_name = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_side = getNumber (configFile >> "CfgVehicles" >> _x >> "side");
	
	_color = "#ffffff";
	switch(_side) do {
		case 0: {_color = "#ff6666";}; //east
		case 1: {_color = "#6bb5ff";}; //west
		case 2: {_color = "#77ff77";}; //ind
		case 3: {_color = "#e789ff";}; //civ
	};
	
	if(_name == "") then {
		_object addAction [format["<t color='#777777'>%1</t>", _x], "RaynorsVehicleSpawn\VehicleSpawn.sqf", [_spawnObj, _x, false]]; 
	} else {
		_object addAction [format["<t color='%1'>%2</t>", _color, _name], "RaynorsVehicleSpawn\VehicleSpawn.sqf", [_spawnObj, _x, true]]; 
	};
} foreach _vehiclesArr;

_object addAction [format["<t color='#ffff55'>%1</t>", "Clear Spawn Area"], "RaynorsVehicleSpawn\VehicleSpawn.sqf", [_spawnObj, "Clear", true]]; 

