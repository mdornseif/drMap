MODULE Test EXPORTS Main;

IMPORT TextVBT, Trestle, BorderedVBT, HVSplit, Axis, HVBar;
IMPORT Pixmap, PixmapVBT, VBT;
IMPORT FileRd;
IMPORT Text, Image, PaintOp, Rd;
IMPORT Rect;
IMPORT MapVBT, TrackVBT, StatusVBT, Pos, PosList, TextList;


PROCEDURE GetPixmap (rd: Rd.T): VBT.T =
  VAR
    image: Image.Raw;
    op   : PaintOp.T;
  BEGIN
    TRY
      image := Image.FromRd(rd)
    EXCEPT
      Rd.Failure, Image.Error => RETURN NIL
    END;
    TYPECASE image OF
    | Image.RawBitmap => op :=   PaintOp.BgFg ;
    | Image.RawPixmap => op := PaintOp.Copy;
    ELSE                         <* ASSERT FALSE *>
    END;
    pm := Image.Unscaled(image);
    RETURN NEW(PixmapVBT.T).init(pm := Image.Unscaled(image), op := PaintOp.Copy)
  END GetPixmap;
  
PROCEDURE CursorTrack(READONLY cd: VBT.PositionRec) =
  BEGIN
   location.show(cd);
  END CursorTrack;

  
PROCEDURE Get (file: Text.T): VBT.T =
  VAR rd: FileRd.T;
  BEGIN
    TRY
      rd := FileRd.Open(file);
      TRY RETURN GetPixmap(rd) FINALLY Rd.Close(rd) END
    EXCEPT
      Rd.Failure =>              (* Do nothing about it. *)
    END;
    RETURN NIL
  END Get;


VAR
  vbt, header, workspace, footer, map, menu : VBT.T;
  location := NEW(TrackVBT.T).init();
  scrt : VBT.ScreenType;
  red  :=      PaintOp.FromRGB (255.0/255.0,    0.0/255.0,   0.0/255.0);
  mapRec: Rect.T;
  pm: Pixmap.T;
  pmVBT : PixmapVBT.T;
  track : MapVBT.TrackProc;
  pos1 := NEW(Pos.T);
  pos2 := NEW(Pos.T);
  list: TextList.T := NIL;
  plist: PosList.T := NIL;

BEGIN
  location := NEW(TrackVBT.T).init(); 
  map := NEW(MapVBT.T).init( cp := CursorTrack);

  header := HVSplit.Cons(Axis.T.Hor,
                         NEW(TextVBT.T).init("Header"),
                         HVBar.New(size:= 1.0, txt := Pixmap.Gray),
                         location);

  workspace := HVSplit.Cons(Axis.T.Ver,
                            NEW(TextVBT.T).init("Workspace"),
                            HVBar.New(size:= 1.0, txt := Pixmap.Gray),
                            map);

  footer := StatusVBT.get();
            

  vbt := HVSplit.Cons(Axis.T.Ver,
                      BorderedVBT.New(
                          HVSplit.Cons(Axis.T.Ver,
                                       BorderedVBT.New(header),
                                       HVBar.New(size:= 1.0, txt := Pixmap.Gray),
                                       BorderedVBT.New(workspace),
                                       HVBar.New(size:= 1.0, txt := Pixmap.Gray),
                                       BorderedVBT.New(footer)),
                          size := 1.0,
                          txt := Pixmap.Gray )
  );



    Trestle.Install(vbt);
    StatusVBT.update("loading pixmaps");
    pmVBT := Get("/home/drt/bonn.pnm");
    pos1.set(50.7289410, 7.1053863); 
    pos2.set(50.7274979, 7.1079344); 
    list :=  TextList.List2( "1234", "12");
    plist := PosList.List2( pos1, pos2 );

    Trestle.AwaitDelete(vbt);

(*  IO.PutInt(scrt.bits);*)

END Test.
