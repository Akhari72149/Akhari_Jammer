if (!hasInterface) exitWith {};

while {true} do {
    private _unit = missionNamespace getVariable ["TFAR_currentUnit", objNull];
    private _lastUnit = missionNamespace getVariable ["AKH_Jammer_lastUnit", objNull];
    private _oldReceiveFactor = missionNamespace getVariable ["AKH_Jammer_appliedReceiveFactor", 1];
    private _oldSendFactor = missionNamespace getVariable ["AKH_Jammer_appliedSendFactor", 1];

    if (!isNull _lastUnit && {!(_lastUnit isEqualTo _unit)}) then {
        private _lastReceive = _lastUnit getVariable ["tf_receivingDistanceMultiplicator", 1];
        private _lastSend = _lastUnit getVariable ["tf_sendingDistanceMultiplicator", 1];
        _lastUnit setVariable ["tf_receivingDistanceMultiplicator", _lastReceive / (_oldReceiveFactor max 0.0001)];
        _lastUnit setVariable ["tf_sendingDistanceMultiplicator", _lastSend / (_oldSendFactor max 0.0001)];
        _oldReceiveFactor = 1;
        _oldSendFactor = 1;
    };

    if (!isNull _unit) then {
        private _newReceiveFactor = 1;
        private _newSendFactor = 1;
        private _registry = missionNamespace getVariable ["AKH_Jammer_registry", []];

        {
            _x params ["_jammer", "_radius", "_strength", "_antenna", "_active"];

            if (
                _active
                && {_jammer getVariable ["AKH_Jammer_active", false]}
                && {!isNull _jammer}
                && {!isNull _antenna}
                && {alive _jammer}
                && {alive _antenna}
                && {_radius > 0}
            ) then {
                private _distance = _unit distance _antenna;
                if (_distance <= _radius) then {
                    private _receiveFactor = 1 + (_strength * (1 - (_distance / _radius)));
                    private _sendFactor = 1 / (_receiveFactor max 0.0001);

                    _newReceiveFactor = _newReceiveFactor max _receiveFactor;
                    _newSendFactor = _newSendFactor min _sendFactor;
                };
            };
        } forEach _registry;

        private _currentReceive = _unit getVariable ["tf_receivingDistanceMultiplicator", 1];
        private _currentSend = _unit getVariable ["tf_sendingDistanceMultiplicator", 1];
        private _baseReceive = _currentReceive / (_oldReceiveFactor max 0.0001);
        private _baseSend = _currentSend / (_oldSendFactor max 0.0001);

        _unit setVariable ["tf_receivingDistanceMultiplicator", _baseReceive * _newReceiveFactor];
        _unit setVariable ["tf_sendingDistanceMultiplicator", _baseSend * _newSendFactor];

        missionNamespace setVariable ["AKH_Jammer_appliedReceiveFactor", _newReceiveFactor];
        missionNamespace setVariable ["AKH_Jammer_appliedSendFactor", _newSendFactor];
        missionNamespace setVariable ["AKH_Jammer_lastUnit", _unit];

        if (missionNamespace getVariable ["AKH_Jammer_debug", false]) then {
            diag_log format [
                "[AKH Jammer] Unit %1 receive factor %2, send factor %3",
                _unit,
                _newReceiveFactor,
                _newSendFactor
            ];
        };
    };

    sleep 1;
};

