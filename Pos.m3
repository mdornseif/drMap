MODULE Pos;

REVEAL T = Public BRANDED 
 OBJECT
  x, y : REAL;
OVERRIDES
  init := Init;
  set := Set;
END;

PROCEDURE Init(self : T): T =
  BEGIN
    RETURN self;
  END Init;

PROCEDURE Set( self: T; x, y : REAL) =
  BEGIN
    self.x := x;
    self.y := y;
  END Set;

PROCEDURE setT( self: T; x, y : TEXT) = 
  BEGIN
    
  END setT;

PROCEDURE getx( self: T ) : REAL =
  BEGIN
    RETURN self.x;
  END getx;

PROCEDURE fmty( self: T ) : REAL =
  BEGIN
    RETURN self.y;
  END fmty;

PROCEDURE fmtT( self: T ) : TEXT =
  BEGIN
    RETURN "kannichnich";
  END fmtT;

PROCEDURE Equal(k1, k2: T): BOOLEAN = 
  BEGIN
    IF (k1.x = k2.x) AND (k1.y = k2.y ) THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END;
  END Equal;


BEGIN
END Pos.
