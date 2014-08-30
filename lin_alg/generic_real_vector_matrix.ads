-- GENERIC_REAL_VECTOR_MATRIX.ADA

with Ada.Numerics.Generic_Real_Arrays;

generic
  type REAL is digits <> ;
  --type REAL_VECTOR is array (INTEGER range<>) of REAL ;
  --type REAL_MATRIX is array (INTEGER range <>, INTEGER range <>) of REAL;
package GENERIC_REAL_VECTOR_MATRIX is
   package Gra is new Ada.Numerics.Generic_Real_Arrays (Real);

  function COLUMN_TO_VECTOR ( COLUMN : INTEGER ;
                              A : Gra.Real_Matrix ) return Gra.Real_Vector ;

  procedure VECTOR_TO_COLUMN ( V : Gra.Real_Vector ;
                               COLUMN : INTEGER ;
                               A : in out Gra.Real_Matrix ) ;

  function ROW_TO_VECTOR ( ROW : INTEGER ;
                           A : Gra.Real_Matrix ) return Gra.Real_Vector ;

  procedure VECTOR_TO_ROW ( V : Gra.Real_Vector ;
                            ROW : INTEGER ;
                            A : in out Gra.Real_Matrix ) ;

  function DIAGONAL_TO_VECTOR ( A : Gra.Real_Matrix ) return Gra.Real_Vector ;

  procedure VECTOR_TO_DIAGONAL ( V: Gra.Real_Vector ; A : in out Gra.Real_Matrix ) ;

  function VECTOR_TO_DIAGONAL ( V: Gra.Real_Vector ) return Gra.Real_Matrix ;

  function EXTRACT_SUB_MATRIX ( ROW_1 , ROW_2 , COL_1 , COL_2 : INTEGER ;
                                A : Gra.Real_Matrix ) return Gra.Real_Matrix ;

  procedure INSERT_SUB_MATRIX ( SUB_MATRIX : Gra.Real_Matrix ;
                                ROW , COLUMN : INTEGER ;
                                A : in out Gra.Real_Matrix ) ;

end GENERIC_Real_Vector_MATRIX ;
