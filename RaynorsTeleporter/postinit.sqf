/*
 * Author: CW2.Raynor.D
 * Adds teleport actions to each object that requested it during object init.
 *
 * Arguments:
 * None
 *
 * Example:
 * Called via postinit only.
 */

{
	_activeObject = _x select 0;
	{
		_dest = _x select 0;
		if(_activeObject != _dest) then {
			_destName = _x select 1;
			_activeObject addAction [_destName, RAY_fnc_tp_run, _dest];
		};
	} foreach RAY_data_tp_list;
} foreach RAY_data_tp_list;
