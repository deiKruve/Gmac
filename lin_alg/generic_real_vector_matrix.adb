

with ARRAY_EXCEPTIONS;
package body GENERIC_REAL_VECTOR_MATRIX is

--
--    WRITTEN BY : JON SQUIRE , 27 FEB 1983
--    REVISED BY : JON SQUIRE , 28 DEC 1993
--
--
--    FOR THE TYPE  Gra.Real_Matrix  THE FIRST SUBSCRIPT IS THE ROW NUMBER,
--                               THE SECOND SUBSCRIPT IS THE COLUMN NUMBER
--

  ARRAY_INDEX_ERROR : exception renames ARRAY_EXCEPTIONS.ARRAY_INDEX_ERROR;

  function COLUMN_TO_VECTOR ( COLUMN : INTEGER ;
                              A : Gra.Real_Matrix ) return Gra.Real_Vector is
    V : Gra.Real_Vector ( A'RANGE(1)) ;
  begin
    if COLUMN < A'FIRST(2) or
       COLUMN > A'LAST(2) then
      raise ARRAY_INDEX_ERROR;
    end if;
    for J in A'RANGE(1) loop
      V ( J ) := A ( J , COLUMN ) ;
    end loop ;
    return V ;
  end COLUMN_TO_VECTOR ;

  procedure VECTOR_TO_COLUMN ( V : Gra.Real_Vector ;
                               COLUMN : INTEGER ;
                               A : in out Gra.Real_Matrix ) is
  begin
    if V'LENGTH /= A'LENGTH(1) or
       COLUMN < A'FIRST(2) or
       COLUMN > A'LAST(2) then
      raise ARRAY_INDEX_ERROR ;
    end if ;
    for I in A'RANGE(1) loop
      A ( I , COLUMN ) := V ( I - A'FIRST(1) + V'FIRST) ;
    end loop ;
  end VECTOR_TO_COLUMN ;

  function ROW_TO_VECTOR ( ROW : INTEGER ;
                           A : Gra.Real_Matrix ) return Gra.Real_Vector is
    V : Gra.Real_Vector ( A'RANGE(2) ) ;
  begin
    if ROW < A'FIRST(1) or
       ROW > A'LAST(1) then
      raise ARRAY_INDEX_ERROR ;
    end if ;
    for J in A'RANGE(2) loop
      V ( J ) := A ( ROW , J ) ;
    end loop ;
    return V ;
  end ROW_TO_VECTOR ;

  procedure VECTOR_TO_ROW ( V : Gra.Real_Vector ;
                            ROW : INTEGER ;
                            A : in out Gra.Real_Matrix ) is
  begin
    if V'LENGTH /= A'LENGTH(2) or
       ROW < A'FIRST(1) or
       ROW > A'LAST(1) then
      raise ARRAY_INDEX_ERROR ;
    end if ;
    for J in A'RANGE(2) loop
      A ( ROW , J ) := V ( J - A'FIRST( 2 ) + V'FIRST) ;
    end loop ;
  end VECTOR_TO_ROW ;

  function DIAGONAL_TO_VECTOR ( A : Gra.Real_Matrix ) return Gra.Real_Vector is
    V : Gra.Real_Vector ( A'RANGE(1) ) ;
  begin
    if A'LENGTH(1) /= A'LENGTH(2) then
      raise ARRAY_INDEX_ERROR ;
    end if ;
    for J in A'RANGE(1) loop
      V ( J ) := A ( J , J-A'FIRST(1)+A'FIRST(2) ) ;
    end loop ;
    return V ;
  end DIAGONAL_TO_VECTOR ;

  procedure VECTOR_TO_DIAGONAL ( V: Gra.Real_Vector ; A : in out Gra.Real_Matrix ) is
  begin
    if V'LENGTH /= A'LENGTH(1) or
       V'LENGTH /= A'LENGTH(2) then
      raise ARRAY_INDEX_ERROR ;
    end if ;
    for J in A'RANGE ( 1 ) loop
      A ( J , J-A'FIRST(1)+A'FIRST(2)) := V ( J-A'FIRST(1)+V'FIRST) ;
    end loop ;
  end VECTOR_TO_DIAGONAL ;

  function VECTOR_TO_DIAGONAL ( V: Gra.Real_Vector ) return Gra.Real_Matrix is
    A : Gra.Real_Matrix ( V'RANGE, V'RANGE ) := (others=>(others=>0.0));
  begin
    for J in V'RANGE loop
      A ( J , J ) := V ( J ) ;
    end loop ;
    return A ;
  end VECTOR_TO_DIAGONAL ;

  function EXTRACT_SUB_MATRIX ( ROW_1 , ROW_2 , COL_1 , COL_2 : INTEGER ;
                                A : Gra.Real_Matrix ) return Gra.Real_Matrix is
    SUB_MATRIX : Gra.Real_Matrix ( ROW_1 .. ROW_2 , COL_1 .. COL_2 ) ;
  begin
    if ROW_2 < ROW_1 or
       COL_2 < COL_1 then
      raise ARRAY_INDEX_ERROR ;
    end if ;
    if ROW_1 < A'FIRST ( 1 ) or
       ROW_2 > A'LAST ( 1 ) or
       COL_1 < A'FIRST ( 2 ) or
       COL_2 > A'LAST ( 2 ) then
      raise ARRAY_INDEX_ERROR ;
    end if ;
    for I in ROW_1 .. ROW_2 loop
      for J in COL_1 .. COL_2 loop
        SUB_MATRIX ( I , J ) := A ( I - ROW_1 + A'FIRST(1) , J - COL_1 +
            A'FIRST ( 2 )) ;
      end loop ;
    end loop ;
    return SUB_MATRIX ;
  end EXTRACT_SUB_MATRIX ;

  procedure INSERT_SUB_MATRIX ( SUB_MATRIX : Gra.Real_Matrix ;
                                ROW , COLUMN : INTEGER ;
                                A : in out Gra.Real_Matrix ) is
  begin
    if ROW < A'FIRST ( 1 ) or
       COLUMN < A'FIRST ( 2 ) or
       ROW + SUB_MATRIX'LENGTH ( 1 ) - 1 > A'LAST ( 1 ) or
       COLUMN + SUB_MATRIX'LENGTH ( 2 ) - 1 > A'LAST ( 2 ) then
      raise ARRAY_INDEX_ERROR ;
    end if ;
    for I in SUB_MATRIX'RANGE ( 1 ) loop
      for J in SUB_MATRIX'RANGE ( 2 ) loop
        A ( I - SUB_MATRIX'FIRST( 1 ) + ROW , J - SUB_MATRIX'FIRST ( 2 ) +
            COLUMN) := SUB_MATRIX ( I , J ) ;
      end loop ;
    end loop ;
  end INSERT_SUB_MATRIX ;

end GENERIC_REAL_VECTOR_MATRIX ;
