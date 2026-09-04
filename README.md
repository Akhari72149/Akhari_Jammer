# Akhari TFAR Jammer

A multiplayer-safe mission script for Task Force Arrowhead Radio (TFAR).

The server owns the jammer registry and active state. Each player client runs one
local updater that applies the strongest active jammer effect to the unit TFAR is
currently using. This supports dedicated servers, JIP, respawn, Zeus remote
control, overlapping jammers, and runtime enable/disable actions.

## Requirements

- Arma 3
- CBA_A3 (required by TFAR)
- Task Force Arrowhead Radio

Tested against the TFAR build whose PBO metadata reports `1.-1.0.341`
(`d76d8b32`). The current TFAR variables used are:

- `tf_receivingDistanceMultiplicator`
- `tf_sendingDistanceMultiplicator`

## Install in a mission

1. Copy the `AkhariJammer` directory into the mission root.
2. Merge the contents of `description.ext.example` into the mission's
   `description.ext`. Do not replace an existing `CfgFunctions` or
   `CfgRemoteExec`; merge their child classes.
3. Merge `initServer.sqf.example` into the mission's `initServer.sqf`.
4. Merge `initPlayerLocal.sqf.example` into the mission's
   `initPlayerLocal.sqf`.

If your `CfgRemoteExec` uses `mode = 1`, retain the function entries supplied in
the example. `mode = 2` will block the functions unless you explicitly allow
them.

## Register a jammer

Place this in `initServer.sqf` after the server initialization call. Registration
is deliberately server-only so clients cannot inject jammer definitions:

```sqf
[jammer1, 1500, 50, antenna1, true] call AKH_Jammer_fnc_registerJammer;
```

Parameters:

1. Jammer/controller object.
2. Radius in metres (not diameter).
3. Strength. `50` gives a receiving multiplier of `51` at the centre and a
   sending multiplier of `1/51`.
4. Optional antenna object. Use `objNull` to emit from the jammer object.
5. Whether the jammer starts active.

The jammer and antenna must be editor/server-created network objects. Local-only
objects cannot be distributed reliably to other clients.

## Runtime control

These calls are safe from a server or client:

```sqf
[jammer1, true] call AKH_Jammer_fnc_setJammerActive;
[jammer1, false] call AKH_Jammer_fnc_setJammerActive;
```

Every registered jammer also receives local Enable and Disable actions. The
actions request the state change from the server.

## Combining jammers

When areas overlap, the strongest calculated interference is used. One jammer
can therefore no longer reset or weaken another jammer's effect. Existing TFAR
range multipliers from other mission systems are preserved multiplicatively.

## Diagnostics

Set this before client initialization to enable local RPT messages:

```sqf
missionNamespace setVariable ["AKH_Jammer_debug", true];
```
