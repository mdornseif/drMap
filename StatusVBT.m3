MODULE StatusVBT;

IMPORT VBT, TextVBT;

VAR
  vbt := NEW(TextVBT.T).init( "(no data)" );
  
PROCEDURE init( t : TEXT := "" ) : VBT.T = 
  BEGIN
    TextVBT.Put( vbt, t );
    RETURN vbt;
  END init;

PROCEDURE get( ) : VBT.T =
  BEGIN
    RETURN vbt;
  END get;

PROCEDURE update( t : TEXT ) =
  BEGIN
    TextVBT.Put( vbt, t );
  END update;

BEGIN
END StatusVBT.
