params [["_logic", objNull, [objNull]], ["_units", [], [[]]], ["_activated", true, [true]]];
if (!isServer || {!_activated} || {isNull _logic}) exitWith {true};

private _targets = (_units + synchronizedObjects _logic) arrayIntersect (_units + synchronizedObjects _logic);
_targets = _targets select { !(_x isKindOf "Logic") };
{ [_x] call AKH_Jammer_fnc_removeJammer } forEach _targets;
if (_targets isEqualTo []) then { diag_log "[AKH Jammer] Remove module has no synchronized objects" };
true

