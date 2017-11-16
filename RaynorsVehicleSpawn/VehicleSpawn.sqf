_args = _this select 3;

_spawnObject = _args select 0;
_vehType = _args select 1;
_valid = _args select 2;

if(_valid) then {
	{
		deleteVehicle _x;
	} foreach nearestObjects [getPos _spawnObject, ["LandVehicle", "Air", "Wreck_Base", "CraterLong"], 10];

	if(_vehType != "Clear") then {
		sleep 0.1;
		
		_veh = _vehType createVehicle getPos _spawnObject;
		_veh setPosATL [getPos _veh select 0, getPos _veh select 1, 0.2];
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


