-- Code by Jon Squire, adapted to Ada 2005
-- (easy: Generic_Real_Arrays = Ada.Numerics.Generic_Real_Arrays)
-- http://www.cs.umbc.edu/~squire/adaclass/gnatmath95/

with Ada.Numerics.Generic_Real_Arrays;

generic
   type Real is digits <>;
   with package Real_Arrays is new Ada.Numerics.Generic_Real_Arrays (Real);

package Generic_Real_Linear_Equations is

   use Real_Arrays;
   type Integer_Vector is array (Integer range <>) of Integer;

   function Linear_Equations
     (A : Real_Matrix;
      Y : Real_Vector) return Real_Vector;

   function Linear_Equations
     (A : Real_Matrix;
      Y : Real_Matrix) return Real_Matrix;

   function Determinant (A : Real_Matrix) return Real;

   function Inverse (A : Real_Matrix) return Real_Matrix;

   procedure Inverse (A : in out Real_Matrix);

   function Crout_Solve (A : Real_Matrix; Y : Real_Vector) return Real_Vector;

   function Cholesky_Decomposition (A : Real_Matrix) return Real_Matrix;

   function Cholesky_Solve
     (L : Real_Matrix;
      Y : Real_Vector) return Real_Vector;

   procedure Lu_Decomposition
     (A :        Real_Matrix;
      L : in out Real_Matrix;
      U : in out Real_Matrix;
      P : in out Integer_Vector);

   function Lu_Solve
     (L : Real_Matrix;
      U : Real_Matrix;
      P : Integer_Vector;
      Y : Real_Vector) return Real_Vector;

   procedure Qr_Decomposition
     (A :        Real_Matrix;
      Q : in out Real_Matrix;
      R : in out Real_Matrix);

   function Qr_Solve
     (Q : Real_Matrix;
      R : Real_Matrix;
      Y : Real_Vector) return Real_Vector;

   procedure Sv_Decomposition
     (A  :        Real_Matrix;
      Uu : in out Real_Matrix;
      Vv : in out Real_Matrix;
      Ww : in out Real_Vector);

   function Sv_Solve
     (U : Real_Matrix;
      V : Real_Matrix;
      W : Real_Vector;
      Y : Real_Vector) return Real_Vector;

   Matrix_Data_Error : exception; -- raised for singular, non positive definate,
                                 -- not symmetric, etc.

   Array_Index_Error : exception; -- renames ARRAY_EXCEPTIONS.ARRAY_INDEX_ERROR;

end Generic_Real_Linear_Equations;
