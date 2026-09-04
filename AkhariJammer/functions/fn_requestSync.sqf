if (!isServer) exitWith {};

private _owner = remoteExecutedOwner;
private _registry = missionNamespace getVariable ["AKH_Jammer_registry", []];

[_registry] remoteExecCall ["AKH_Jammer_fnc_receiveSync", _owner];

