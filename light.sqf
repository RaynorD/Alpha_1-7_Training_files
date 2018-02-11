
params [["_object",objNull],["_type",""],["_offset",[0,0,0]],["_flareSize",1]];

if(isNil 'RAY_lights') then {RAY_lights = []};

if(count RAY_lights == 0) then {
	RAY_lights = [[_type, []]];
} else {
	_present = false;
	{
		if(_x select 0 == _type) then {_present = true};
	} foreach RAY_lights;
	
	if(!_present) then {
		RAY_lights pushBack [_type, []];
	};
};

switch(_type) do {
	case "airport1" : {
		_light = "#lightpoint" createVehicleLocal getPos _object; 
		_light setLightBrightness 1; 
		_light setLightAmbient [0.01,0,0]; 
		_light setLightColor [0.01,0,0];  
		_light lightAttachObject [_object, [0,0,0.35]];
		_light setLightUseFlare true;
		_light setLightFlareSize _flareSize;
		_light setLightFlareMaxDistance 100000;
	};
};

if(count RAY_lights == 0) then {RAY_lights pushBack [_type, []]};