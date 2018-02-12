_args = _this select 3;

_args params ["_spawnObject", "_vehType", "_valid"];


if(_valid) then {
	{
		deleteVehicle _x;
	} foreach nearestObjects [getPosATL _spawnObject, ["LandVehicle", "Air", "Wreck_Base", "CraterLong"], 10, true];

	if(_vehType != "Clear") then {
		sleep 0.1;
		
		_veh = createVehicle [_vehType,[getPosATL _spawnObject select 0, getPosATL _spawnObject select 1, ((getPosATL _spawnObject) select 2) + 0.2],[],0,"CAN_COLLIDE"];
		_veh setDir (getDir _spawnObject);

		if (_veh isKindOf "Helicopter") then
		{
			[_veh] call ace_fastroping_fnc_equipFRIES;
		};
		
		[_veh] execVM "RaynorsVehicleSpawn\addEditable.sqf";
	};
} else {
	hint "That vehicle class is invalid!";
};


