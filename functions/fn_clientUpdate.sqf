if (!hasInterface) exitWith {};

while {true} do {
    private _unit = missionNamespace getVariable ["TFAR_currentUnit", objNull];
    private _lastUnit = missionNamespace getVariable ["AKH_Jammer_lastUnit", objNull];
    private _oldReceive = missionNamespace getVariable ["AKH_Jammer_appliedReceiveFactor", 1];
    private _oldSend = missionNamespace getVariable ["AKH_Jammer_appliedSendFactor", 1];

    if (!isNull _lastUnit && {!(_lastUnit isEqualTo _unit)}) then {
        _lastUnit setVariable ["tf_receivingDistanceMultiplicator", (_lastUnit getVariable ["tf_receivingDistanceMultiplicator", 1]) / (_oldReceive max 0.0001)];
        _lastUnit setVariable ["tf_sendingDistanceMultiplicator", (_lastUnit getVariable ["tf_sendingDistanceMultiplicator", 1]) / (_oldSend max 0.0001)];
        _oldReceive = 1;
        _oldSend = 1;
    };

    if (!isNull _unit) then {
        private _newReceive = 1;
        private _newSend = 1;
        {
            _x params ["_jammer", "_radius", "_strength"];
            if (!isNull _jammer && {alive _jammer} && {_radius > 0}) then {
                private _distance = _unit distance _jammer;
                if (_distance <= _radius) then {
                    private _receive = 1 + (_strength * (1 - (_distance / _radius)));
                    _newReceive = _newReceive max _receive;
                    _newSend = _newSend min (1 / (_receive max 0.0001));
                };
            };
        } forEach (missionNamespace getVariable ["AKH_Jammer_registry", []]);

        private _baseReceive = (_unit getVariable ["tf_receivingDistanceMultiplicator", 1]) / (_oldReceive max 0.0001);
        private _baseSend = (_unit getVariable ["tf_sendingDistanceMultiplicator", 1]) / (_oldSend max 0.0001);
        _unit setVariable ["tf_receivingDistanceMultiplicator", _baseReceive * _newReceive];
        _unit setVariable ["tf_sendingDistanceMultiplicator", _baseSend * _newSend];
        missionNamespace setVariable ["AKH_Jammer_appliedReceiveFactor", _newReceive];
        missionNamespace setVariable ["AKH_Jammer_appliedSendFactor", _newSend];
        missionNamespace setVariable ["AKH_Jammer_lastUnit", _unit];
    };
    sleep 1;
};

