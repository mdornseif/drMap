INTERFACE TrackVBT;

IMPORT  VBT, TextVBT;

TYPE  
  T <: Public;
  Public = 
    TextVBT.T OBJECT
  METHODS
    init(): T;
    show(READONLY cd: VBT.PositionRec);
  END;

END TrackVBT.
