INTERFACE Pos;

TYPE  
  T <: Public;
  Public = OBJECT
  METHODS
    init(): T;
    set( x, y : REAL);
    setT( x, y : TEXT);
    fmtx() : REAL;
    fmty() : REAL;
    fmtT() : TEXT;
  END;

(* We need this to implement the generic List. *)
CONST Brand = "Pos";  
PROCEDURE Equal(k1, k2: T): BOOLEAN;  

END Pos.
