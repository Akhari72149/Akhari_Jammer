if (isServer) then {
    missionNamespace setVariable ["AKH_Jammer_registry", []];
    ["AKH_Jammer_requestRegistry", { call AKH_Jammer_fnc_publishRegistry }] call CBA_fnc_addEventHandler;
    ["AKH_Jammer_registerRequest", {
        _this call AKH_Jammer_fnc_registerJammer;
    }] call CBA_fnc_addEventHandler;
    ["AKH_Jammer_removeRequest", {
        _this call AKH_Jammer_fnc_removeJammer;
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    missionNamespace setVariable ["AKH_Jammer_registry", []];
    missionNamespace setVariable ["AKH_Jammer_appliedReceiveFactor", 1];
    missionNamespace setVariable ["AKH_Jammer_appliedSendFactor", 1];
    missionNamespace setVariable ["AKH_Jammer_lastUnit", objNull];

    ["AKH_Jammer_registryChanged", { _this call AKH_Jammer_fnc_receiveRegistry }] call CBA_fnc_addEventHandler;

    [] spawn {
        waitUntil { sleep 0.25; !isNull player && {!isNil "TFAR_currentUnit"} };
        ["AKH_Jammer_requestRegistry", []] call CBA_fnc_serverEvent;
        [] spawn AKH_Jammer_fnc_clientUpdate;
    };

    if (isClass (configFile >> "CfgPatches" >> "zen_custom_modules")) then {
        [{call AKH_Jammer_fnc_registerZenModules}] call CBA_fnc_execNextFrame;
    };
};
