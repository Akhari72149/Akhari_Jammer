params [["_logic", objNull, [objNull]], ["_units", [], [[]]], ["_activated", true, [true]]];
if (!isServer || {!_activated} || {isNull _logic}) exitWith {true};

private _radius = _logic getVariable ["Radius", 1500];
private _strength = _logic getVariable ["Strength", 50];
if (_radius <= 0 || {_strength < 0}) exitWith {
    diag_log format ["[AKH Jammer] Invalid radius %1 or strength %2", _radius, _strength];
    true
};

private _targets = (_units + synchronizedObjects _logic) arrayIntersect (_units + synchronizedObjects _logic);
_targets = _targets select { !(_x isKindOf "Logic") };
{ [_x, _radius, _strength] call AKH_Jammer_fnc_registerJammer } forEach _targets;
if (_targets isEqualTo []) then { diag_log "[AKH Jammer] Add module has no synchronized objects" };
true

