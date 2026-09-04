params [["_registry", [], [[]]]];

if (!hasInterface) exitWith {};

private _registeredObjects = _registry apply { _x select 0 };
private _knownObjects = missionNamespace getVariable ["AKH_Jammer_actionObjects", []];

{
    private _object = _x;
    if (!isNull _object && {!(_object in _registeredObjects)}) then {
        private _ids = _object getVariable ["AKH_Jammer_actionIds", []];
        { _object removeAction _x } forEach _ids;
        _object setVariable ["AKH_Jammer_actionIds", nil];
    };
} forEach _knownObjects;

{
    private _jammer = _x select 0;
    if (!isNull _jammer && {isNil {_jammer getVariable "AKH_Jammer_actionIds"}}) then {
        private _disableId = _jammer addAction [
            "<t color='#ff6666'>Disable jammer</t>",
            {
                params ["_target"];
                [_target, false] call AKH_Jammer_fnc_setJammerActive;
            },
            nil,
            1.5,
            true,
            true,
            "",
            "_target getVariable ['AKH_Jammer_active', false]",
            15,
            false
        ];

        private _enableId = _jammer addAction [
            "<t color='#66ff66'>Enable jammer</t>",
            {
                params ["_target"];
                [_target, true] call AKH_Jammer_fnc_setJammerActive;
            },
            nil,
            1.5,
            true,
            true,
            "",
            "!(_target getVariable ['AKH_Jammer_active', false])",
            15,
            false
        ];

        _jammer setVariable ["AKH_Jammer_actionIds", [_disableId, _enableId]];
    };
} forEach _registry;

missionNamespace setVariable ["AKH_Jammer_actionObjects", _registeredObjects];

