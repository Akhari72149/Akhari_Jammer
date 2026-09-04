if (!isServer) exitWith {};
if (missionNamespace getVariable ["AKH_Jammer_serverInitialized", false]) exitWith {};

missionNamespace setVariable ["AKH_Jammer_serverInitialized", true];
missionNamespace setVariable ["AKH_Jammer_registry", [], true];

diag_log "[AKH Jammer] Server registry initialized";

