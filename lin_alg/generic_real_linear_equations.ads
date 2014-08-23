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
     --      Purpose : Solve the linear system of equations with real
     --                coefficients   [A] * |X| = |Y|
     --
     --      Input  : The real matrix  A
     --               The real vector  Y
     --
     --      Output : The real vector  X
     --
     --      Method : Gauss-Jordan elimination using maximum element
     --               for pivot.
     --
     --      Exception : Matrix_Data_Error if 'A' is singular
     --                  Array_Index_Error if 'A' is not square or
     --                                       length of 'Y' /= Rows of 'A'
     --
     --      Usage  :     X := Linear_Equations ( A , Y ) ;
     --
     --      WRITTEN BY : JON SQUIRE , 28 MAY 1983 (Yes, its that old!)
     --      revised 10/8/88 for nested generics
     --      revised 8/8/90 for ISO NRG proposed standard packages interface
     

   function Linear_Equations
     (A : Real_Matrix;
      Y : Real_Matrix) return Real_Matrix;
     --      Purpose : Solve the linear system of equations with real
     --                coefficients   [A] * [X] = [Y]
     --
     --      Input  : The real matrix  A
     --               The real matrix  Y
     --
     --      Output : The real matrix  X
     --
     --      Method : Gauss-Jordan elimination using maximum element
     --               for pivot.
     --
     --      Usage  :     X := Linear_Equations ( A , Y ) ;
     --
     --      Exception : Matrix_Data_Error will be raised if 'A' is singular
     --                  Array_Index_Error if 'A' is not square or
     --                                       rows of 'Y' /= rows of 'A'
   
   
   function Determinant (A : Real_Matrix) return Real;
   --      Purpose : Compute the determinant of a matrix
   --
   --      Input  : The real matrix  A
   --
   --      Output : The real value   D
   --
   --      Method : Gauss-Jordan elimination using maximum element
   --               for pivot.
   --
   --      Usage  :     D := Determinant ( A ) ;
   --
   --      Exceptions : Array_Index_Error if the matrix is not square
   --
   --      Written By : Jon Squire , 28 May 1983
   
   
   function Inverse (A : Real_Matrix) return Real_Matrix;
   --      Purpose : Invert an N by N matrix
   --
   --      Input : The matrix  A
   --
   --      Output : The inverse of matrix  A
   --
   --      Method : Gauss-Jordan elimination using maximum element
   --               for pivot.
   --
   --      Exception : Matrix_Data_Error raised if inverse can not be computed
   --                  Array_Index_Error if 'A' is not square
   --
   --      Sample Use :  New_Matrix := Inverse ( Old_Matrix ) ;
   --                    Matrix := Inverse ( Matrix ) * Another_Matrix ;
   --
   --      Written By : Jon Squire , 3 Feb 1983
   
   
   procedure Inverse (A : in out Real_Matrix);
   --      Purpose : Invert an N by N matrix in place
   --
   --      Input : The matrix  A
   --
   --      Output : The inverse of matrix  A, in place
   --
   --      Method : Gauss-Jordan elimination using maximum element
   --               for pivot.
   --
   --      Exception : Matrix_Data_Error raised if inverse can not be computed
   --                  Array_Index_Error raised if matrix is not square
   --
   --      Sample Use :  Inverse ( Some_Matrix ) ;
   
   
   function Crout_Solve (A : Real_Matrix; Y : Real_Vector) return Real_Vector;
   --      Purpose : Solve the linear system of equations with real
   --                coefficients   [A] * |X| = |Y|
   --
   --      Input  : The real matrix  A
   --               The real vector  Y
   --
   --      Output : The real vector  X
   --
   --      Method : Crout reduction and back substitution using
   --               maximum element for diagonal
   --
   --      Usage  :     X := Crout_Solve ( A , Y ) ;
   --
   --      Exception : Array_Index_Error  raised if 'A' not square or
   --                                     Y Length /= Rows of 'A'
   --                  Matrix_Data_Error  raised if 'A' singular
   --
   --      Written By : Jon Squire , 11/30/88
   
   
   function Cholesky_Decomposition (A : Real_Matrix) return Real_Matrix;
   --      Purpose : Compute the Cholesky decomposition of a symmetric
   --                positive definite matrix 'A'
   --                Choleskey_Solve may then be used to solve linear equations
   --
   --      Input  : The real matrix  A
   --
   --      Output : The real matrix  L
   --
   --      Method : Cholesky Decomposition
   --
   --      Usage  :     L := Cholesky_Decomposition ( A ) ;
   --
   --      Exception : Array_Index_Error  raised if 'A' not square
   --                  Matrix_Data_Error  raised if 'A' not symmetric or
   --                                               'A' not positive definite
   --
   --      Written By : Jon Squire , 11/30/88
   
   
   function Cholesky_Solve
     (L : Real_Matrix;
      Y : Real_Vector) return Real_Vector;
   --      Purpose : Solve the linear system of equations with real
   --                coefficients   [A] * |X| = |Y| using Cholesky
   --                Decomposition
   --
   --      Input  : The real matrix  L  =  Cholesky_Decomposition ( A )
   --               The real vector  Y
   --
   --      Output : The real vector  X
   --
   --      Method : Back substitution using cholesky decomposition
   --
   --      Usage  :  X := Cholesky_Solve ( Cholesky_Decomposition ( A ) , Y ) ;
   --
   --      Exception : Array_Index_Error  raised if 'A' not square or
   --                                     Y length /= rows of 'A'
   --                  Matrix_Data_Error  raised if 'A' singular
   --
   --      Written By : Jon Squire , 11/30/88
   
   
   procedure Lu_Decomposition
     (A :        Real_Matrix;
      L : in out Real_Matrix;
      U : in out Real_Matrix;
      P : in out Integer_Vector);
   --      Purpose : Compute the Lu decomposition of matrix 'A'
   --                Lu_Solve may then be used to solve linear equations
   --
   --      Input  : The real matrix  A
   --
   --      Output : The real matrix  L, lower triangular
   --               The real matrix  U, upper triangular
   --               The integer vector P, row permutation of  A
   --
   --      Method : Lu decomposition  P applied to  A = L * U
   --               diagonal of L = 1.0
   --
   --      Usage  : Lu_Decomposition ( A , L, U, P ) ;
   --
   --      Exception : Array_Index_Error  raised if 'A' not square
   --                  Matrix_Data_Error  raised if 'A' is singular
   --
   
   
   function Lu_Solve
     (L : Real_Matrix;
      U : Real_Matrix;
      P : Integer_Vector;
      Y : Real_Vector) return Real_Vector;
   --      Purpose : Solve the linear system of equations with real
   --                coefficients   [A] * |X| = |Y| using Lu decomposition
   --
   --      Input  : The real matrix  L    \_ From lu_decomposition
   --               The real matrix  U     /
   --               The integer vector P  /
   --               The real vector  Y
   --
   --      Output : The real vector  X
   --
   --      Method : Back substitution using lu decomposition
   --
   --      Usage  :  X := Lu_Solve ( L, U, P, Y ) ;
   --
   --      Exception : Array_Index_Error  raised if 'L' and 'U' different size
   --                                     Y length /= rows of 'L'
   --
   
   
   procedure Qr_Decomposition
     (A :        Real_Matrix;
      Q : in out Real_Matrix;
      R : in out Real_Matrix);
   --      Purpose : Compute the Qr decomposition of matrix 'A'
   --                Qr_Solve may then be used to solve linear equations
   --
   --      Input  : The real matrix  A
   --
   --      Output : The real matrix  Q
   --               The real matrix  R
   --
   --      Method : Qr decomposition     A = Q * R    Q * Transpose(Q) = I
   --                                    R is upper triangular
   --                                    Q is orthagonal
   --
   --      Usage  : Qr_Decomposition ( A , Q, R ) ;
   --
   --      Exception : Array_Index_Error  raised if 'A' not square or
   --                                     'A', 'Q', and 'R' not same size
   --                  Matrix_Data_Error  raised if 'A' is singular
   --
   
   
   function Qr_Solve
     (Q : Real_Matrix;
      R : Real_Matrix;
      Y : Real_Vector) return Real_Vector;
   --      Purpose : Solve the linear system of equations with real
   --                coefficients   [A] * |X| = |Y| using Qr decomposition
   --
   --      Input  : The real matrix  Q    \_ From qr_decomposition
   --               The real matrix  R     /
   --               The real vector  Y
   --
   --      Output : The real vector  X
   --
   --      Method : Back substitution using Lu decomposition
   --
   --      Usage  :  X := Lu_Solve ( Q, R, Y ) ;
   --
   --      Exception : Array_Index_Error  raised if 'Q' and 'R' different size
   --                                     Y length /= rows of 'Q'
   --
   
   
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
   
   
   Matrix_Data_Error : exception; -- raised for singular, non positive definite,
				  -- not symmetric, etc.
   
   
   Array_Index_Error : exception; -- renames ARRAY_EXCEPTIONS.ARRAY_INDEX_ERROR;

end Generic_Real_Linear_Equations;
