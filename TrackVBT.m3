MODULE TrackVBT;

IMPORT TextVBT, Fmt, VBT;

REVEAL
  T = Public BRANDED OBJECT
    x         : INTEGER;
  OVERRIDES
    init      := Init;
    show      := Show;
  END;

PROCEDURE Init(v: T) : T =
  BEGIN
    EVAL TextVBT.T.init(v, "(no data)");
    RETURN v;
  END Init;

PROCEDURE Show(v: T; READONLY cd: VBT.PositionRec) =
  BEGIN
    IF NOT cd.cp.gone THEN
      TextVBT.Put(v,
                  Fmt.F("Cursor(h, v) = (%s, %s)",
                        Fmt.Real(TranslateX(cd.cp.pt.h)), 
                        Fmt.Int(cd.cp.pt.v)));
      
    END; 
  END Show;

PROCEDURE TranslateX ( x : INTEGER) : REAL =
  BEGIN
    RETURN (FLOAT(x) / 1000.0 )+ 50.0;
  END TranslateX;

BEGIN
END TrackVBT.
