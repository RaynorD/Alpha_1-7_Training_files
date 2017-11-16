
_callerObj = _this select 0;

_vector = vectorNormalized ((getPos _callerObj) vectorFromTo (getPos player));

_dest = _this select 3;
_destPos = getPos _dest;

_randDir = random 359;
_pos = [(_destPos select 0) - 4 * (_vector select 0),(_destPos select 1) - 4 * (_vector select 1)];

player SetPos _pos;

player setDir (getDir player + 180);