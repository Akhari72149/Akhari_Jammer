params [["_registry", [], [[]]]];

if (!hasInterface) exitWith {};

missionNamespace setVariable ["AKH_Jammer_registry", _registry];
[_registry] call AKH_Jammer_fnc_addActions;

