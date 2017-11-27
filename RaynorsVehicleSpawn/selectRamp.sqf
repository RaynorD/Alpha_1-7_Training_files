RAY_ramp_markers = [];

RAY_traffic_data = [["mark_spawn_10","CW2.Raynor.D","F-16 Fighting Falcon", true, 90]];

{
	_markName = format ["mark_%1", _x select 0];
	//systemChat _markName;
	createMarkerLocal [_markName, getPos (_x select 0)];
	_markName setMarkerShapeLocal "ICON";
	_markName setMarkerTypeLocal "mil_circle";
	_markName setMarkerColorLocal "ColorBlack";
	_markName setMarkerTextLocal (_x select 4);
	
	RAY_ramp_markers pushBack [_markName, _forEachIndex];
} foreach RAY_data_ramps;

RaynorsEHs pushBack (((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {
	_params = (ctrlMapMouseOver (_this select 0));
	
	_params params ["_cursorType", "_markNameEvent"];
	
	//systemChat str _params;
	
	if(count _params > 0 && !isNil '_cursorType' && _cursorType == 'marker') then {
		_ramp = nil;
		{
			_x params ["_markNameArr", "_index"];
			//systemChat str [_x select 0, _markNameEvent];
			if(_markNameArr == _markNameEvent) then {
				_ramp = RAY_data_ramps select _index;
				//_markNameEvent setMarkerTextLocal (_ramp select 1);
				//_markNameEvent setMarkerColorLocal "ColorBlue";
				//systemChat str _ramp;
				//systemChat (_markNameEvent);
				(_this select 0) drawIcon ["iconexplosiveat", (side player) call BIS_fnc_sideColor, getMarkerPos _markNameEvent, 64, 64, 0, (_ramp select 1), 1, 0.09,'RobotoCondensed', 'left'];
			} else {
				//_markNameArr setMarkerColorLocal "ColorBlack";
				//_markNameArr setMarkerTextLocal "";
			};
			
			
		} foreach RAY_ramp_markers;
		
		if(!isNil "_ramp") then {
			//systemChat str [_markName,_ramp];
		} else {
			//systemChat "Not a ramp marker";
		};
	} else {
		//systemChat "Not a marker";
		//{
		//	_x params ["_markNameArr", "_index"];
		//	//_markNameArr setMarkerColorLocal "ColorBlack";
		//	//_markNameArr setMarkerTextLocal "";
		//} foreach RAY_ramp_markers;
	};
	
	{
		_x params ["_mark", "_pilot", "_type", "_fixed", "_angle"];
		
		(_this select 0) drawIcon [if(_fixed) then {"iconplane"} else {"iconhelicopter"}, (side player) call BIS_fnc_sideColor, getMarkerPos _mark, 32, 32, _angle, format ["%1 - %2", _pilot, _type], 1, 0.05, 'RobotoCondensed', 'right'];
	} foreach RAY_traffic_data;
}]);


