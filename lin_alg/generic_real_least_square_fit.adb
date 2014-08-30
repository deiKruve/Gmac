--
with Text_IO; use Text_IO;  -- only needed for testing

package body Generic_Real_Least_Square_Fit is

--
-- The mathmatical derivation of the least square fit is as follows :
--
-- Given data for the independent variable Y in terms of the dependent
-- variables S,T,U and V  consider that there exists a function F
-- such that     Y = F(S,T,U,V)
-- The problem is to find coefficients A,B,C and D such that
--            Y_approximate = A * S + B * T + C * U + D * V
-- and such that the sum of ( Y - Y_approximate ) squared is minimized.
--
-- To find the minimum of  SUM( Y - Y_approximate ) ** 2
-- the derivitives must be taken with respect to S,T,U and V and
-- all must equal zero simultaneously. The steps follow :
--
--  SUM( Y - Y_approximate ) ** 2 = SUM( Y - A*S - B*T - C*U - D*V ) ** 2
--
-- d/dS =  -2 * S * SUM( Y - A*S - B*T - C*U - D*V )
-- d/dT =  -2 * T * SUM( Y - A*S - B*T - C*U - D*V )
-- d/dU =  -2 * U * SUM( Y - A*S - B*T - C*U - D*V )
-- d/dV =  -2 * V * SUM( Y - A*S - B*T - C*U - D*V )
--
-- Setting each of the above equal to zero and putting constant term on left
--    the -2 is factored out,
--    the independent variable is moved inside the summation
--
--  SUM( A*S*S + B*S*T + C*S*U + D*S*V = S*Y )
--  SUM( A*T*S + B*T*T + C*T*U + D*T*V = T*Y )
--  SUM( A*U*S + B*U*T + C*U*U + D*U*V = U*Y )
--  SUM( A*V*S + B*V*T + C*V*U + D*V*V = V*Y )
--
-- Distributing the SUM inside yeilds
--
--  A * SUM(S*S) + B * SUM(S*T) + C * SUM(S*U) + D * SUM(S*V) = SUM(S*Y)
--  A * SUM(T*S) + B * SUM(T*T) + C * SUM(T*U) + D * SUM(T*V) = SUM(T*Y)
--  A * SUM(U*S) + B * SUM(U*T) + C * SUM(U*U) + D * SUM(U*V) = SUM(U*Y)
--  A * SUM(V*S) + B * SUM(V*T) + C * SUM(V*U) + D * SUM(V*V) = SUM(V*Y)
--
-- To find the coefficients A,B,C and D solve the linear system of equations
--
--    | SUM(S*S)  SUM(S*T)  SUM(S*U)  SUM(S*V) |   | A |   | SUM(S*Y) |
--    | SUM(T*S)  SUM(T*T)  SUM(T*U)  SUM(T*V) | x | B | = | SUM(T*Y) |
--    | SUM(U*S)  SUM(U*T)  SUM(U*U)  SUM(U*V) |   | C |   | SUM(U*Y) |
--    | SUM(V*S)  SUM(V*T)  SUM(V*U)  SUM(V*V) |   | D |   | SUM(V*Y) |
--
-- Some observations :
--     S,T,U and V must be linearly independent
--     The analysis did not depend on the number of independent variables
--     A polynomial fit results from the substitutions S=1, T=X, U=X**2, V=X**3
--     The general case for any order polynomial follows.
--     Any substitiution such as just using odd powers of X follow.
--     The "Y" vector can be expanded to a matrix yeilding a matrix
--         of coefficients
--

   procedure Vector_To_Row
     (V   :        Gra.Real_Vector;
      Row :        Integer;
      A   : in out Gra.Real_Matrix)
   is
   begin
      if V'Length /= A'Length (2) or Row < A'First (1) or Row > A'Last (1) then
         raise Array_Index_Error;
      end if;
      for J in A'Range (2) loop
         A (Row, J) := V (J - A'First (2) + V'First);
      end loop;
   end Vector_To_Row;
   
   
   --                Y = C * X
   procedure Fit (Y, X : Gra.Real_Vector; C : out Real) 
   is
      Sum_X_X : Real := 0.0;
      Sum_X_Y : Real := 0.0;
   begin
      if X'Length /= Y'Length then
         raise Constraint_Error;
      end if;
      if X'Length < 1 then
         raise Constraint_Error;
      end if;
      for I in X'Range loop
         Sum_X_X := Sum_X_X + X (I) * X (I);
         Sum_X_Y := Sum_X_Y + X (I) * Y (I - X'First + Y'First);
      end loop;

-- No need to test  abs(SUM_X_X) = 0.0 and raise numeric error, it happens
      C := Sum_X_Y / Sum_X_X;
   end Fit;
   
   
   --                Y = C1 * X1 + C2 * X2
   procedure Fit (Y, X1, X2 : Gra.Real_Vector; C1, C2 : out Real) 
   is
      M : Gra.Real_Matrix (0 .. 1, 0 .. 1) := (0 .. 1 => (0 .. 1 => 0.0));
      V       : Gra.Real_Vector (0 .. 1)         := (0 .. 1 => 0.0);
      C       : Gra.Real_Vector (0 .. 1);
      Bias_X1 : constant Integer                 := Y'First - X1'First;
      Bias_X2 : constant Integer                 := Y'First - X2'First;
   begin
      if X1'Length /= X2'Length or X2'Length /= Y'Length then
         raise Constraint_Error;
      end if;
      if Y'Length < 2 then
         raise Constraint_Error;
      end if;
      for I in Y'Range loop
         M (0, 0) := M (0, 0) + X1 (I - Bias_X1) * X1 (I - Bias_X1);
         M (0, 1) := M (0, 1) + X1 (I - Bias_X1) * X2 (I - Bias_X2);
         M (1, 0) := M (1, 0) + X2 (I - Bias_X2) * X1 (I - Bias_X1);
         M (1, 1) := M (1, 1) + X2 (I - Bias_X2) * X2 (I - Bias_X2);
         V (0)    := V (0) + X1 (I - Bias_X1) * Y (I);
         V (1)    := V (1) + X2 (I - Bias_X2) * Y (I);
      end loop;
      C  := Gra.Solve (M, V);
      C1 := C (0);
      C2 := C (1);
   end Fit;

   --                Y = C1 * X1 + C2 * X2 + C3 * X3
   procedure Fit (Y, X1, X2, X3 : Gra.Real_Vector; C1, C2, C3 : out Real) 
   is
      M : Gra.Real_Matrix (0 .. 2, 0 .. 2) := (0 .. 2 => (0 .. 2 => 0.0));
      V       : Gra.Real_Vector (0 .. 2)         := (0 .. 2 => 0.0);
      C       : Gra.Real_Vector (0 .. 2);
      Bias_X1 : constant Integer                 := Y'First - X1'First;
      Bias_X2 : constant Integer                 := Y'First - X2'First;
      Bias_X3 : constant Integer                 := Y'First - X3'First;
   begin
      if X1'Length /= X2'Length or
        X2'Length /= X3'Length or
        X3'Length /= Y'Length
      then
         raise Constraint_Error;
      end if;
      if Y'Length < 3 then
         raise Constraint_Error;
      end if;
      for I in Y'Range loop
         M (0, 0) := M (0, 0) + X1 (I - Bias_X1) * X1 (I - Bias_X1);
         M (0, 1) := M (0, 1) + X1 (I - Bias_X1) * X2 (I - Bias_X2);
         M (0, 2) := M (0, 2) + X1 (I - Bias_X1) * X3 (I - Bias_X3);
         M (1, 0) := M (1, 0) + X2 (I - Bias_X2) * X1 (I - Bias_X1);
         M (1, 1) := M (1, 1) + X2 (I - Bias_X2) * X2 (I - Bias_X2);
         M (1, 2) := M (1, 2) + X2 (I - Bias_X2) * X3 (I - Bias_X3);
         M (2, 0) := M (2, 0) + X3 (I - Bias_X3) * X1 (I - Bias_X1);
         M (2, 1) := M (2, 1) + X3 (I - Bias_X3) * X2 (I - Bias_X2);
         M (2, 2) := M (2, 2) + X3 (I - Bias_X3) * X3 (I - Bias_X3);
         V (0)    := V (0) + X1 (I - Bias_X1) * Y (I);
         V (1)    := V (1) + X2 (I - Bias_X2) * Y (I);
         V (2)    := V (2) + X3 (I - Bias_X3) * Y (I);
      end loop;
      C  := Gra.Solve (M, V);
      C1 := C (0);
      C2 := C (1);
      C3 := C (2);
   end Fit;
   
   
   --                Y = C1 * X1 + C2 * X2 + C3 * X3 + C4 * X4
   procedure Fit
     (Y, X1, X2, X3, X4 :     Gra.Real_Vector;
      C1, C2, C3, C4    : out Real)
   is

      N       : constant Integer                 := 3;
      M : Gra.Real_Matrix (0 .. N, 0 .. N) := (0 .. N => (0 .. N => 0.0));
      V       : Gra.Real_Vector (0 .. N)         := (0 .. N => 0.0);
      C       : Gra.Real_Vector (0 .. N);
      X_Power : Gra.Real_Vector (0 .. N);
      Bias_X1 : constant Integer                 := Y'First - X1'First;
      Bias_X2 : constant Integer                 := Y'First - X2'First;
      Bias_X3 : constant Integer                 := Y'First - X3'First;
      Bias_X4 : constant Integer                 := Y'First - X4'First;
   begin
      if X1'Length /= X2'Length or
        X2'Length /= X3'Length or
        X3'Length /= X4'Length or
        X4'Length /= Y'Length
      then
         raise Constraint_Error;
      end if;
      if Y'Length < 4 then
         raise Constraint_Error;
      end if;
      for K in Y'Range loop
         X_Power (0) := X1 (K - Bias_X1);
         X_Power (1) := X2 (K - Bias_X2);
         X_Power (2) := X3 (K - Bias_X3);
         X_Power (3) := X4 (K - Bias_X4);
         for I in 0 .. N loop
            for J in 0 .. N loop
               M (I, J) := M (I, J) + X_Power (I) * X_Power (J);
            end loop;
            V (I) := V (I) + Y (K) * X_Power (I);
         end loop;
      end loop;
      C  := Gra.Solve (M, V);
      C1 := C (0);
      C2 := C (1);
      C3 := C (2);
      C4 := C (3);
   end Fit;
   
   
   --                Y = EVALUATE ( C , X )
   --                Y = C(0) + C(1)*X + C(2)*X**2 + C(3)*X**3 + ...
   --                    to  C(C'LAST)*X**C'LAST
   procedure Fit (Y, X : Gra.Real_Vector; C : out Real_Polynomial) 
   is
      N       : constant Integer                 := C'Length - 1;
      M : Gra.Real_Matrix (0 .. N, 0 .. N) := (0 .. N => (0 .. N => 0.0));
      V       : Gra.Real_Vector (0 .. N)         := (0 .. N => 0.0);
      X_Power : Gra.Real_Vector (0 .. 2 * N);
      Bias    : constant Integer                 := X'First - Y'First;
   begin
      if X'Length /= Y'Length then
         raise Constraint_Error;
      end if;
      if X'Length < C'Length then
         raise Constraint_Error;
      end if;
      X_Power (0) := 1.0;
      for K in X'Range loop
         for I in 1 .. 2 * N loop
            X_Power (I) := X_Power (I - 1) * X (K);
         end loop;
         for I in 0 .. N loop
            for J in 0 .. N loop
               M (I, J) := M (I, J) + X_Power (I + J);
            end loop;
            V (I) := V (I) + Y (K - Bias) * X_Power (I);
         end loop;
      end loop;
      V := Gra.Solve (M, V);
      for I in V'Range loop
         C (I) := V (I);
      end loop;
   end Fit;
   
   
   --                Y = C11 * X1 + C12 * X1**2 + C21 * X2 + C22 * X2**2
   procedure Fit
     (Y, X1, X2          :     Gra.Real_Vector;
      C11, C12, C21, C22 : out Real)
   is
      M : Gra.Real_Matrix (0 .. 3, 0 .. 3) := (0 .. 3 => (0 .. 3 => 0.0));
      V       : Gra.Real_Vector (0 .. 3)         := (0 .. 3 => 0.0);
      X_Power : Gra.Real_Vector (0 .. 3);
      C       : Gra.Real_Vector (0 .. 3);
      Bias_X1 : constant Integer                 := Y'First - X1'First;
      Bias_X2 : constant Integer                 := Y'First - X2'First;
   begin
      if X1'Length /= X2'Length or X2'Length /= Y'Length then
         raise Constraint_Error;
      end if;
      if Y'Length < 4 then
         raise Constraint_Error;
      end if;
      for K in Y'Range loop
         X_Power (0) := X1 (K - Bias_X1);
         X_Power (1) := X_Power (0)**2;
         X_Power (2) := X2 (K - Bias_X2);
         X_Power (3) := X_Power (2)**2;
         for I in 0 .. 3 loop
            for J in 0 .. 3 loop
               M (I, J) := M (I, J) + X_Power (I) * X_Power (J);
            end loop;
            V (I) := V (I) + X_Power (I) * Y (K);
         end loop;
      end loop;
      C   := Gra.Solve (M, V);
      C11 := C (0);
      C12 := C (1);
      C21 := C (2);
      C22 := C (3);
   end Fit;
   
   
   --                Y = C11 * X1 + C12 * X1**2 +
   --                    C21 * X2 + C22 * X2**2 +
   --                    C31 * X3 + C32 * X3**2
   procedure Fit
     (Y, X1, X2, X3                :     Gra.Real_Vector;
      C11, C12, C21, C22, C31, C32 : out Real)
   is
      M : Gra.Real_Matrix (0 .. 5, 0 .. 5) := (0 .. 5 => (0 .. 5 => 0.0));
      V       : Gra.Real_Vector (0 .. 5)         := (0 .. 5 => 0.0);
      X_Power : Gra.Real_Vector (0 .. 5);
      C       : Gra.Real_Vector (0 .. 5);
      Bias_X1 : constant Integer                 := Y'First - X1'First;
      Bias_X2 : constant Integer                 := Y'First - X2'First;
      Bias_X3 : constant Integer                 := Y'First - X3'First;
   begin
      if X1'Length /= X2'Length or
        X2'Length /= X3'Length or
        X3'Length /= Y'Length
      then
         raise Constraint_Error;
      end if;
      if Y'Length < 6 then
         raise Constraint_Error;
      end if;
      for K in Y'Range loop
         X_Power (0) := X1 (K - Bias_X1);
         X_Power (1) := X_Power (0)**2;
         X_Power (2) := X2 (K - Bias_X2);
         X_Power (3) := X_Power (2)**2;
         X_Power (4) := X3 (K - Bias_X3);
         X_Power (5) := X_Power (4)**2;
         for I in M'Range (1) loop
            for J in M'Range (2) loop
               M (I, J) := M (I, J) + X_Power (I) * X_Power (J);
            end loop;
            V (I) := V (I) + X_Power (I) * Y (K);
         end loop;
      end loop;
      C   := Gra.Solve (M, V);
      C11 := C (0);
      C12 := C (1);
      C21 := C (2);
      C22 := C (3);
      C31 := C (4);
      C32 := C (5);
   end Fit;
   
   
   --                Y = C11 * X1 + C12 * X1**2 + C13 * X1**3 +
   --                    C21 * X2 + C22 * X2**2 + C23 * X2**3
   procedure Fit
     (Y, X1, X2                    :     Gra.Real_Vector;
      C11, C12, C13, C21, C22, C23 : out Real)
   is
      M : Gra.Real_Matrix (0 .. 5, 0 .. 5) := (0 .. 5 => (0 .. 5 => 0.0));
      V       : Gra.Real_Vector (0 .. 5)         := (0 .. 5 => 0.0);
      X_Power : Gra.Real_Vector (0 .. 5);
      C       : Gra.Real_Vector (0 .. 5);
      Bias_X1 : constant Integer                 := Y'First - X1'First;
      Bias_X2 : constant Integer                 := Y'First - X2'First;
   begin
      if X1'Length /= X2'Length or X2'Length /= Y'Length then
         raise Constraint_Error;
      end if;
      if Y'Length < 6 then
         raise Constraint_Error;
      end if;
      for K in Y'Range loop
         X_Power (0) := X1 (K - Bias_X1);
         X_Power (1) := X_Power (0)**2;
         X_Power (2) := X_Power (0)**3;
         X_Power (3) := X2 (K - Bias_X2);
         X_Power (4) := X_Power (3)**2;
         X_Power (5) := X_Power (3)**3;
         for I in M'Range (1) loop
            for J in M'Range (2) loop
               M (I, J) := M (I, J) + X_Power (I) * X_Power (J);
            end loop;
            V (I) := V (I) + X_Power (I) * Y (K);
         end loop;
      end loop;
      C   := Gra.Solve (M, V);
      C11 := C (0);
      C12 := C (1);
      C13 := C (2);
      C21 := C (3);
      C22 := C (4);
      C23 := C (5);
   end Fit;
   
   
   --                Y = C(1,1)*X1 + C(1,2)*X1**2 + C(1,3)*X1**3 + ...
   --                    to  C(1,C'LAST)*X1**C'LAST + ...
   --                    C(2,1)*X2 + C(2,2)*X2**2 + C(2,3)*X2**3 + ...
   --                    to  C(2,C'LAST)*X2**C'LAST
   procedure Fit (Y, X1, X2 : Gra.Real_Vector; C : in out Gra.Real_Matrix) 
   is
      N       : constant Integer                   := C'Length (2) - 1;
      N2      : constant Integer                   := 2 * N + 1;
      M : Gra.Real_Matrix (0 .. N2, 0 .. N2) := (0 .. N2 => (0 .. N2 => 0.0));
      V       : Gra.Real_Vector (0 .. N2)          := (0 .. N2 => 0.0);
      C_Vec   : Gra.Real_Vector (0 .. N2);
      X_Power : Gra.Real_Vector (0 .. N2);
      Bias_X1 : constant Integer                   := Y'First - X1'First;
      Bias_X2 : constant Integer                   := Y'First - X2'First;
   begin
      if X1'Length /= X2'Length or X2'Length /= Y'Length then
         raise Constraint_Error;
      end if;
      if C'Length (1) /= 2 then
         raise Constraint_Error;
      end if;
      if Y'Length < 2 * C'Length (2) then
         raise Constraint_Error;
      end if;
      for K in Y'Range loop
         X_Power (0)     := X1 (K - Bias_X1);
         X_Power (N + 1) := X2 (K - Bias_X2);
         for I in 1 .. N loop
            X_Power (I)         := X_Power (I - 1) * X_Power (0);
            X_Power (I + N + 1) := X_Power (I + N) * X_Power (N + 1);
         end loop;
         for I in M'Range (1) loop
            for J in M'Range (2) loop
               M (I, J) := M (I, J) + X_Power (I) * X_Power (J);
            end loop;
            V (I) := V (I) + X_Power (I) * Y (K);
         end loop;
      end loop;
      C_Vec := Gra.Solve (M, V);
      Vector_To_Row (C_Vec (0 .. N), C'First (1), C);
      Vector_To_Row (C_Vec (N + 1 .. N2), C'Last (1), C);
   end Fit;
   
   
   --                Y = C(1,1)*X1 + C(1,2)*X1**2 + C(1,3)*X1**3 + ...
   --                    to  C(1,C'LAST)*X1**C'LAST + ...
   --                    C(2,1)*X2 + C(2,2)*X2**2 + C(2,3)*X2**3 + ...
   --                    to  C(2,C'LAST)*X2**C'LAST + ...
   --                    C(3,1)*X3 + C(3,2)*X3**2 + C(3,3)*X3**3 + ...
   --                    to  C(3,C'LAST)*X3**C'LAST
   procedure Fit
     (Y, X1, X2, X3 :        Gra.Real_Vector;
      C             : in out Gra.Real_Matrix)
   is
      N       : constant Integer                   := C'Length (2) - 1;
      N2      : constant Integer                   := 3 * N + 2;
      M : Gra.Real_Matrix (0 .. N2, 0 .. N2) := (0 .. N2 => (0 .. N2 => 0.0));
      V       : Gra.Real_Vector (0 .. N2)          := (0 .. N2 => 0.0);
      C_Vec   : Gra.Real_Vector (0 .. N2);
      X_Power : Gra.Real_Vector (0 .. N2);
      Bias_X1 : constant Integer                   := Y'First - X1'First;
      Bias_X2 : constant Integer                   := Y'First - X2'First;
      Bias_X3 : constant Integer                   := Y'First - X3'First;
   begin
      if X1'Length /= X2'Length or
        X2'Length /= X3'Length or
        X3'Length /= Y'Length
      then
         raise Constraint_Error;
      end if;
      if C'Length (1) /= 3 then
         raise Constraint_Error;
      end if;
      if Y'Length < 3 * C'Length (2) then
         raise Constraint_Error;
      end if;

      for K in Y'Range loop
         X_Power (0)         := X1 (K - Bias_X1);
         X_Power (N + 1)     := X2 (K - Bias_X2);
         X_Power (2 * N + 2) := X3 (K - Bias_X3);
         for I in 1 .. N loop
            X_Power (I)             := X_Power (I - 1) * X_Power (0);
            X_Power (I + N + 1)     := X_Power (I + N) * X_Power (N + 1);
            X_Power (I + 2 * N + 2) :=
              X_Power (I + 2 * N + 1) * X_Power (2 * N + 2);
         end loop;
         for I in 0 .. N2 loop
            for J in 0 .. N2 loop
               M (I, J) := M (I, J) + X_Power (I) * X_Power (J);
            end loop;
            V (I) := V (I) + X_Power (I) * Y (K);
         end loop;
      end loop;
      C_Vec := Gra.Solve (M, V);
      Vector_To_Row (C_Vec (0 .. N), C'First (1), C);
      Vector_To_Row (C_Vec (N + 1 .. 2 * N + 1), C'First (1) + 1, C);
      Vector_To_Row (C_Vec (2 * N + 2 .. N2), C'First (1) + 2, C);
   end Fit;
   
   
   --                Y = C(1,1)*X1 + C(1,2)*X1**2 + C(1,3)*X1**3 + ...
   --                    to  C(1,C'LAST)*X1**C'LAST + ...
   --                    C(2,1)*X2 + C(2,2)*X2**2 + C(2,3)*X2**3 + ...
   --                    to  C(2,C'LAST)*X2**C'LAST + ...
   --                    C(3,1)*X3 + C(3,2)*X3**2 + C(3,3)*X3**3 + ...
   --                    to  C(3,C'LAST)*X3**C'LAST + ...
   --                    C(4,1)*X4 + C(4,2)*X4**2 + C(4,3)*X3**3 + ...
   --                    to  C(4,C'LAST)*X4**C'LAST
   procedure Fit
     (Y, X1, X2, X3, X4 :        Gra.Real_Vector;
      C                 : in out Gra.Real_Matrix)
   is
      N       : constant Integer                   := C'Length (2) - 1;
      N2      : constant Integer                   := 4 * N + 3;
      M : Gra.Real_Matrix (0 .. N2, 0 .. N2) := (0 .. N2 => (0 .. N2 => 0.0));
      V       : Gra.Real_Vector (0 .. N2)          := (0 .. N2 => 0.0);
      C_Vec   : Gra.Real_Vector (0 .. N2);
      X_Power : Gra.Real_Vector (0 .. N2);
      Bias_X1 : constant Integer                   := Y'First - X1'First;
      Bias_X2 : constant Integer                   := Y'First - X2'First;
      Bias_X3 : constant Integer                   := Y'First - X3'First;
      Bias_X4 : constant Integer                   := Y'First - X4'First;
   begin
      if X1'Length /= X2'Length or
        X2'Length /= X3'Length or
        X3'Length /= X4'Length or
        X4'Length /= Y'Length
      then
         raise Constraint_Error;
      end if;
      if C'Length (1) /= 4 then
         raise Constraint_Error;
      end if;
      if Y'Length < 4 * C'Length (2) then
         raise Constraint_Error;
      end if;

      for K in Y'Range loop
         X_Power (0)         := X1 (K - Bias_X1);
         X_Power (N + 1)     := X2 (K - Bias_X2);
         X_Power (2 * N + 2) := X3 (K - Bias_X3);
         X_Power (3 * N + 3) := X4 (K - Bias_X4);
         for I in 1 .. N loop
            X_Power (I)             := X_Power (I - 1) * X_Power (0);
            X_Power (I + N + 1)     := X_Power (I + N) * X_Power (N + 1);
            X_Power (I + 2 * N + 2) :=
              X_Power (I + 2 * N + 1) * X_Power (2 * N + 2);
            X_Power (I + 3 * N + 3) :=
              X_Power (I + 3 * N + 2) * X_Power (3 * N + 3);
         end loop;
         for I in 0 .. N2 loop
            for J in 0 .. N2 loop
               M (I, J) := M (I, J) + X_Power (I) * X_Power (J);
            end loop;
            V (I) := V (I) + X_Power (I) * Y (K);
         end loop;
      end loop;
      C_Vec := Gra.Solve (M, V);
      Vector_To_Row (C_Vec (0 .. N), C'First (1), C);
      Vector_To_Row (C_Vec (N + 1 .. 2 * N + 1), C'First (1) + 1, C);
      Vector_To_Row (C_Vec (2 * N + 2 .. 3 * N + 2), C'First (1) + 2, C);
      Vector_To_Row (C_Vec (3 * N + 3 .. N2), C'First (1) + 3, C);
   end Fit;
   
   
   --                Y(K) = C(I,J) * X(I,K) ** J  summed over I in C'RANGE(1)
   --                                             over J in C'RANGE(2)
   procedure Fit
     (Y :        Gra.Real_Vector;
      X :        Gra.Real_Matrix;
      C : in out Gra.Real_Matrix)
   is
      N       : constant Integer := C'Length (1) * C'Length (2) - 1;
      M : Gra.Real_Matrix (0 .. N, 0 .. N) := (0 .. N => (0 .. N => 0.0));
      V       : Gra.Real_Vector (0 .. N)         := (0 .. N => 0.0);
      C_V     : Gra.Real_Vector (0 .. N);
      X_Power : Gra.Real_Vector (0 .. N);
      Bias    : constant Integer                 := X'First (2) - Y'First;
      K1      : Integer                          := 0;
   begin
      if X'Length (2) /= Y'Length then
         raise Constraint_Error;  -- X and Y must have same number of data points
      end if;
      if C'Length (1) /= X'Length (1) then
         raise Constraint_Error;  -- C and X must have same number of rows
      end if;
      if Y'Length < C'Length (1) * C'Length (2) then
         raise Numeric_Error;  -- insufficient data
      end if;
      for K in X'Range (2) loop
         for I in Integer (0) .. C'Length (1) - 1 loop
            X_Power (I * C'Length (2)) := X (I + X'First, K);
            for J in Integer (1) .. C'Length (2) - 1 loop
               X_Power (I * C'Length (2) + J) :=
                 X_Power (I * C'Length (2) + J - 1) * X (I + X'First, K);
            end loop;
         end loop;
         for I in M'Range (1) loop
            for J in M'Range (2) loop
               M (I, J) := M (I, J) + X_Power (I) * X_Power (J);
            end loop;
            V (I) := V (I) + Y (K - Bias) * X_Power (I);
         end loop;
      end loop;
      C_V := Gra.Solve (M, V);
      for I in C'Range (1) loop
         Vector_To_Row (C_V (K1 .. K1 + C'Length (2) - 1), I, C);
         K1 := K1 + C'Length (2);
      end loop;
   end Fit;

--
end Generic_Real_Least_Square_Fit;
