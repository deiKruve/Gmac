
with Ada.Text_Io; use Ada.Text_Io;

procedure Tridiag
is
   type Marr is array (Integer range 1 .. 20) of Long_Float; 
   
   function Tridag (Aa, Bb, cc, Dd : Marr; Nn : Integer) return Marr
   is
      Km1 : Integer;
      Xm : Long_Float;
      A : Marr := Aa;
      B : Marr := Bb;
      C : Marr := Cc;
      D : Marr := Dd;
      X : Marr;
   begin
      if Nn = 1 then
	 D (1) := D (1) / B (1);
	 return X;
      end if;
      for K in A'First + 1 .. Nn loop
	 Km1 := K - 1;
	 if B (K - 1) = 0.0 then
	    raise Constraint_Error;
	 end if;
	 
	 Xm := A (K) / B (Km1);
	 B (K) := B (K) - Xm * C (Km1);
	 D (K) := D (K) - Xm * D (Km1);
      end loop;
      X (Nn) := D (Nn) / B (Nn);
      for K in reverse 1 .. Nn - 1 loop
	 --D(K) := (D (K) - C (K) * D (K + 1)) / B (K);
	 Put_Line (Integer'Image (K) & "hey jim" & Long_Float'Image (X (K + 1)));
	 X (K) := (D (K) - C (K) * X (K + 1)) / B (K);
      end loop;
      return X;
   end Tridag;
   
   
   A,
   B,
   C,
   D,
   X : Marr;
   
begin
   for I in A'First .. 10 loop
      A (I) := -1.0;
      B (I) := 2.0;
      C (I) := -1.0;
      D (I) := 0.0;
   end loop;  
   D (1) := 1.0;
   X := Tridag (A, B, C, D, 10);
   for I in X'First .. 10 loop
      Put_Line (Integer'Image (I) & " " & Long_Float'Image (X (I)));
   end loop;

end Tridiag;
