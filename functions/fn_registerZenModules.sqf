if (!hasInterface || {isNil "zen_custom_modules_fnc_register"}) exitWith {};

[
    "Akhari TFAR Jammer",
    "Add TFAR Jammer",
    {
        params ["_position", "_attachedObject"];

        if (isNull _attachedObject) exitWith {
            ["Add TFAR Jammer must be placed directly onto a unit, vehicle, or object"] call BIS_fnc_error;
        };

        [
            "Add TFAR Jammer",
            [
                [
                    "SLIDER:RADIUS",
                    ["Radius", "Maximum jamming distance in metres"],
                    [50, 10000, 1500, 0, _position, [1, 0.15, 0.15, 0.7]]
                ],
                [
                    "SLIDER",
                    ["Strength", "Interference strength at the jammer; the effect fades toward the radius edge"],
                    [0, 100, 50, 0]
                ]
            ],
            {
                params ["_values", "_arguments"];
                _values params ["_radius", "_strength"];
                _arguments params ["_jammer"];
                ["AKH_Jammer_registerRequest", [_jammer, _radius, _strength]] call CBA_fnc_serverEvent;
            },
            {},
            [_attachedObject]
        ] call zen_dialog_fnc_create;
    },
    "\a3\Modules_F_Curator\Data\iconRadio_ca.paa"
] call zen_custom_modules_fnc_register;

[
    "Akhari TFAR Jammer",
    "Remove TFAR Jammer",
    {
        params ["_position", "_attachedObject"];

        if (isNull _attachedObject) exitWith {
            ["Remove TFAR Jammer must be placed directly onto a registered jammer object"] call BIS_fnc_error;
        };

        ["AKH_Jammer_removeRequest", [_attachedObject]] call CBA_fnc_serverEvent;
    },
    "\a3\Modules_F_Curator\Data\iconRadio_ca.paa"
] call zen_custom_modules_fnc_register;

