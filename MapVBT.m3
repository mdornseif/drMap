MODULE MapVBT;

IMPORT Axis, PaintOp, Pixmap, Point, Rect, Region, VBT;

REVEAL
  T = Public BRANDED OBJECT
    pm          : Pixmap.T;
    op          : PaintOp.T;
    cursorpos   : Point.T;
    klickpos    : Point.T;
    cursortrack : TrackProc;
    klicktrack  : TrackProc;
  OVERRIDES
    init      := Init;
    repaint   := Repaint;
    shape     := Shape;
    position  := Position;
  END;

PROCEDURE Init (v: T; pm : Pixmap.T; ct: TrackProc): T =
  BEGIN
    v.pm := pm;
    v.op := PaintOp.Copy;
    v.cursorpos.v := 0;
    v.cursorpos.h := 0;
    v.cursortrack := ct;
    RETURN v;
  END Init;


PROCEDURE Repaint (v: T; READONLY rgn: Region.T) =
  VAR
    dom     := VBT.Domain(v);
    bounds  := VBT.PixmapDomain(v, v.pm);
    delta: Point.T;
    a    : Rect.Partition;
  BEGIN
    delta.h := (dom.west - bounds.west);
    delta.v := (dom.north - bounds.north);
    Rect.Factor(Rect.Meet(dom, rgn.r), Rect.Move(bounds, delta), a, 0, 0);
    VBT.PaintPixmap(v, a[2], v.op, v.pm, delta);
    a[2] := Rect.Empty;
    VBT.PolyTexture(v, a, PaintOp.Bg, Pixmap.Solid)
  END Repaint;

PROCEDURE Shape (v: T; ax: Axis.T; <* UNUSED *> n: CARDINAL): VBT.SizeRange =
  VAR sr: VBT.SizeRange;
  BEGIN
    sr.lo := Rect.Size(ax, VBT.PixmapDomain(v, v.pm));
    sr.pref := MAX(sr.lo, 400);
    sr.hi := MAX(sr.pref + 1, VBT.DefaultShape.hi);
    RETURN sr;
  END Shape;

  
PROCEDURE Position(v: T; READONLY cd: VBT.PositionRec) =
BEGIN
  IF NOT cd.cp.gone THEN
    v.cursorpos.h := cd.cp.pt.h;
    v.cursorpos.v := cd.cp.pt.v;
  END;
  VBT.SetCage(v, VBT.CageFromPosition(cd.cp));
  IF v.cursortrack # NIL THEN
    v.cursortrack( cd );
  END;
END Position;


BEGIN END MapVBT.
