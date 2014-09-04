------------------------------------------------------------------------------
--                                                                          --
--                              GMAC COMPONENTS                             --
--                                                                          --
--                   C L O S E D _ B E Z I E R _ S P L I N E                --
--                                                                          --
--                                  B o d y                                 --
--                                                                          --
--                                                                          --
-- Original analisys and code Copyright © 2008-2009 Oleg V. Polikarpotchkin.--
--  <email>ov-p@yandex.ru</email>                                           --
--                                                                          --
--           Ada translation Copyright (C) 2014, Jan de Kruyf               --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.                                               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
--                 gMAC is maintained by J de Kruijf Engineers              --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- Methods to calculate Closed Bezier Spline Control Points.
--

-- SEE ALSO:
-- Draw Closed Smooth Curve with Bezier Spline
-- http://www.codeproject.com/Articles/33776/Draw-Closed-Smooth-Curve-with-Bezier-Spline
-- By Oleg V. Polikarpotchkin
--

with Ada.Text_IO.Text_Streams;

package body Closed_Bezier_Spline is
   
   package Tio   renames Ada.Text_IO;
   package Tiots renames Ada.Text_IO.Text_Streams;
   
   
   ----------------------------------------------------------------------------------
   --                                                                              --
   -- Solves a tridiagonal system.                                                 --
   --                                                                              --
   -- All vectors have size of n although some elements are not used.              --
   --                                                                              --
   --                                                                              -- 
   -- "a" >input.     Lower diagonal vector of size n; a[0] not used.              --
   -- "b" >input.     Main diagonal vector of size n.                              --
   -- "c" >input.     Upper diagonal vector of size n; c[n-1] not used.            --
   -- "rhs"   >input. Right hand side vector.                                      --
   -- Returns         The solution vector of size n.                               --
   ----------------------------------------------------------------------------------
   Function Tridiag_Solve (A, B, C, Rhs: Double_Arr_Type) return Double_Arr_Type
   is
      Bet     : Long_Float := B (B'first);
      Gam, 
      U       : Double_Arr_Type (A'First .. A'Last);
   begin
      if A'Length /= B'Length or C'Length /= B'Length or Rhs'Length /= B'Length then
	 raise ArgumentException;
	 -- "Diagonal and rhs vectors must have the same size."
      end if;
      if B (B'First) = 0.0 then
	 raise ArgumentException;
	 -- "Singular matrix."
	 -- If this happens then you should rewrite your equations as a set of
	 -- order N - 1, with u2 trivially eliminated.
      end if;
      
      U (U'First) := Rhs (Rhs'First) / Bet;
      for I in  Gam'First + 1 .. Gam'Last loop --Decomposition and forward substitution
	 Gam (I) := C (I - 1) / Bet;
	 Bet := B (I) - A (I) * Gam (I);
	 if abs (Bet) < Long_Float'Epsilon then
	    raise ArgumentException;
	    -- "Singular matrix."
	    -- Algorithm fails.
	 end if;
	 U (I) := (Rhs (I) - A (I) * U (I - 1)) / Bet;
      end loop;
      for I in reverse Gam'First + 1 .. Gam'Last loop -- Backsubstitution.
	 U (I - 1) := U (I - 1) - Gam (I) * U (I);
      end loop;
      return U;
   end Tridiag_Solve;
   
   
   ----------------------------------------------------------------------------------
   --                                                                              --
   -- Solves the cyclic set of linear equations.                                   --
   --                                                                              --
   -- The cyclic set of equations have the form:                                   --
   --                                                                              --
   -- ---------------------------------                                            --
   -- b0 c0  0  ·  ·  ·  ·   · · ß                                                 --
   --	 a1  b1 c1 · · · · · · ·                                                   --
   --  · ·   ·  · · · · · · · ·                                                    --
   --  · ·   ·     a[n-2] b[n-2] c[n-2]                                            --
   -- a  · · ·  ·      0  a[n-1] b[n-1]                                            --
   -- ----------------------------------                                           --
   -- This is a tridiagonal system, except for the matrix elements                 --
   -- a and ß in the corners.                                                      --
   --                                                                              --
   -- All vectors have size of n although some elements are not used.              --
   --                                                                              --
   -- The input is not modified.                                                   --
   --                                                                              --
   -- "a" >input.     Lower diagonal vector of size n; a[0] not used.              --
   -- "b" >input.     Main diagonal vector of size n.                              --
   -- "c" >input.     Upper diagonal vector of size n; c[n-1] not used.            --
   -- "alpha" >input. Bottom-left corner value.                                    --
   -- "beta"  >input. Top-right corner value.                                      --
   -- "rhs"   >input. Right hand side vector.                                      --
   -- Returns         The solution vector of size n.                               --
   ----------------------------------------------------------------------------------
   Function Cyclic_Solve (A, B, C: Double_Arr_Type; 
			  Alpha, Beta : Long_Float; 
			  Rhs : Double_Arr_Type) return Double_Arr_Type
   is
      Fact      : Long_Float;
      -- Avoid subtraction error in forming bb[0].
      Gamma     : Long_Float := -B (B'First);
      Bb,
      Solution,
      U,
      X,
      Z         : Double_Arr_Type (A'First .. A'Last);
   begin
      if A'Length /= B'Length or C'Length /= B'Length or Rhs'Length /= B'Length then
	 raise ArgumentException;
	 -- "Diagonal and rhs vectors must have the same size."
      end if;
      if B'Length <= 2 then 
	 raise ArgumentException;
	 -- "length too small in Cyclic; must be greater than 2."
      end if;
      
      Bb (Bb'First)                    := B (B'First) - gamma;
      Bb (Bb'First + 1 .. Bb'Last - 1) := B (B'First + 1 .. B'Last - 1);
      Bb (Bb'Last)                     := B (B'Last) - alpha * beta / gamma;
      
      -- Solve A � x = rhs.
      Solution := Tridiag_Solve (A, Bb, C, Rhs);
      X        := Solution;
      
      -- Set up the vector u.
      U := (others => 0.0);
      U (U'First) := gamma;
      U (U'Last ) := Alpha;
      
      -- Solve A � z = u.
      Solution := Tridiag_Solve (A, Bb, C, U);
      Z        := Solution;
      
      --Form v � x/(1 + v � z).
      Fact := (X (X'First) + Beta * X (X'Last) / gamma) /
	                          (1.0 + Z (Z'First) + Beta * Z (Z'Last) / gamma);
      
      -- Now get the solution vector x.
      for I in X'First .. X'Last loop
	 X (I) := X (I) - Fact * Z(I);
      end loop;
      
      return X;
   end Cyclic_Solve;
   

   ----------------------------------------------------------------------------------
   --                                                                              --
   -- "knots"               >Input.  Knot Bezier spline points.                    --
   -- "firstControlPoints"  >Output. First Control points array of                 --
   --                                          knots.Length length.            --
   -- "secondControlPoints" >Output. Second Control points array of                --
   --                                           knots.Length length.           --
   -- exception "ArgumentException"  paramref = "knots" array must contain         --
   --                                                         at least two points. --
   ----------------------------------------------------------------------------------
   procedure Get_Curve_Control_Points 
     (Knots                 :     Point_Array_Type;
      First_Control_Points  : out Point_Array_Type;
      Second_Control_Points : out Point_Array_Type)
   is
      A  : Double_Arr_Type (Knots'First .. Knots'Last) := (others => 1.0);
      B  : Double_Arr_Type (Knots'First .. Knots'Last) := (others => 4.0);
      C  : Double_Arr_Type (Knots'First .. Knots'Last) := (others => 1.0);
      Rhs,
      X,
      Y  : Double_Arr_Type (Knots'First .. Knots'Last);
      Fcp,
      Scp  : Point_Array_Type (Knots'First .. Knots'Last);
      
   begin
      if Knots'Length <= 2 then
	 raise ArgumentException;
	 return;
      end if;

      -- Right hand side vector for points X coordinates.
      for I in Rhs'First .. Rhs'Last loop
	 if I = Rhs'Last then
	    Rhs (I) := 4.0 * Knots (I).X + 2.0 * Knots (Knots'First).X;
	 else 
	    Rhs (I) := 4.0 * Knots (I).X + 2.0 * Knots (I + 1).X;
	 end if;
      end loop;
      -- Solve the system for X.
      X := Cyclic_Solve (A, B, C, 1.0, 1.0, Rhs);
      
      -- Right hand side vector for points Y coordinates.
      for I in Rhs'First .. Rhs'Last loop
	 if I = Rhs'Last then
	    Rhs (I) := 4.0 * Knots (I).Y + 2.0 * Knots (Knots'First).Y;
	 else 
	    Rhs (I) := 4.0 * Knots (I).Y + 2.0 * Knots (I + 1).Y;
	 end if;
      end loop;
      -- Solve the system for Y.
      Y := Cyclic_Solve (A, B, C, 1.0, 1.0, Rhs);
      
      --Fill output arrays.
      for I in First_Control_Points'First .. First_Control_Points'Last loop
	 Fcp (I).X := X (I);
	 Fcp (I).Y := Y (I);
	 Scp (I).X := 2.0 * Knots (I).X - X (I);-------------------
	 Scp (I).Y := 2.0 * Knots (I).Y - Y (I);------------------
      end loop;
      First_Control_Points  := Fcp;
      Second_Control_Points := Scp;
   end Get_Curve_Control_Points;
   
   
   
   
   -- gives out a pair of x and y
   -- should be rewritten for file output or streaming
   procedure Point_Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Point_type)
   is
   begin
      Tio.Put_Line (Long_Float'Image (Item.X) & "  " & Long_Float'Image (Item.Y));
      null;
   end Point_Write;
   
   
   function "+" (Left, Right : Point_Type) 
		return Point_type with inline
   is
      A : Point_Type;
   begin
      A.X := Left.X + Right.X;
      A.Y := Left.Y + Right.Y;
     return  A;
   end "+";
   
   
   function "-" (Left, Right : Point_Type) 
		return Point_type with inline
   is
      A : Point_Type;
   begin
      A.X := Left.X - Right.X;
      A.Y := Left.Y - Right.Y;
     return  A;
   end "-";
   
   
   function "/" (Left : Point_Type; D : Long_Float) 
		return Point_Type with inline
   is
      A : Point_Type;
   begin
      A.X := Left.X / D;
      A.Y := Left.Y / D;
      return A;
   end "/";
   
   
   function ">" (Left : Point_Type; Right_Sq : Long_Float) 
		return Boolean with Inline
   is
   begin
      if Left.X ** 2 + Left.Y ** 2 > Right_Sq then
	 return True;
      else
	 return False;
      end if;
   end ">";
   
   
   -- split a bezier curve
   -- "p0" and "p3" are the end points
   -- "p1" and "p2" are the control points
   -- "dmax_sq" is the max distance squared, between the endpoints that is allowed
   --                                          before splitting.
   -- "p0" must be written before entering to the outputstream
   --    in case of a splined bezier, "p0" is off course the "p3" of 
   --                                                        the previous section.
   -- "p3" must be written after return from this routine.
   procedure Split_Bez (P0, P1, P2, P3 : Point_Type; Dmax_Sq : Long_float)
   is
      Q0, Q1, Q2, Q3, R0, R1, R2, R3, H : Point_Type; 
      Ostr : Tiots.Stream_Access := Tiots.Stream (Tio.Standard_Output);
   begin
      Q0 := P0;
      R3 := P3;
      Q1 := (P0 + P1) / 2.0;
      R2 := (P2 + P3) / 2.0;
      H  := (P1 + P2) / 2.0;
      Q2 := (Q1 + H) / 2.0;
      R1 := (H + R2) / 2.0;
      R0 := (Q2 + R1) / 2.0;
      Q3 := R0;
      if Q3 - Q0 > Dmax_Sq then
	 Split_Bez (Q0, Q1, Q2, Q3, Dmax_Sq);
      end if;
      Point_Type'Write (Ostr, Q3);
      if
	R0 - R3 > Dmax_Sq then
	 Split_Bez (R0, R1, R2, R3, Dmax_Sq);
      end if;
      
   end Split_Bez;
   
   
   ----------------------------------------------------------------------------------
   --                                                                              --
   -- Plot a Bezier spline to a list of point pairs                                --
   --                                                                              --
   -- "knots"               >Input.  Knot Bezier spline points.                    --
   -- "firstControlPoints"  >Input.  First Control points array of                 --
   --                                          knots.Length - 1 length.            --
   -- "secondControlPoints" >Input.  Second Control points array of                --
   --                                           knots.Length - 1 length.           --
   -- "Interval"            >Input.  Inteval between the plot points.              --
   -- NOT "Bez_Spline_list"     >Output. The output list of plotted points         --
   -- outputs via Point_Type'Write to std io
   ----------------------------------------------------------------------------------
   procedure Plot_Bez_Spline 
     (Knots                 : Point_Array_Type;
      First_Control_Points  : Point_Array_Type;
      Second_Control_Points : Point_Array_Type;
      Dmax                  : Long_Float)
     --return Point_Array_Type
   is
      Dmax_Sq : Long_Float := Dmax ** 2;
      Ostr : Tiots.Stream_Access := Tiots.Stream (Tio.Standard_Output);
      --A : Point_Array_Type ( 1 .. 2);
   begin
      Point_Type'Write (Ostr, Knots (Knots'First)); -- startpoint
      for I in Knots'First .. Knots'Last - 1 loop
	 if Knots (I + 1) - Knots (I) > Dmax_Sq then
	    Split_Bez (Knots (I), 
		       First_Control_Points (I), 
		       Second_Control_Points (I + 1),
		       Knots (I + 1),
		       Dmax_Sq);
	 end if;
	 Point_Type'Write (Ostr, Knots (I + 1));
      end loop;
      -- and the last curve
      if Knots (Knots'First) - Knots (Knots'Last) > Dmax_Sq then
	 Split_Bez (Knots (Knots'Last), 
		    First_Control_Points (Knots'Last), 
		    Second_Control_Points (Knots'First),
		    Knots (Knots'First),
		    Dmax_Sq);
      end if;
      Point_Type'Write (Ostr, Knots (Knots'First)); -- to close the loop
      --return A;
   end Plot_Bez_Spline;
   

end Closed_Bezier_Spline;
