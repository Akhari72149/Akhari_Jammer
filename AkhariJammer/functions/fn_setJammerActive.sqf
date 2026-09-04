params [
    ["_jammer", objNull, [objNull]],
    ["_active", true, [true]]
];

if (!isServer) exitWith {
    [_jammer, _active] remoteExecCall ["AKH_Jammer_fnc_setJammerActive", 2];
};

if (isNull _jammer) exitWith {};

private _registry = +(
    missionNamespace getVariable ["AKH_Jammer_registry", []]
);
private _index = _registry findIf { (_x select 0) isEqualTo _jammer };

if (_index < 0) exitWith {
    diag_log format ["[AKH Jammer] State change rejected: %1 is not registered", _jammer];
};

private _entry = +(_registry select _index);
_entry set [4, _active];
_registry set [_index, _entry];

_jammer setVariable ["AKH_Jammer_active", _active, true];
missionNamespace setVariable ["AKH_Jammer_registry", _registry, true];
[_registry] remoteExecCall ["AKH_Jammer_fnc_receiveSync", -2];

diag_log format ["[AKH Jammer] %1 active state set to %2", _jammer, _active];

