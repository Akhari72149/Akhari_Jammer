params [["_jammer", objNull, [objNull]], ["_radius", 1500, [0]], ["_strength", 50, [0]]];
if (!isServer || {isNull _jammer} || {_radius <= 0} || {_strength < 0}) exitWith {false};

private _registry = +(missionNamespace getVariable ["AKH_Jammer_registry", []]);
private _index = _registry findIf { (_x select 0) isEqualTo _jammer };
private _entry = [_jammer, _radius, _strength];
if (_index < 0) then {_registry pushBack _entry} else {_registry set [_index, _entry]};
missionNamespace setVariable ["AKH_Jammer_registry", _registry];

if (isNil {_jammer getVariable "AKH_Jammer_killedEH"}) then {
    private _id = _jammer addEventHandler ["Killed", { params ["_unit"]; [_unit] call AKH_Jammer_fnc_removeJammer }];
    _jammer setVariable ["AKH_Jammer_killedEH", _id];
};

call AKH_Jammer_fnc_publishRegistry;
diag_log format ["[AKH Jammer] Registered %1, radius %2, strength %3", _jammer, _radius, _strength];
true

