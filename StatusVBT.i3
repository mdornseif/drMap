INTERFACE StatusVBT;

IMPORT VBT;

PROCEDURE init( t : TEXT := "" ) : VBT.T;
PROCEDURE get() : VBT.T;
PROCEDURE update( t: TEXT );

END StatusVBT.
