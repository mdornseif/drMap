INTERFACE MapVBT;

IMPORT VBT, Pixmap;

TYPE
  TrackProc = PROCEDURE( READONLY cd: VBT.PositionRec );

TYPE
  T <: Public;
  Public =
    VBT.Leaf OBJECT
  METHODS
    init (pm: Pixmap.T := Pixmap.Solid; cp: TrackProc := NIL;): T
  END;
  
END MapVBT.
