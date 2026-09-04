if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["AKH_Jammer_clientInitialized", false]) exitWith {};

missionNamespace setVariable ["AKH_Jammer_clientInitialized", true];
missionNamespace setVariable ["AKH_Jammer_appliedReceiveFactor", 1];
missionNamespace setVariable ["AKH_Jammer_appliedSendFactor", 1];
missionNamespace setVariable ["AKH_Jammer_lastUnit", objNull];

[] spawn {
    waitUntil {
        sleep 0.25;
        !isNil "TFAR_currentUnit" && {!isNull TFAR_currentUnit}
    };

    [] spawn AKH_Jammer_fnc_clientUpdate;
    remoteExecCall ["AKH_Jammer_fnc_requestSync", 2];
};

