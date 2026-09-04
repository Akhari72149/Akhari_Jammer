params [
    ["_jammer", objNull, [objNull]],
    ["_radius", 1500, [0]],
    ["_strength", 50, [0]],
    ["_antenna", objNull, [objNull]],
    ["_active", true, [true]]
];

if (!isServer) exitWith {
    diag_log "[AKH Jammer] Registration rejected: register jammers on the server";
};

if (isNull _jammer) exitWith {
    diag_log "[AKH Jammer] Registration rejected: jammer is objNull";
};

if (_radius <= 0) exitWith {
    diag_log format ["[AKH Jammer] Registration rejected for %1: radius must be greater than zero", _jammer];
};

if (_strength < 0) exitWith {
    diag_log format ["[AKH Jammer] Registration rejected for %1: strength cannot be negative", _jammer];
};

if (isNull _antenna) then {
    _antenna = _jammer;
};

private _registry = +(
    missionNamespace getVariable ["AKH_Jammer_registry", []]
);
private _index = _registry findIf { (_x select 0) isEqualTo _jammer };
private _entry = [_jammer, _radius, _strength, _antenna, _active];

if (_index < 0) then {
    _registry pushBack _entry;
} else {
    _registry set [_index, _entry];
};

_jammer setVariable ["AKH_Jammer_active", _active, true];
missionNamespace setVariable ["AKH_Jammer_registry", _registry, true];
[_registry] remoteExecCall ["AKH_Jammer_fnc_receiveSync", -2];

diag_log format [
    "[AKH Jammer] Registered %1 (radius %2, strength %3, antenna %4, active %5)",
    _jammer,
    _radius,
    _strength,
    _antenna,
    _active
];
