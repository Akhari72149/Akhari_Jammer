params [["_jammer", objNull, [objNull]]];
if (!isServer || {isNull _jammer}) exitWith {false};

private _registry = +(missionNamespace getVariable ["AKH_Jammer_registry", []]);
private _index = _registry findIf { (_x select 0) isEqualTo _jammer };
if (_index < 0) exitWith {false};
_registry deleteAt _index;
missionNamespace setVariable ["AKH_Jammer_registry", _registry];

private _id = _jammer getVariable ["AKH_Jammer_killedEH", -1];
if (_id >= 0) then {
    _jammer removeEventHandler ["Killed", _id];
    _jammer setVariable ["AKH_Jammer_killedEH", nil];
};

call AKH_Jammer_fnc_publishRegistry;
diag_log format ["[AKH Jammer] Removed %1", _jammer];
true

