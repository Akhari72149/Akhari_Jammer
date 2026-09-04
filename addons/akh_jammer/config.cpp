class CfgPatches {
    class AKH_Jammer {
        name = "Akhari TFAR Jammer";
        author = "Akhari";
        requiredVersion = 2.10;
        requiredAddons[] = {"A3_Modules_F", "cba_main", "tfar_core"};
        units[] = {"AKH_Jammer_ModuleAdd", "AKH_Jammer_ModuleRemove"};
        weapons[] = {};
        version = "1.0.0";
    };
};

class CfgFactionClasses {
    class NO_CATEGORY;
    class AKH_Jammer_Modules: NO_CATEGORY {
        displayName = "Akhari TFAR Jammer";
    };
};

class CfgFunctions {
    class AKH_Jammer {
        tag = "AKH_Jammer";
        class Core {
            file = "\z\akhari\addons\akh_jammer\functions";
            class clientUpdate {};
            class moduleAdd {};
            class moduleRemove {};
            class postInit { postInit = 1; };
            class publishRegistry {};
            class receiveRegistry {};
            class registerJammer {};
            class removeJammer {};
        };
    };
};

class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Edit;
            class ModuleDescription;
        };
        class ModuleDescription;
    };

    class AKH_Jammer_ModuleAdd: Module_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Add TFAR Jammer";
        category = "AKH_Jammer_Modules";
        icon = "\a3\Modules_F_Curator\Data\iconRadio_ca.paa";
        function = "AKH_Jammer_fnc_moduleAdd";
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 0;
        isDisposable = 0;
        curatorCanAttach = 1;

        class Attributes: AttributesBase {
            class Radius: Edit {
                property = "AKH_Jammer_Radius";
                displayName = "Radius (metres)";
                tooltip = "Maximum jamming radius in metres.";
                typeName = "NUMBER";
                defaultValue = "1500";
            };
            class Strength: Edit {
                property = "AKH_Jammer_Strength";
                displayName = "Strength";
                tooltip = "Interference strength at the jammer. Must be zero or greater.";
                typeName = "NUMBER";
                defaultValue = "50";
            };
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = "Synchronize to objects that should emit TFAR interference until destroyed or removed.";
            sync[] = {"Anything"};
            class Anything {
                description[] = {"Synchronized objects become active TFAR jammers."};
                displayName = "Jammer object";
                icon = "iconObject";
                position = 1;
                direction = 1;
                optional = 0;
                duplicate = 1;
                synced[] = {"AnyPerson", "AnyVehicle", "AnyStaticObject"};
            };
        };
    };

    class AKH_Jammer_ModuleRemove: Module_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Remove TFAR Jammer";
        category = "AKH_Jammer_Modules";
        icon = "\a3\Modules_F_Curator\Data\iconRadio_ca.paa";
        function = "AKH_Jammer_fnc_moduleRemove";
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 0;
        isDisposable = 0;
        curatorCanAttach = 1;

        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = "Synchronize to registered jammer objects to remove their interference.";
            sync[] = {"Anything"};
            class Anything {
                description[] = {"Synchronized registered jammers are removed."};
                displayName = "Jammer object";
                icon = "iconObject";
                position = 1;
                direction = 1;
                optional = 0;
                duplicate = 1;
                synced[] = {"AnyPerson", "AnyVehicle", "AnyStaticObject"};
            };
        };
    };
};

