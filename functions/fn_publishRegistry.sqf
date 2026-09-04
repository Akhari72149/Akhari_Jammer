if (!isServer) exitWith {};
private _registry = +(missionNamespace getVariable ["AKH_Jammer_registry", []]);
_registry = _registry select { private _jammer = _x select 0; !isNull _jammer && {alive _jammer} };
missionNamespace setVariable ["AKH_Jammer_registry", _registry];
["AKH_Jammer_registryChanged", [_registry]] call CBA_fnc_globalEvent;

