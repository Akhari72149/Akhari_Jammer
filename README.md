# Akhari TFAR Jammer

A self-contained Arma 3 addon that adds TFAR jammer modules to Eden and Zeus.
Missions do not need a `description.ext`, init scripts, or RemoteExec entries.

## Requirements

- Arma 3
- CBA_A3
- Task Force Arrowhead Radio (TFAR)

## Modules

Both modules are under **Systems > Modules > Akhari TFAR Jammer**.

### Add TFAR Jammer

Place the module, synchronize it to one or more units, vehicles, or objects, and
set radius and strength in its attributes. Each synchronized object emits until
it is killed/deleted or removed. Radius is in metres. Strength `50` produces a
receiving multiplier of `51` at the emitter and approaches `1` at the edge.

### Remove TFAR Jammer

Place this module and synchronize it to registered jammer objects. It removes
them without resetting unrelated TFAR modifiers or other active jammers.

## Multiplayer behavior

- Modules execute on the server.
- CBA events distribute the registry and provide explicit JIP synchronization.
- Each client modifies only `TFAR_currentUnit`.
- Respawn and Zeus remote control are handled automatically.
- Overlaps use the strongest jammer effect.
- Existing TFAR range modifiers are preserved multiplicatively.
