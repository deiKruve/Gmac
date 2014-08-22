with Ada.Text_IO; use Ada.Text_IO; -- for debug
--with INTEGER_ARRAYS_IO;  -- for debug
--with REAL_ARRAYS_IO; -- for debug
with Ada.Numerics.Generic_Elementary_Functions;
package body Generic_Real_Linear_Equations is

   package Elementary_Functions is new Ada.Numerics
     .Generic_Elementary_Functions
     (Real);

--  package REAL_IO is new REAL_ARRAYS_IO
--                            (REAL, Real_Arrays); -- for debug
--  use REAL_IO; -- for debug
--  package INT_IO is new INTEGER_ARRAYS_IO
--                            (Integer, Integer_Arrays); -- for debug
--  use INT_IO; -- for debug

   function Linear_Equations
     (A : Real_Matrix;
      Y : Real_Vector) return Real_Vector
   is

    --      PURPOSE : SOLVE THE LINEAR SYSTEM OF EQUATIONS WITH REAL
    --                COEFFICIENTS   [A] * |X| = |Y|
    --
    --      INPUT  : THE REAL MATRIX  A
    --               THE REAL VECTOR  Y
    --
    --      OUTPUT : THE REAL VECTOR  X
    --
    --      METHOD : GAUSS-JORDAN ELIMINATION USING MAXIMUM ELEMENT
    --               FOR PIVOT.
    --
    --      EXCEPTION : MATRIX_DATA_ERROR IF 'A' IS SINGULAR
    --                  ARRAY_INDEX_ERROR IF 'A' IS NOT SQUARE OR
    --                                       LENGTH OF 'Y' /= ROWS OF 'A'
    --
    --      USAGE  :     X := LINEAR_EQUATIONS ( A , Y ) ;
    --
    --      WRITTEN BY : JON SQUIRE , 28 MAY 1983 (Yes, its that old!)
    --      revised 10/8/88 for nested generics
    --      revised 8/8/90 for ISO NRG proposed standard packages interface

      N             : constant Integer := A'Length (1); -- NUMBER OF EQUATIONS
      X             : Real_Vector (1 .. N);          -- RESULT BEING COMPUTED
      B             : Real_Matrix (1 .. N, 1 .. N + 1);  -- WORKING MATRIX
      Row           : array (1 .. N) of Integer;   -- ROW INTERCHANGE INDICIES
      Hold, I_Pivot : Integer;            -- PIVOT INDICIES
      Pivot         : Real;                        -- PIVOT ELEMENT VALUE
      Abs_Pivot     : Real;                    -- ABS OF PIVOT ELEMENT
      Norm1         : Real := 0.0;                 -- 1 NORM OF MATRIX
   begin
      if A'Length (1) /= A'Length (2) or A'Length (1) /= Y'Length then
         raise Array_Index_Error;
      end if;

    --                               BUILD WORKING DATA STRUCTURE
      for I in 1 .. N loop
         for J in 1 .. N loop
            B (I, J) := A (I - 1 + A'First (1), J - 1 + A'First (2));
            if abs B (I, J) > Norm1 then
               Norm1 := abs B (I, J);
            end if;
         end loop;
         B (I, N + 1) := Y (I - 1 + Y'First);
      end loop;

    --                               SET UP ROW  INTERCHANGE VECTORS
      for K in 1 .. N loop
         Row (K) := K;
      end loop;

    --                               BEGIN MAIN REDUCTION LOOP
      for K in 1 .. N loop

      --                             FIND LARGEST ELEMENT FOR PIVOT
         Pivot     := B (Row (K), K);
         Abs_Pivot := abs (Pivot);
         I_Pivot   := K;
         for I in K .. N loop
            if abs (B (Row (I), K)) > Abs_Pivot then
               I_Pivot   := I;
               Pivot     := B (Row (I), K);
               Abs_Pivot := abs (Pivot);
            end if;
         end loop;

      --                             CHECK FOR NEAR SINGULAR
         if Abs_Pivot < Real'Epsilon * Norm1 then
            raise Matrix_Data_Error;
         end if;

      --                             HAVE PIVOT, INTERCHANGE ROW POINTERS
         Hold          := Row (K);
         Row (K)       := Row (I_Pivot);
         Row (I_Pivot) := Hold;

      --                           REDUCE ABOUT PIVOT
         for J in K + 1 .. N + 1 loop
            B (Row (K), J) := B (Row (K), J) / B (Row (K), K);
         end loop;

      --                           INNER REDUCTION LOOP
         for I in 1 .. N loop
            if I /= K then
               for J in K + 1 .. N + 1 loop
                  B (Row (I), J) :=
                    B (Row (I), J) - B (Row (I), K) * B (Row (K), J);
               end loop;
            end if;
         end loop;

      --                             FINISHED INNER REDUCTION
      end loop;

    --                               BUILD  X  FOR RETURN, UNSCRAMBLING ROWS
      for I in 1 .. N loop
         X (I) := B (Row (I), N + 1);
      end loop;
      return X;
   end Linear_Equations;

   function Linear_Equations
     (A : Real_Matrix;
      Y : Real_Matrix) return Real_Matrix
   is

    --      PURPOSE : SOLVE THE LINEAR SYSTEM OF EQUATIONS WITH REAL
    --                COEFFICIENTS   [A] * [X] = [Y]
    --
    --      INPUT  : THE REAL MATRIX  A
    --               THE REAL MATRIX  Y
    --
    --      OUTPUT : THE REAL MATRIX  X
    --
    --      METHOD : GAUSS-JORDAN ELIMINATION USING MAXIMUM ELEMENT
    --               FOR PIVOT.
    --
    --      USAGE  :     X := LINEAR_EQUATIONS ( A , Y ) ;
    --
    --      EXCEPTION : MATRIX_DATA_ERROR WILL BE RAISED IF 'A' IS SINGULAR
    --                  ARRAY_INDEX_ERROR IF 'A' IS NOT SQUARE OR
    --                                       ROWS OF 'Y' /= ROWS OF 'A'

      N : constant Integer := A'Length (1);      -- NUMBER OF EQUATIONS
      M : constant Integer :=
        Y'Length (2);      -- NUMBER OF SOLUTIONS REQUESTED
      X : Real_Matrix (1 .. N, 1 .. M);      -- RESULT BEING COMPUTED
      B             : Real_Matrix (1 .. N, 1 .. N + M);  -- WORKING MATRIX
      Row : array (1 .. N) of Integer;        -- ROW INTERCHANGE INDICIES
      Hold, I_Pivot : Integer;                 -- PIVOT INDICIES
      Pivot         : Real;                             -- PIVOT ELEMENT VALUE
      Abs_Pivot     : Real;                         -- ABS OF PIVOT ELEMENT
      Norm1         : Real := 0.0;                      -- 1 NORM OF MATRIX
   begin
      if A'Length (1) /= A'Length (2) or A'Length (1) /= Y'Length (1) then
         raise Array_Index_Error;
      end if;

    --                               BUILD WORKING DATA STRUCTURE
      for I in 1 .. N loop
         for J in 1 .. N loop
            B (I, J) := A (I - 1 + A'First (1), J - 1 + A'First (2));
            if abs B (I, J) > Norm1 then
               Norm1 := abs B (I, J);
            end if;
         end loop;
         for J in 1 .. M loop
            B (I, N + J) := Y (I - 1 + Y'First (1), J - 1 + Y'First (2));
         end loop;
      end loop;

    --                               SET UP ROW  INTERCHANGE VECTORS
      for K in 1 .. N loop
         Row (K) := K;
      end loop;

    --                               BEGIN MAIN REDUCTION LOOP
      for K in 1 .. N loop

      --                             FIND LARGEST ELEMENT FOR PIVOT
         Pivot     := B (Row (K), K);
         Abs_Pivot := abs (Pivot);
         I_Pivot   := K;
         for I in K .. N loop
            if abs (B (Row (I), K)) > Abs_Pivot then
               I_Pivot   := I;
               Pivot     := B (Row (I), K);
               Abs_Pivot := abs (Pivot);
            end if;
         end loop;

      --                             CHECK FOR NEAR SINGULAR
         if Abs_Pivot < Real'Epsilon * Norm1 then
            raise Matrix_Data_Error;
         end if;

      --                             HAVE PIVOT, INTERCHANGE ROW POINTERS
         Hold          := Row (K);
         Row (K)       := Row (I_Pivot);
         Row (I_Pivot) := Hold;

      --                             REDUCE ABOUT PIVOT
         for J in K + 1 .. N + M loop
            B (Row (K), J) := B (Row (K), J) / B (Row (K), K);
         end loop;

      --                             INNER REDUCTION LOOP
         for I in 1 .. N loop
            if I /= K then
               for J in K + 1 .. N + M loop
                  B (Row (I), J) :=
                    B (Row (I), J) - B (Row (I), K) * B (Row (K), J);
               end loop;
            end if;
         end loop;
      --                               FINISHED INNER REDUCTION
      end loop;

    --                               BUILD  X  FOR RETURN, UNSCRAMBLING ROWS
      for I in 1 .. N loop
         for J in 1 .. M loop
            X (I, J) := B (Row (I), N + J);
         end loop;
      end loop;
      return X;
   end Linear_Equations;

   function Determinant (A : Real_Matrix) return Real is

    --      PURPOSE : COMPUTE THE DETERMINANT OF A MATRIX
    --
    --      INPUT  : THE REAL MATRIX  A
    --
    --      OUTPUT : THE REAL VALUE   D
    --
    --      METHOD : GAUSS-JORDAN ELIMINATION USING MAXIMUM ELEMENT
    --               FOR PIVOT.
    --
    --      USAGE  :     D := DETERMINANT ( A ) ;
    --
    --      EXCEPTIONS : ARRAY_INDEX_ERROR IF THE MATRIX IS NOT SQUARE
    --
    --      WRITTEN BY : JON SQUIRE , 28 MAY 1983

      N             : constant Integer := A'Length (1);  -- NUMBER OF ROWS
      D             : Real := 1.0;                      -- DETERMINANT
      B             : Real_Matrix (1 .. N, 1 .. N);  -- WORKING MATRIX
      Row           : array (1 .. N) of Integer;    -- ROW INTERCHANGE INDICIES
      Hold, I_Pivot : Integer;             -- PIVOT INDICIES
      Pivot         : Real;                         -- PIVOT ELEMENT VALUE
      Abs_Pivot     : Real;                     -- ABS OF PIVOT ELEMENT
   begin
      if A'Length (1) /= A'Length (2) then
         raise Array_Index_Error;
      end if;
      B := A;

    --                                 SET UP ROW  INTERCHANGE VECTORS
      for K in 1 .. N loop
         Row (K) := K;
      end loop;

    --                                 BEGIN MAIN REDUCTION LOOP
      for K in 1 .. N - 1 loop

      --                               FIND LARGEST ELEMENT FOR PIVOT
         Pivot     := B (Row (K), K);
         Abs_Pivot := abs Pivot;
         I_Pivot   := K;
         for I in K + 1 .. N loop
            if abs (B (Row (I), K)) > Abs_Pivot then
               I_Pivot   := I;
               Pivot     := B (Row (I), K);
               Abs_Pivot := abs Pivot;
            end if;
         end loop;

      --                               HAVE PIVOT, INTERCHANGE ROW POINTERS
         if I_Pivot /= K then
            Hold          := Row (K);
            Row (K)       := Row (I_Pivot);
            Row (I_Pivot) := Hold;
            D             := -D;
         end if;

         D := D * Pivot; -- ACCUMULATE DETERMINANT, MAY UNDERFLOW

      --                               REDUCE ABOUT PIVOT
         for J in K + 1 .. N loop
            B (Row (K), J) := B (Row (K), J) / B (Row (K), K);
         end loop;

      --                               INNER REDUCTION LOOP
         for I in 1 .. N loop
            if I /= K then
               for J in K + 1 .. N loop
                  B (Row (I), J) :=
                    B (Row (I), J) - B (Row (I), K) * B (Row (K), J);
               end loop;
            end if;
         end loop;

      --                               FINISHED INNER REDUCTION
      end loop;
      return D * B (Row (N), N);
   exception
      when Constraint_Error => -- catches overflow
         return 0.0;
   end Determinant;

   function Inverse (A : Real_Matrix) return Real_Matrix is

    --      PURPOSE : INVERT AN N BY N MATRIX
    --
    --      INPUT : THE MATRIX  A
    --
    --      OUTPUT : THE INVERSE OF MATRIX  A
    --
    --      METHOD : GAUSS-JORDAN ELIMINATION USING MAXIMUM ELEMENT
    --               FOR PIVOT.
    --
    --      EXCEPTION : MATRIX_DATA_ERROR RAISED IF INVERSE CAN NOT BE COMPUTED
    --                  ARRAY_INDEX_ERROR IF 'A' IS NOT SQUARE
    --
    --      SAMPLE USE :  NEW_MATRIX := INVERSE ( OLD_MATRIX ) ;
    --                    MATRIX := INVERSE ( MATRIX ) * ANOTHER_MATRIX ;
    --
    --      WRITTEN BY : JON SQUIRE , 3 FEB 1983

      N : constant Integer := A'Length;        -- SIZE OF MATRIX
      Aa : Real_Matrix (1 .. N, 1 .. N);    -- WORKING MATRIX
      Temp : Real_Vector (1 .. N);           -- TEMPORARY FOR UNSCRAMBLING ROWS
      Row, Col : array (1 .. N) of Integer; -- ROW,COLUMN INTERCHANGE INDICIES
      Hold, I_Pivot, J_Pivot : Integer;      -- PIVOT INDICIES
      Pivot : Real;                            -- PIVOT ELEMENT VALUE
      Abs_Pivot : Real;                        -- ABS OF PIVOT ELEMENT
      Norm1 : Real             := 0.0;                     -- 1 NORM OF MATRIX
   begin
      if A'Length (1) /= A'Length (2) then
         raise Array_Index_Error;
      end if;

    --                              BUILD WORKING DATA STRUCTURE
      Aa := A;
      for I in 1 .. N loop
         for J in 1 .. N loop
            if abs Aa (I, J) > Norm1 then
               Norm1 := abs Aa (I, J);
            end if;
         end loop;
      end loop;

    --                              SET UP ROW AND COLUMN INTERCHANGE VECTORS
      for K in 1 .. N loop
         Row (K) := K;
         Col (K) := K;
      end loop;

    --                              BEGIN MAIN REDUCTION LOOP
      for K in 1 .. N loop

      --                            FIND LARGEST ELEMENT FOR PIVOT
         Pivot   := Aa (Row (K), Col (K));
         I_Pivot := K;
         J_Pivot := K;
         for I in K .. N loop
            for J in K .. N loop
               Abs_Pivot := abs (Pivot);
               if abs (Aa (Row (I), Col (J))) > Abs_Pivot then
                  I_Pivot := I;
                  J_Pivot := J;
                  Pivot   := Aa (Row (I), Col (J));
               end if;
            end loop;
         end loop;

      --                            TEST FOR SINGULAR
         if Abs_Pivot < Real'Epsilon * Norm1 then
            raise Matrix_Data_Error;
         end if;

         Hold          := Row (K);
         Row (K)       := Row (I_Pivot);
         Row (I_Pivot) := Hold;
         Hold          := Col (K);
         Col (K)       := Col (J_Pivot);
         Col (J_Pivot) := Hold;

      --                            REDUCE ABOUT PIVOT
         Aa (Row (K), Col (K)) := 1.0 / Pivot;
         for J in 1 .. N loop
            if J /= K then
               Aa (Row (K), Col (J)) :=
                 Aa (Row (K), Col (J)) * Aa (Row (K), Col (K));
            end if;
         end loop;

      --                            INNER REDUCTION LOOP
         for I in 1 .. N loop
            if K /= I then
               for J in 1 .. N loop
                  if K /= J then
                     Aa (Row (I), Col (J)) :=
                       Aa (Row (I), Col (J)) -
                       Aa (Row (I), Col (K)) * Aa (Row (K), Col (J));
                  end if;
               end loop;
               Aa (Row (I), Col (K)) :=
                 -Aa (Row (I), Col (K)) * Aa (Row (K), Col (K));
            end if;
         end loop;

      --                            FINISHED INNER REDUCTION
      end loop;

    --                              UNSCRAMBLE ROWS
      for J in 1 .. N loop
         for I in 1 .. N loop
            Temp (Col (I)) := Aa (Row (I), J);
         end loop;
         for I in 1 .. N loop
            Aa (I, J) := Temp (I);
         end loop;
      end loop;

    --                              UNSCRAMBLE COLUMNS
      for I in 1 .. N loop
         for J in 1 .. N loop
            Temp (Row (J)) := Aa (I, Col (J));
         end loop;
         for J in 1 .. N loop
            Aa (I, J) := Temp (J);
         end loop;
      end loop;
      return Aa;
   end Inverse;

   procedure Inverse (A : in out Real_Matrix) is

    --      PURPOSE : INVERT AN N BY N MATRIX IN PLACE
    --
    --      INPUT : THE MATRIX  A
    --
    --      OUTPUT : THE INVERSE OF MATRIX  A, IN PLACE
    --
    --      METHOD : GAUSS-JORDAN ELIMINATION USING MAXIMUM ELEMENT
    --               FOR PIVOT.
    --
    --      EXCEPTION : MATRIX_DATA_ERROR RAISED IF INVERSE CAN NOT BE COMPUTED
    --                  ARRAY_INDEX_ERROR RAISED IF MATRIX IS NOT SQUARE
    --
    --      SAMPLE USE :  INVERSE ( SOME_MATRIX ) ;

      N : constant Integer := A'Length;        -- SIZE OF MATRIX
      Aa : Real_Matrix (1 .. N, 1 .. N);    -- WORKING MATRIX
      Row, Col : array (1 .. N) of Integer; -- ROW,COLUMN INTERCHANGE INDICIES
      Temp : Real_Vector (1 .. N);           -- TEMP ARRAY FOR UNSCRAMBLING
      Hold, I_Pivot, J_Pivot : Integer;      -- PIVOT INDICIES
      Pivot : Real;  -- PIVOT ELEMENT VALUE    -- PIVOT ELEMENT
      Abs_Pivot : Real;                        -- ABS OF PIVOT ELEMENT
      Norm1 : Real             := 0.0;                     -- 1 NORM OF MATRIX
   begin
      if A'Length (1) /= A'Length (2) then
         raise Array_Index_Error;
      end if;

    --                              BUILD WORKING DATA STRUCTURE
      Aa := A;
      for I in 1 .. N loop
         for J in 1 .. N loop
            if abs Aa (I, J) > Norm1 then
               Norm1 := abs Aa (I, J);
            end if;
         end loop;
      end loop;

    --                              SET UP ROW AND COLUMN INTERCHANGE VECTORS
      for K in 1 .. N loop
         Row (K) := K;
         Col (K) := K;
      end loop;

    --                              BEGIN MAIN REDUCTION LOOP
      for K in 1 .. N loop

      --                            FIND LARGEST ELEMENT FOR PIVOT
         Pivot   := Aa (Row (K), Col (K));
         I_Pivot := K;
         J_Pivot := K;
         for I in K .. N loop
            for J in K .. N loop
               Abs_Pivot := abs (Pivot);
               if abs (Aa (Row (I), Col (J))) > Abs_Pivot then
                  I_Pivot := I;
                  J_Pivot := J;
                  Pivot   := Aa (Row (I), Col (J));
               end if;
            end loop;
         end loop;

      --                            CHECK FOR SINGULAR
         if Abs_Pivot < Real'Epsilon * Norm1 then
            raise Matrix_Data_Error;
         end if;

         Hold          := Row (K);
         Row (K)       := Row (I_Pivot);
         Row (I_Pivot) := Hold;
         Hold          := Col (K);
         Col (K)       := Col (J_Pivot);
         Col (J_Pivot) := Hold;

      --                                REDUCE ABOUT PIVOT
         Aa (Row (K), Col (K)) := 1.0 / Pivot;
         for J in 1 .. N loop
            if J /= K then
               Aa (Row (K), Col (J)) :=
                 Aa (Row (K), Col (J)) * Aa (Row (K), Col (K));
            end if;
         end loop;

      --                            INNER REDUCTION LOOP
         for I in 1 .. N loop
            if K /= I then
               for J in 1 .. N loop
                  if K /= J then
                     Aa (Row (I), Col (J)) :=
                       Aa (Row (I), Col (J)) -
                       Aa (Row (I), Col (K)) * Aa (Row (K), Col (J));
                  end if;
               end loop;
               Aa (Row (I), Col (K)) :=
                 -Aa (Row (I), Col (K)) * Aa (Row (K), Col (K));
            end if;
         end loop;

      --                            FINISHED INNER REDUCTION
      end loop;

    --                              UNSCRAMBLE ROWS
      for J in 1 .. N loop
         for I in 1 .. N loop
            Temp (Col (I)) := Aa (Row (I), J);
         end loop;
         for I in 1 .. N loop
            Aa (I, J) := Temp (I);
         end loop;
      end loop;

    --                              UNSCRAMBLE COLUMNS
      for I in 1 .. N loop
         for J in 1 .. N loop
            Temp (Row (J)) := Aa (I, Col (J));
         end loop;
         for J in 1 .. N loop
            Aa (I, J) := Temp (J);
         end loop;
      end loop;
      A := Aa;
   end Inverse;

   function Crout_Solve
     (A : Real_Matrix;
      Y : Real_Vector) return Real_Vector
   is

    --      PURPOSE : SOLVE THE LINEAR SYSTEM OF EQUATIONS WITH REAL
    --                COEFFICIENTS   [A] * |X| = |Y|
    --
    --      INPUT  : THE REAL MATRIX  A
    --               THE REAL VECTOR  Y
    --
    --      OUTPUT : THE REAL VECTOR  X
    --
    --      METHOD : CROUT REDUCTION AND BACK SUBSTITUTION USING
    --               MAXIMUM ELEMENT FOR DIAGONAL
    --
    --      USAGE  :     X := CROUT_SOLVE ( A , Y ) ;
    --
    --      EXCEPTION : ARRAY_INDEX_ERROR  RASIED IF 'A' NOT SQUARE OR
    --                                     Y LENGTH /= ROWS OF 'A'
    --                  MATRIX_DATA_ERROR  RAISED IF 'A' SINGULAR
    --
    --      WRITTEN BY : JON SQUIRE , 11/30/88

      N : constant Integer := A'Length;         -- NUMBER OF EQUATIONS
      X : Real_Vector (1 .. N);               -- RESULT BEING COMPUTED
      Z : Real_Vector (1 .. N);               -- TEMPORARY IN BACK SUB
      Yy : Real_Vector (1 .. N);              -- TEMPORARY IN BACK SUB
      B             : Real_Matrix (1 .. N, 1 .. N);      -- WORKING MATRIX
      Row : Integer_Vector (1 .. N);           -- ROW INTERCHANGE INDICIES
      Hold, I_Pivot : Integer;                 -- PIVOT INDICIES
      Pivot         : Real;                             -- PIVOT ELEMENT VALUE
      Abs_Pivot     : Real;                         -- ABS OF PIVOT ELEMENT
      Norm1         : Real := 0.0;                      -- 1 NORM OF MATRIX
      Sum           : Real;                               -- TEMP VARIBLE
   begin
      if A'Length (1) /= A'Length (2) or A'Length (1) /= Y'Length then
         raise Array_Index_Error;
      end if;
      Z (1) :=
        0.0; -- calm down "may be referenced before it has a value" warning
      X (1) :=
        0.0; -- calm down "may be referenced before it has a value" warning

    --                        BUILD WORKING DATA STRUCTURE
      for I in 1 .. N loop
         for J in 1 .. N loop
            B (I, J) := A (I - 1 + A'First (1), J - 1 + A'First (2));
            if abs B (I, J) > Norm1 then
               Norm1 := abs B (I, J);
            end if;
         end loop;
         Yy (I) := Y (I - 1 + Y'First);
      end loop;

    --                        SET UP ROW  INTERCHANGE VECTORS
      for K in 1 .. N loop
         Row (K) := K;
      end loop;

    --                         BEGIN MAIN REDUCTION LOOP
      for J in 1 .. N loop

      --                             FIND LARGEST ELEMENT FOR PIVOT
         Pivot     := B (Row (J), J);
         Abs_Pivot := abs (Pivot);
         I_Pivot   := J;
         for I in J + 1 .. N loop
            if abs (B (Row (I), J)) > Abs_Pivot then
               I_Pivot   := I;
               Pivot     := B (Row (I), J);
               Abs_Pivot := abs (Pivot);
            end if;
         end loop;

      --                                CHECK FOR NEAR SINGULAR
         if Abs_Pivot < Real'Epsilon * Norm1 then -- degeneration
            raise Matrix_Data_Error;
         end if;

      --                                HAVE PIVOT, INTERCHANGE ROW POINTERS
         Hold          := Row (J);
         Row (J)       := Row (I_Pivot);
         Row (I_Pivot) := Hold;

      -- below diagonal computations, alphas
         for I in 1 .. J loop
            Sum := 0.0;
            for K in 1 .. I - 1 loop
               Sum := Sum + B (Row (I), K) * B (Row (K), J);
            end loop;
            B (Row (I), J) := B (Row (I), J) - Sum;
         end loop;

      -- above diagonal computations, betas
         for I in J + 1 .. N loop
            Sum := 0.0;
            for K in 1 .. J - 1 loop
               Sum := Sum + B (Row (I), K) * B (Row (K), J);
            end loop;
            B (Row (I), J) := (B (Row (I), J) - Sum) / B (Row (J), J);
         end loop;
         Put_Line ("finished col " & Integer'Image (J));
      end loop;

    -- back substitute, first part
      for I in 1 .. N loop
         Sum := 0.0;
         for J in 1 .. I - 1 loop
            Sum := Sum + B (Row (I), J) * Z (J);
         end loop;
         Z (I) := Yy (I) - Sum;
      end loop;
      Put_Line ("Finished back sub, part 1");
    -- back substitute, second part
      for I in reverse 1 .. N loop
         Sum := 0.0;
         for J in I + 1 .. N loop
            Sum := Sum + B (Row (I), J) * X (J);
         end loop;
         X (I) := (Z (I) - Sum) / B (Row (I), I);
      end loop;
      Put_Line ("Finished back sub, part 2");
      return X;
   end Crout_Solve;

   function Cholesky_Decomposition (A : Real_Matrix) return Real_Matrix is

    --      PURPOSE : COMPUTE THE CHOLESKY DECOMPOSITION OF A SYMMETRIC
    --                POSITIVE DEFINATE MATRIX 'A'
    --                CHOLESKEY_SOLVE MAY THEN BE USED TO SOLVE LINEAR EQUATIONS
    --
    --      INPUT  : THE REAL MATRIX  A
    --
    --      OUTPUT : THE REAL MATRIX  L
    --
    --      METHOD : CHOLESKY DECOMPOSITION
    --
    --      USAGE  :     L := CHOLESKY_DECOMPOSITION ( A ) ;
    --
    --      EXCEPTION : ARRAY_INDEX_ERROR  RASIED IF 'A' NOT SQUARE
    --                  MATRIX_DATA_ERROR  RAISED IF 'A' NOT SYMMETRIC OR
    --                                               'A' NOT POSITIVE DEFINATE
    --
    --      WRITTEN BY : JON SQUIRE , 11/30/88

      L : Real_Matrix (A'Range (1), A'Range (2)) :=
        (others => (others => 0.0));
      Sum : Real;
   begin
      if A'Length (1) /= A'Length (2) then
         raise Matrix_Data_Error;
      end if;
      for I in A'Range (1) loop          -- check A for being symmetric
         for J in A'First (2) - A'First (1) + I + 1 .. A'Last (2) loop
            if A (I, J) /=
              A (A'First (1) - A'First (2) + J, A'First (2) - A'First (1) + I)
            then
               if abs
                 (A (I, J) -
                  A (A'First (1) - A'First (2) + J,
                     A'First (2) - A'First (1) + I)) >
                 2.0 * Real'Epsilon * abs (A (I, J))
               then
                  raise Matrix_Data_Error with "not symmetric";
               end if;
            end if;
         end loop;
      end loop;

      for J in A'Range (2) loop
         for I in A'First (1) - A'First (2) + J .. A'Last (1) loop
            Sum := A (I, J);
            for K in A'First (2) .. J - 1 loop
               Sum := Sum - L (I, K) * L (A'First (1) - A'First (2) + J, K);
            end loop;
            if I = A'First (1) - A'First (2) + J then
               if Sum <= 0.0 then
                  raise Matrix_Data_Error with "not positive definite";
               end if;
               L (I, J) := Elementary_Functions.Sqrt (Sum);
            else
               L (I, J) := Sum / L (A'First (1) - A'First (2) + J, J);
            end if;
         end loop;
      end loop;
      return L;
   end Cholesky_Decomposition;

   function Cholesky_Solve
     (L : Real_Matrix;
      Y : Real_Vector) return Real_Vector
   is

    --      PURPOSE : SOLVE THE LINEAR SYSTEM OF EQUATIONS WITH REAL
    --                COEFFICIENTS   [A] * |X| = |Y| USING CHOLESKY
    --                DECOMPOSITION
    --
    --      INPUT  : THE REAL MATRIX  L  =  CHOLESKY_DECOMPOSITION ( A )
    --               THE REAL VECTOR  Y
    --
    --      OUTPUT : THE REAL VECTOR  X
    --
    --      METHOD : BACK SUBSTITUTION USING CHOLESKY DECOMPOSITION
    --
    --      USAGE  :  X := CHOLESKY_SOLVE ( CHOLESKY_DECOMPOSITION ( A ) , Y ) ;
    --
    --      EXCEPTION : ARRAY_INDEX_ERROR  RASIED IF 'A' NOT SQUARE OR
    --                                     Y LENGTH /= ROWS OF 'A'
    --                  MATRIX_DATA_ERROR  RAISED IF 'A' SINGULAR
    --
    --      WRITTEN BY : JON SQUIRE , 11/30/88

      X   : Real_Vector (Y'Range);
      W   : Real_Vector (Y'Range);
      Sum : Real;
   begin
      X (X'First) := 0.0; -- calm down "may be referenced before..." warning
      W (W'First) := 0.0; -- calm down "may be referenced before..." warning
    --
      for I in Y'Range loop -- solve  L * w = y
         Sum := Y (I);
         for K in Y'First .. I - 1 loop
            Sum :=
              Sum -
              L (L'First (1) - Y'First + I, L'First (2) - Y'First + K) * W (K);
         end loop;
         W (I) :=
           Sum / L (L'First (1) - Y'First + I, L'First (2) - Y'First + I);
      end loop;
                                  --         T
      for I in reverse Y'Range loop -- solve  L  * x = w
         Sum := W (I);
         for K in I + 1 .. Y'Last loop
            Sum :=
              Sum -
              L (L'First (1) - Y'First + K, L'First (2) - Y'First + I) * X (K);
         end loop;
         X (I) :=
           Sum / L (L'First (1) - Y'First + I, L'First (2) - Y'First + I);
      end loop;
      return X;
   end Cholesky_Solve;

   procedure Lu_Decomposition
     (A :        Real_Matrix;
      L : in out Real_Matrix;
      U : in out Real_Matrix;
      P : in out Integer_Vector)
   is

    --      PURPOSE : COMPUTE THE LU DECOMPOSITION OF MATRIX 'A'
    --                LU_SOLVE MAY THEN BE USED TO SOLVE LINEAR EQUATIONS
    --
    --      INPUT  : THE REAL MATRIX  A
    --
    --      OUTPUT : THE REAL MATRIX  L, LOWER TRIANGULAR
    --               THE REAL MATRIX  U, UPPER TRIANGULAR
    --               THE INTEGER VECTOR P, ROW PERMUTATION OF  A
    --
    --      METHOD : LU DECOMPOSITION  P APPLIED TO  A = L * U
    --               DIAGONAL OF L = 1.0
    --
    --      USAGE  : LU_DECOMPOSITION ( A , L, U, P ) ;
    --
    --      EXCEPTION : ARRAY_INDEX_ERROR  RASIED IF 'A' NOT SQUARE
    --                  MATRIX_DATA_ERROR  RAISED IF 'A' IS SINGULAR
    --

      Aa    : Real_Matrix (A'Range (1), A'Range (2)) := A;
      Itemp : Integer;
      Kk    : Integer;
      Temp  : Real;
      Big   : Real;
      Ofal1 : constant Integer := L'First (1) - A'First (1);
      Ofal2 : constant Integer := L'First (2) - A'First (2);
      Ofau1 : constant Integer := U'First (1) - A'First (1);
      Ofau2 : constant Integer := U'First (2) - A'First (2);
      Ofaa2 : constant Integer := A'First (2) - A'First (1);
      Ofap  : constant Integer                       := P'First - A'First (1);
   begin
      if A'Length (1) /= A'Length (2) or
        A'Length (1) /= L'Length (1) or
        A'Length (1) /= L'Length (2) or
        A'Length (1) /= U'Length (1) or
        A'Length (1) /= U'Length (2) or
        A'Length (1) /= P'Length
      then
         raise Array_Index_Error;
      end if;

      L := (others => (others => 0.0));
      U := (others => (others => 0.0));
      for I in A'Range (1) loop
         P (I + Ofap)             := I;
         L (I + Ofal1, I + Ofal2) := 1.0;
      end loop;
      for K in A'First (1) .. A'Last (1) - 1 loop
         Big := 0.0;
         for I in K .. A'Last (1) loop
            if abs Aa (I, K + Ofaa2) > Big then
               Big := abs Aa (I, K + Ofaa2);
               Kk  := I;
            end if;
         end loop;
         if Big = 0.0 then
            raise Matrix_Data_Error; -- singular
         end if;
         Itemp         := P (K + Ofap);
         P (K + Ofap)  := P (Kk + Ofap);
         P (Kk + Ofap) := Itemp;
         for I in A'Range (1) loop
            Temp               := Aa (K, I + Ofaa2);
            Aa (K, I + Ofaa2)  := Aa (Kk, I + Ofaa2);
            Aa (Kk, I + Ofaa2) := Temp;
         end loop;
         for I in K + 1 .. A'Last (1) loop
            Aa (I, K + Ofaa2) := Aa (I, K + Ofaa2) / Aa (K, K + Ofaa2);
            for J in K + 1 .. A'Last (1) loop
               Aa (I, J + Ofaa2) :=
                 Aa (I, J + Ofaa2) - Aa (I, K + Ofaa2) * Aa (K, J + Ofaa2);
            end loop;
         end loop;
      end loop;
      for I in A'Range (1) loop  -- copy from A to U
         for J in I .. A'Last (1) loop
            U (I + Ofau1, J + Ofau2) := Aa (I, J + Ofaa2);
         end loop;
      end loop;
      for I in A'First (1) + 1 .. A'Last (1) loop  -- copy from A to L
         for J in 1 .. I - 1 loop
            L (I + Ofal1, J + Ofal2) := Aa (I, J + Ofaa2);
         end loop;
      end loop;
   end Lu_Decomposition;

   function Lu_Solve
     (L : Real_Matrix;
      U : Real_Matrix;
      P : Integer_Vector;
      Y : Real_Vector) return Real_Vector
   is

    --      PURPOSE : SOLVE THE LINEAR SYSTEM OF EQUATIONS WITH REAL
    --                COEFFICIENTS   [A] * |X| = |Y| USING LU DECOMPOSITION
    --
    --      INPUT  : THE REAL MATRIX  L    \_ FROM LU_DECOMPOSITION
    --               THE REAL MATRIX  U     /
    --               THE INTEGER VECTOR P  /
    --               THE REAL VECTOR  Y
    --
    --      OUTPUT : THE REAL VECTOR  X
    --
    --      METHOD : BACK SUBSTITUTION USING LU DECOMPOSITION
    --
    --      USAGE  :  X := LU_SOLVE ( L, U, P, Y ) ;
    --
    --      EXCEPTION : ARRAY_INDEX_ERROR  RASIED IF 'L' AND 'U' DIFFERENT SIZE
    --                                     Y LENGTH /= ROWS OF 'L'
    --

      X     : Real_Vector (Y'Range);
      B     : Real_Vector (Y'Range);
      Sum   : Real;
      Ofyl1 : constant Integer := L'First (1) - Y'First;
      Ofyl2 : constant Integer := L'First (2) - Y'First;
      Ofyu1 : constant Integer := U'First (1) - Y'First;
      Ofyu2 : constant Integer := U'First (2) - Y'First;
   begin
      if L'Length (1) /= L'Length (2) or
        L'Length (1) /= U'Length (1) or
        L'Length (1) /= U'Length (2) or
        L'Length (1) /= P'Length or
        L'Length (1) /= Y'Length
      then
         raise Array_Index_Error;
      end if;
      B (B'First) := 0.0; -- calm down "may be referenced before..." warning
      X (X'First) := 0.0; -- calm down "may be referenced before..." warning

      for I in Y'Range loop
         Sum := 0.0;
         for J in Y'First .. I - 1 loop
            Sum := Sum + L (I + Ofyl1, J + Ofyl2) * B (J);
         end loop;
         B (I) := Y (P (I)) - Sum;
      end loop;

      for I in reverse Y'Range loop
         Sum := 0.0;
         for J in I + 1 .. Y'Last loop
            Sum := Sum + U (I + Ofyu1, J + Ofyu2) * X (J);
         end loop;
         X (I) := (B (I) - Sum) / U (I + Ofyu1, I + Ofyu2);
      end loop;
      return X;
   end Lu_Solve;

   procedure Qr_Decomposition
     (A :        Real_Matrix;
      Q : in out Real_Matrix;
      R : in out Real_Matrix)
   is

    --      PURPOSE : COMPUTE THE QR DECOMPOSITION OF MATRIX 'A'
    --                QR_SOLVE MAY THEN BE USED TO SOLVE LINEAR EQUATIONS
    --
    --      INPUT  : THE REAL MATRIX  A
    --
    --      OUTPUT : THE REAL MATRIX  Q
    --               THE REAL MATRIX  R
    --
    --      METHOD : QR DECOMPOSITION     A = Q * R    Q * TRANSPOSE(Q) = I
    --                                    R IS UPPER TRIANGULAR
    --                                    Q IS ORTHAGONAL
    --
    --      USAGE  : QR_DECOMPOSITION ( A , Q, R ) ;
    --
    --      EXCEPTION : ARRAY_INDEX_ERROR  RASIED IF 'A' NOT SQUARE OR
    --                                     'A', 'Q', AND 'R' NOT SAME SIZE
    --                  MATRIX_DATA_ERROR  RAISED IF 'A' IS SINGULAR
    --

      N : constant Integer := A'Length (1);     -- SIZE OF MATRIX
      Aa : Real_Matrix (1 .. N, 1 .. N);    -- WORKING MATRIX
      C                      : Real_Vector (1 .. N);
      D                      : Real_Vector (1 .. N);
      Scale, Sigma, Sum, Tau : Real;
      Ofaq1                  : constant Integer := Q'First (1) - 1;
      Ofaq2                  : constant Integer := Q'First (2) - 1;
      Ofar1                  : constant Integer := R'First (1) - 1;
      Ofar2                  : constant Integer := R'First (2) - 1;
   begin
      if N /= A'Length (2) or
        N /= R'Length (1) or
        N /= R'Length (2) or
        N /= Q'Length (1) or
        N /= Q'Length (2)
      then
         raise Array_Index_Error;
      end if;

      Aa    := A;
      Scale := 0.0;
      for K in 1 .. N - 1 loop
         for I in K .. N loop
            if Scale > abs Aa (I, K) then
               Scale := abs Aa (I, K);
            end if;
         end loop;
         if Scale = 0.0 then
            raise Matrix_Data_Error; -- matrix is singular
         else
            for I in K .. N loop
               Aa (I, K) := Aa (I, K) / Scale;
            end loop;
            Sum := 0.0;
            for I in K .. N loop
               Sum := Sum + Aa (I, K) * Aa (I, K);
            end loop;
            if Aa (K, K) < 0.0 then
               Sigma := -Elementary_Functions.Sqrt (Sum);
            else
               Sigma := Elementary_Functions.Sqrt (Sum);
            end if;
            Aa (K, K) := Aa (K, K) + Sigma;
            C (K)     := Sigma * Aa (K, K);
            D (K)     := -Scale * Sigma;
            for J in K + 1 .. N loop
               Sum := 0.0;
               for I in K .. N loop
                  Sum := Sum + Aa (I, K) * Aa (I, J);
               end loop;
               Tau := Sum / C (K);
               for I in K .. N loop
                  Aa (I, J) := Aa (I, J) - Tau * Aa (I, K);
               end loop;
            end loop;
         end if;
      end loop;
      D (N) := Aa (N, N);
      if D (N) = 0.0 then
         raise Matrix_Data_Error;
      end if;

    -- making R and Q
      for I in 1 .. N loop
         for J in 1 .. N loop
            Q (I + Ofaq1, J + Ofaq2) := 0.0;
            R (I + Ofar1, J + Ofar2) := 0.0;
            if I = J then
               R (I + Ofar1, I + Ofar2) := D (I);
            else
               R (I + Ofar1, J + Ofar2) := Aa (I, J);
            end if;
         end loop;
      end loop;
   end Qr_Decomposition;

   function Qr_Solve
     (Q : Real_Matrix;
      R : Real_Matrix;
      Y : Real_Vector) return Real_Vector
   is

    --      PURPOSE : SOLVE THE LINEAR SYSTEM OF EQUATIONS WITH REAL
    --                COEFFICIENTS   [A] * |X| = |Y| USING QR DECOMPOSITION
    --
    --      INPUT  : THE REAL MATRIX  Q    \_ FROM QR_DECOMPOSITION
    --               THE REAL MATRIX  R     /
    --               THE REAL VECTOR  Y
    --
    --      OUTPUT : THE REAL VECTOR  X
    --
    --      METHOD : BACK SUBSTITUTION USING LU DECOMPOSITION
    --
    --      USAGE  :  X := LU_SOLVE ( Q, R, Y ) ;
    --
    --      EXCEPTION : ARRAY_INDEX_ERROR  RASIED IF 'Q' AND 'R' DIFFERENT SIZE
    --                                     Y LENGTH /= ROWS OF 'Q'
    --

      X     : Real_Vector (Y'Range);
      Sum   : Real;
      Ofyq1 : constant Integer := Q'First (1) - Y'First;
      Ofyq2 : constant Integer := Q'First (2) - Y'First;
      Ofyr1 : constant Integer := R'First (1) - Y'First;
      Ofyr2 : constant Integer := R'First (2) - Y'First;
   begin
      if Y'Length /= R'Length (1) or
        Y'Length /= R'Length (2) or
        Y'Length /= Q'Length (1) or
        Y'Length /= Q'Length (2)
      then
         raise Array_Index_Error;
      end if;
      X (X'First) := 0.0; -- calm down "may be referenced before..." warning

      for I in reverse Y'Range loop
         Sum := 0.0;
         for K in Y'Range loop
            Sum := Sum + Q (K + Ofyq1, I + Ofyq2) * Y (I); -- TRANSPOSE(Q) * Y
         end loop;
         for J in I + 1 .. Y'Last loop
            Sum := Sum - X (J) * R (I + Ofyr1, J + Ofyr2);
         end loop;
         X (I) := Sum / R (I + Ofyr1, I + Ofyr2);
      end loop;
      return X;
   end Qr_Solve;

   procedure Sv_Decomposition
     (A  :        Real_Matrix;
      Uu : in out Real_Matrix;
      Vv : in out Real_Matrix;
      Ww : in out Real_Vector)
   is
      M : constant Integer             := A'Length (1);
      N : constant Integer             := A'Length (2);
      U : Real_Matrix (1 .. M, 1 .. N) := A;
      V : Real_Matrix (1 .. N, 1 .. N);
      W                                          : Real_Vector (1 .. N);
      Rv1                                        : Real_Vector (1 .. N);
      Its                                        : Integer := 0;
      L                                          : Integer := 0;
      L1                                         : Integer := 0;
      I                                          : Integer := 0;
      K                                          : Integer := 0;
      K1                                         : Integer := 0;
      Mn                                         : Integer := 0;
      C, F, G, H, S, X, Y, Z, Eps, Scale, Machep : Real;
    -- Ierr : Integer := 0;

      function Amax1 (A, B : Real) return Real is
      begin
         if A > B then
            return A;
         end if;
         return B;
      end Amax1;

      function Sign (Val, Sgn : Real) return Real is
      begin
         if Sgn < 0.0 then
            return -abs (Val);
         end if;
         return abs (Val);
      end Sign;
   begin
      if Uu'Length (1) /= M or
        Uu'Length (2) /= N or
        Vv'Length (1) /= N or
        Vv'Length (2) /= N or
        Ww'Length /= N
      then
         raise Array_Index_Error;
      end if;
      Machep := 2.0**(-23);
    --     HOUSEHOLDER REDUCTION TO BIDIAGONAL FORM
      G     := 0.0;
      Scale := 0.0;
      X     := 0.0;
      for I in 1 .. N loop -- 300
         L       := I + 1;
         Rv1 (I) := Scale * G;
         G       := 0.0;
         S       := 0.0;
         Scale   := 0.0;
         if I <= M then  -- 210
            for K in I .. M loop  -- 120
               Scale := Scale + abs (U (K, I));
            end loop;  -- 120
            if Scale /= 0.0 then  -- 210
               for K in I .. M loop  -- 130
                  U (K, I) := U (K, I) / Scale;
                  S        := S + U (K, I)**2;
               end loop;  -- 130
               F        := U (I, I);
               G        := -Sign (Elementary_Functions.Sqrt (S), F);
               H        := F * G - S;
               U (I, I) := F - G;
               if I /= N then  -- 190
                  for J in L .. N loop  -- 150
                     S := 0.0;
                     for K in I .. M loop  -- 140
                        S := S + U (K, I) * U (K, J);
                     end loop;  -- 140
                     F := S / H;
                     for K in I .. M loop  -- 150
                        U (K, J) := U (K, J) + F * U (K, I);
                     end loop;  -- 150
                  end loop;  -- 150
               end if;  -- 190
               for K in I .. M loop  -- 200
                  U (K, I) := Scale * U (K, I);
               end loop;  -- 200
            end if;  -- 210
         end if;  -- 210
         W (I) := Scale * G;
         G     := 0.0;
         S     := 0.0;
         Scale := 0.0;
      --IF (I > M .OR. I = N) GO TO 290
         if I <= M and I /= N then  -- 290
            for K in L .. N loop  -- 220
               Scale := Scale + abs (U (I, K));
            end loop;  -- 220
            if Scale /= 0.0 then  -- 290
               for K in L .. N loop  -- 230
                  U (I, K) := U (I, K) / Scale;
                  S        := S + U (I, K)**2;
               end loop;  -- 230
               F        := U (I, L);
               G        := -Sign (Elementary_Functions.Sqrt (S), F);
               H        := F * G - S;
               U (I, L) := F - G;
               for K in L .. N loop  -- 240
                  Rv1 (K) := U (I, K) / H;
               end loop;  -- 240
               if I /= M then  -- 270
                  for J in L .. M loop  -- 260
                     S := 0.0;
                     for K in L .. N loop  -- 250
                        S := S + U (J, K) * U (I, K);
                     end loop;  -- 250
                     for K in L .. N loop  -- 260
                        U (J, K) := U (J, K) + S * Rv1 (K);
                     end loop;  -- 260
                  end loop;  -- 260
               end if;  -- 270
               for K in L .. N loop  -- 280
                  U (I, K) := Scale * U (I, K);
               end loop;  -- 280
            end if;  -- 290
         end if;  -- 290
         X := Amax1 (X, abs (W (I)) + abs (Rv1 (I)));
      end loop;  -- 300
    -- ACCUMULATION OF RIGHT-HAND TRANSFORMATIONS
    -- FOR I:=N STEP -1 UNTIL 1 DO
      for Ii in 1 .. N loop  -- 400
         I := N + 1 - Ii;
         if I /= N then  -- 390
            if G /= 0.0 then  -- 360
               for J in L .. N loop  -- 320
          -- DOUBLE DIVISION AVOIDS POSSIBLE UNDERFLOW
                  V (J, I) := (U (I, J) / U (I, L)) / G;
               end loop;  -- 320
               for J in L .. N loop  -- 350
                  S := 0.0;
                  for K in L .. N loop  -- 340
                     S := S + U (I, K) * V (K, J);
                  end loop;  -- 340
                  for K in L .. N loop  -- 350
                     V (K, J) := V (K, J) + S * V (K, I);
                  end loop;  -- 350
               end loop;  -- 350
            end if;  -- 360
            for J in L .. N loop  -- 380
               V (I, J) := 0.0;
               V (J, I) := 0.0;
            end loop;  -- 380
         end if;  -- 390
         V (I, I) := 1.0;
         G        := Rv1 (I);
         L        := I;
      end loop;  -- 400
    -- ACCUMULATION OF LEFT-HAND TRANSFORMATIONS
    -- FOR I:=MIN(M,N) STEP -1 UNTIL 1 DO
      Mn := N;
      if M < N then
         Mn := M;
      end if;
      for Ii in 1 .. Mn loop
      -- 500
         I := Mn + 1 - Ii;
         L := I + 1;
         G := W (I);
         if I /= N then  -- 430
            for J in L .. N loop
          -- 420
               U (I, J) := 0.0;
            end loop;  -- 420
         end if;  -- 430
         if G /= 0.0 then  -- 475
            if I /= Mn then  -- 460
               for J in L .. N loop  -- 450
                  S := 0.0;
                  for K in L .. M loop  -- 440
                     S := S + U (K, I) * U (K, J);
                  end loop;  -- 440
            -- DOUBLE DIVISION AVOIDS POSSIBLE UNDERFLOW
                  F := (S / U (I, I)) / G;
                  for K in I .. M loop  -- 450
                     U (K, J) := U (K, J) + F * U (K, I);
                  end loop;  -- 450
               end loop;  -- 450
            end if;  -- 460
            for J in I .. M loop
          -- 470
               U (J, I) := U (J, I) / G;
            end loop;  -- 470
         else  -- 475
            for J in I .. M loop  -- 480
               U (J, I) := 0.0;
            end loop;  -- 480
         end if;  -- 475
         U (I, I) := U (I, I) + 1.0;
      end loop;  -- 500
    -- DIAGONALIZATION OF THE BIDIAGONAL FORM
      Eps := Machep * X;
    -- FOR K:=N STEP -1 UNTIL 1 DO
      for Kk in 1 .. N loop  -- 700
         K1  := N - Kk;
         K   := K1 + 1;
         Its := 0;
      -- TEST FOR SPLITTING.
      -- FOR L:=K STEP -1 UNTIL 1 DO
         loop  -- 520
            for Ll in 1 .. K loop  -- 530
               L1 := K - Ll;
               L  := L1 + 1;
               if abs (Rv1 (L)) <= Eps then
                  goto L565;
               end if;
          -- RV1(1) IS ALWAYS ZERO, SO THERE IS NO EXIT
          -- THROUGH THE BOTTOM OF THE LOOP
               if (abs W (L1)) <= Eps then
                  exit;  -- GO TO 540
               end if;
            end loop;
        -- 530
        --  CANCELLATION OF RV1(L) IF L GREATER THAN 1
        --540
            C := 0.0;
            S := 1.0;
            for I in L .. K loop  -- 560
               F       := S * Rv1 (I);
               Rv1 (I) := C * Rv1 (I);
               if abs (F) <= Eps then
                  exit;  -- GO TO 565
               end if;
               G     := W (I);
               H     := Elementary_Functions.Sqrt (F * F + G * G);
               W (I) := H;
               C     := G / H;
               S     := -F / H;
               for J in 1 .. M loop  -- 550
                  Y         := U (J, L1);
                  Z         := U (J, I);
                  U (J, L1) := Y * C + Z * S;
                  U (J, I)  := -Y * S + Z * C;
               end loop;  -- 550
            end loop;  -- 560
         -- TEST FOR CONVERGENCE
            <<L565>>
            Z := W (K);
            if L = K then
               goto L650;
            end if;
         -- SHIFT FROM BOTTOM 2 BY 2 MINOR
            if Its = 30 then
           -- SET ERROR, NO CONVERGENCE TO A SINGULAR VALUE AFTER 30 ITERATIONS
          -- Ierr := K;
               raise Matrix_Data_Error with "No SV convergence";
            end if;
            Its := Its + 1;
            X   := W (L);
            Y   := W (K1);
            G   := Rv1 (K1);
            H   := Rv1 (K);
            F   := ((Y - Z) * (Y + Z) + (G - H) * (G + H)) / (2.0 * H * Y);
            G   := Elementary_Functions.Sqrt (F * F + 1.0);
            F   := ((X - Z) * (X + Z) + H * (Y / (F + Sign (G, F)) - H)) / X;
        -- NEXT QR TRANSFORMATION
            C := 1.0;
            S := 1.0;
            for I1 in L .. K1 loop  -- 600
               I        := I1 + 1;
               G        := Rv1 (I);
               Y        := W (I);
               H        := S * G;
               G        := C * G;
               Z        := Elementary_Functions.Sqrt (F * F + H * H);
               Rv1 (I1) := Z;
               C        := F / Z;
               S        := H / Z;
               F        := X * C + G * S;
               G        := -X * S + G * C;
               H        := Y * S;
               Y        := Y * C;
               for J in 1 .. N loop  -- 570
                  X         := V (J, I1);
                  Z         := V (J, I);
                  V (J, I1) := X * C + Z * S;
                  V (J, I)  := -X * S + Z * C;
               end loop;  -- 570
               Z      := Elementary_Functions.Sqrt (F * F + H * H);
               W (I1) := Z;
           -- ROTATION CAN BE ARBITRARY IF Z IS ZERO
               if Z /= 0.0 then  -- 580
                  C := F / Z;
                  S := H / Z;
               end if;  -- 580
               F := C * G + S * Y;
               X := -S * G + C * Y;
               for J in 1 .. M loop  -- 590
                  Y         := U (J, I1);
                  Z         := U (J, I);
                  U (J, I1) := Y * C + Z * S;
                  U (J, I)  := -Y * S + Z * C;
               end loop;  -- 590
            end loop;  -- 600
            Rv1 (L) := 0.0;
            Rv1 (K) := F;
            W (K)   := X;
         end loop;  -- 520
       -- CONVERGENCE
         <<L650>>
         if Z < 0.0 then
        -- W(K) IS MADE NON-NEGATIVE
            W (K) := -Z;
            for J in 1 .. N loop
               V (J, K) := -V (J, K);
            end loop;
         end if;
      end loop;  -- 700
      Ww := W;
      Uu := U;
      Vv := V;
   end Sv_Decomposition;

   function Sv_Solve
     (U : Real_Matrix;
      V : Real_Matrix;
      W : Real_Vector;
      Y : Real_Vector) return Real_Vector
   is
      M   : constant Integer := U'Length (1);
      N   : constant Integer := U'Length (2);
      S   : Real;
      X   : Real_Vector (1 .. N);
      Tmp : Real_Vector (1 .. N);
   begin
      if V'Length (1) /= N or
        V'Length (2) /= N or
        W'Length /= N or
        Y'Length /= N
      then
         raise Array_Index_Error;
      end if;
      for J in 1 .. N loop
         S := 0.0;
         if W (J - 1 + W'First) /= 0.0 then
            for I in 1 .. M loop
               S :=
                 S +
                 U (I - 1 + U'First (1), J - 1 + U'First (2)) *
                   Y (I - 1 + Y'First);
            end loop;
            S := S / W (J - 1 + W'First);
         end if;
         Tmp (J) := S;
      end loop;
      for J in 1 .. N loop
         S := 0.0;
         for Jj in 1 .. N loop
            S := S + V (J - 1 + V'First (1), Jj - 1 + V'First (2)) * Tmp (Jj);
         end loop;
         X (J) := S;
      end loop;
      return X;
   end Sv_Solve;

end Generic_Real_Linear_Equations;
