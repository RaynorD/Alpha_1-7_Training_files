//[_this,'full'] call cScripts_fnc_doStarterCrate;

if(!isServer) exitWith {};

_crate = _this;

ClearItemCargoGlobal _crate;
ClearWeaponCargoGlobal _crate;
ClearMagazineCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

[_crate, true, true] call ace_arsenal_fnc_initBox;
["AmmoboxInit",[_crate,true]] spawn BIS_fnc_arsenal;


if(isClass (configFile >> "CfgPatches" >> "acre_main")) then {
	_crate addItemCargoGlobal ["ACRE_PRC343",30];
	_crate addItemCargoGlobal ["ACRE_PRC148",30];
	_crate addItemCargoGlobal ["ACRE_PRC152",30];
	_crate addItemCargoGlobal ["ACRE_PRC77",10];
	_crate addItemCargoGlobal ["ACRE_PRC117F",10];
};

if(isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	_crate addItemCargoGlobal ["tf_anprc148jem",30];
	_crate addItemCargoGlobal ["tf_anprc152",30];
	_crate addBackpackCargoGlobal ["tf_rt1523g",10];
	_crate addBackpackCargoGlobal ["tf_rt1523g_big",10];
};
