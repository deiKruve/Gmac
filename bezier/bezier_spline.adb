------------------------------------------------------------------------------
--                                                                          --
--                              GMAC COMPONENTS                             --
--                                                                          --
--                         B E Z I E R _ S P L I N E                        --
--                                                                          --
--                                  B o d y                                 --
--                                                                          --
--                                                                          --
-- Original analisys and code Copyright © 2008-2009 Oleg V. Polikarpotchkin.--
--  <email>ov-p@yandex.ru</email>                                           --
-- Modified: Peter Lee (peterlee.com.cn < at > gmail.com)                   --
--   Update: 2009-03-16                                                     --
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
-- Methods to calculate Bezier Spline connection points.

--- 
--- see also:
--- Draw a smooth curve through a set of 2D points with Bezier primitives
--- http://www.codeproject.com/KB/graphics/BezierSpline.aspx
--- By Oleg V. Polikarpotchkin
--- 
--- Algorithm Descripition:
--- 
--- To make a sequence of individual Bezier curves to be a spline, we
--- should calculate Bezier control points so that the spline curve
--- has two continuous derivatives at knot points.
--- 
--- Note: `[]` denotes subscript
---        `^` denotes supscript
---        `'` denotes first derivative
---       `''` denotes second derivative
---       
--- A Bezier curve on a single interval can be expressed as:
--- 
--- B(t) = (1-t)^3 P0 + 3(1-t)^2 t P1 + 3(1-t)t^2 P2 + t^3 P3          (*)
--- 
--- where t is in [0.0 .. 1.0], and
---     1. P0 - first knot point
---     2. P1 - first control point (close to P0)
---     3. P2 - second control point (close to P3)
---     4. P3 - second knot point
---     
--- The first derivative of (*) is:
--- 
--- B'(t) = -3(1-t)^2 P0 + 3(3t^2–4t+1) P1 + 3(2–3t)t P2 + 3t^2 P3
--- 
--- The second derivative of (*) is:
--- 
--- B''(t) = 6(1-t) P0 + 6(3t-2) P1 + 6(1–3t) P2 + 6t P3
--- 
--- Considering a set of piecewise Bezier curves with n+1 points
--- (Q[0..n]) and n subintervals, the (i-1)-th curve should connect
--- to the i-th one:
--- 
--- Q[0] = P0[1],
--- Q[1] = P0[2] = P3[1], ... , Q[i-1] = P0[i] = P3[i-1]  (i = 1..n)   (@)
--- 
--- At the i-th subinterval, the Bezier curve is:
--- 
--- B[i](t) = (1-t)^3 P0[i] + 3(1-t)^2 t P1[i] + 
---           3(1-t)t^2 P2[i] + t^3 P3[i]                 (i = 1..n)
--- 
--- applying (@):
--- 
--- B[i](t) = (1-t)^3 Q[i-1] + 3(1-t)^2 t P1[i] + 
---           3(1-t)t^2 P2[i] + t^3 Q[i]                  (i = 1..n)   (i)
---           
--- From (i), the first derivative at the i-th subinterval is:
--- 
--- B'[i](t) = -3(1-t)^2 Q[i-1] + 3(3t^2–4t+1) P1[i] +
---            3(2–3t)t P2[i] + 3t^2 Q[i]                 (i = 1..n)
--- 
--- Using the first derivative continuity condition:
--- 
--- B'[i-1](1) = B'[i](0)
--- 
--- we get:
--- 
--- P1[i] + P2[i-1] = 2Q[i-1]                             (i = 2..n)   (1)
--- 
--- From (i), the second derivative at the i-th subinterval is:
--- 
--- B''[i](t) = 6(1-t) Q[i-1] + 6(3t-2) P1[i] +
---             6(1-3t) P2[i] + 6t Q[i]                   (i = 1..n)
--- 
--- Using the second derivative continuity condition:
--- 
--- B''[i-1](1) = B''[i](0)
--- 
--- we get:
--- 
--- P1[i-1] + 2P1[i] = P2[i] + 2P2[i-1]                   (i = 2..n)   (2)
--- 
--- Then, using the so-called "natural conditions":
--- 
--- B''[1](0) = 0
--- 
--- B''[n](1) = 0
--- 
--- to the second derivative equations, and we get:
--- 
--- 2P1[1] - P2[1] = Q[0]                                              (3)
--- 
--- 2P2[n] - P1[n] = Q[n]                                              (4)
--- 
--- From (1)(2)(3)(4), we have 2n conditions for n first control points
--- P1[1..n], and n second control points P2[1..n].
--- 
--- Eliminating P2[1..n], we get (be patient to get :-) a set of n
--- equations for solving P1[1..n]:
--- 
---   2P1[1]   +  P1[2]   +            = Q[0] + 2Q[1]
---    P1[1]   + 4P1[2]   +    P1[3]   = 4Q[1] + 2Q[2]
---  ...
---    P1[i-1] + 4P1[i]   +    P1[i+1] = 4Q[i-1] + 2Q[i]
---  ...
---    P1[n-2] + 4P1[n-1] +    P1[n]   = 4Q[n-2] + 2Q[n-1]
---               P1[n-1] + 3.5P1[n]   = (8Q[n-1] + Q[n]) / 2
---  
--- From this set of equations, P1[1..n] are easy but tedious to solve.
---
---- note that in the software 
---- Q[0]  is at Knots (0)
---- P1[1] is at Fcp (0) and and P2[1] is at Scp (0)

with Ada.Text_IO.Text_Streams;

package body Bezier_Spline is
   
   package Tio   renames Ada.Text_IO;
   package Tiots renames Ada.Text_IO.Text_Streams;
   
   -- Solves a tridiagonal system for one of coordinates (x or y) of 
   --  first Bezier control points.
   --
   -- "rhs"   Right hand side vector.
   -- returns Solution vector.  
   function Get_First_Control_Points (Rhs : Double_Arr_Type) return Double_Arr_Type
   is
      N : Integer := Rhs'Length;
      X,
      Tmp : Double_Arr_Type (Rhs'First .. Rhs'Last);
      B : Long_Float := 2.0;
   begin
      X (Rhs'First) := Rhs (Rhs'First) / B;
      --Decomposition and forward substitution.
      for I in Rhs'First + 1 .. Rhs'Last loop 
	 Tmp (I) := 1.0 / B;
	 if I < Rhs'Last then
	    B := 4.0 - Tmp (I);
	 else
	    B := 3.5 - Tmp (I);
	 end if;
	 X (I) := (Rhs (I) - X (I - 1)) / B;
      end loop;
      -- Backsubstitution.
      for I in reverse Rhs'First + 1 .. Rhs'Last loop 
	 X (I - 1) := X (I - 1) - Tmp (I) * X (I);
      end loop;
      return X;
   end Get_First_Control_Points;
   
   
   ----------------------------------------------------------------------------------
   --                                                                              --
   -- Get open-ended Bezier Spline Control Points.                                 --
   --                                                                              --
   -- "knots"               >Input.  Knot Bezier spline points.                    --
   -- "firstControlPoints"  >Output. First Control points array of                 --
   --                                          knots.Length - 1 length.            --
   -- "secondControlPoints" >Output. Second Control points array of                --
   --                                           knots.Length - 1 length.           --
   -- exception "ArgumentNullException" paramref name="knots" must be not null.    --
   -- exception "ArgumentException"     paramref name="knots" array must contain   --
   --                                                         at least two points. --
   ----------------------------------------------------------------------------------
   procedure Get_Curve_Control_Points 
     (Knots                 : Point_Array_Type;
      First_Control_Points  : out Point_Array_Type;
      Second_Control_Points : out Point_Array_Type)
   is
      N    : Integer        := Knots'Length - 1;
      Fcp,
      Scp  : Point_Array_Type (Knots'First .. Knots'Last - 1);
      Rhs,
      X,
      Y    : Double_Arr_Type (Knots'First .. Knots'Last - 1);
   begin
      if N <  1 then
	 raise ArgumentException;
      elsif N = 1 then 
	 -- straight line, 2 points only:
	 -- 3P1 = 2P0 + P3
	 Fcp (Fcp'First).X := 
	   (2.0 * Knots (Knots'First).X + Knots (Knots'First + 1).X) / 3.0;
	 Fcp (Fcp'First).Y := 
	   (2.0 * Knots (Knots'First).Y + Knots (Knots'First + 1).Y) / 3.0;
	 -- P2 = 2P1 – P0
	 Scp (Scp'First).X := 2.0 * Fcp (Fcp'First).X - Knots (Knots'First).X;
	 Scp (Scp'First).Y := 2.0 * Fcp (Fcp'First).Y - Knots (Knots'First).Y;
      else
	 -- Calculate first Bezier control points
	 -- Right hand side vector:
	 
	 -- Set right hand side X values
	 Rhs (Rhs'First) := Knots (Knots'First).X + 2.0 * Knots (Knots'First + 1).X;
	 for I in Knots'First + 1 .. Knots'Last - 2 loop
	    Rhs (I) := 4.0 * Knots (I).X + 2.0 * Knots (I + 1).X;
	 end loop;
	 Rhs (Rhs'Last) := 
	   (8.0 * Knots (Knots'Last - 1).X + Knots (Knots'Last).X) / 2.0;
	 
	 -- Get first control points X-values
	 X := Get_First_Control_Points (Rhs);
	 
	 -- Set right hand side Y values 
	 Rhs (Rhs'First) := Knots (Knots'First).Y + 2.0 * Knots (Knots'First + 1).Y;
	 for I in Knots'First + 1 .. Knots'Last - 2 loop
	    Rhs (I) := 4.0 * Knots (I).Y + 2.0 * Knots (I + 1).Y;
	 end loop;
	 Rhs (Rhs'Last) := 
	   (8.0 * Knots (Knots'Last - 1).Y + Knots (Knots'Last).Y) / 2.0;
	 
	 -- Get first control points Y-values
	 Y := Get_First_Control_Points (Rhs);
	 
	 -- Fill output arrays.
	 for I in Knots'First .. Knots'Last - 2 loop
	    Fcp (I).X := X (I);
	    Fcp (I).Y := Y (I);
	    Scp (I).X := 2.0 * Knots (I + 1).X - X (I + 1);
	    Scp (I).Y := 2.0 * Knots (I + 1).Y - Y (I + 1);
	 end loop;
	 Fcp (Fcp'Last).X := X (X'Last);
	 Fcp (Fcp'Last).Y := Y (Y'Last);
	 Scp (Scp'Last).X := (Knots (Knots'Last).X + X (X'Last)) / 2.0;
	 Scp (Scp'Last).Y := (Knots (Knots'Last).Y + Y (Y'Last)) / 2.0;
      end if;
      First_Control_Points  := Fcp;
      Second_Control_Points := Scp;
   end Get_Curve_Control_Points;
   
   
   -- gives out a pair of x and y
   -- should be rewritten for file output or streaming--
   -- write_point can now be defined externally and used as appropriate
  procedure Point_Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Point_type)
   is
   begin
      Write_Point (Stream, Item);
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
   -- outputs via Point_Type'Write to 
   ----------------------------------------------------------------------------------
   procedure Plot_Bez_Spline 
     (Knots                 : Point_Array_Type;
      First_Control_Points  : Point_Array_Type;
      Second_Control_Points : Point_Array_Type;
      Dmax                  : Long_Float)
   is
      Dmax_Sq : Long_Float := Dmax ** 2;
      Ostr : Tiots.Stream_Access := Tiots.Stream (Tio.Standard_Output);
   begin
      Point_Type'Write (Ostr, Knots (Knots'First));
      for I in Knots'First .. Knots'Last - 1 loop
	 if Knots (I + 1) - Knots (I) > Dmax_Sq then
	    Split_Bez (Knots (I), 
		       First_Control_Points (I), 
		       Second_Control_Points (I),
		       Knots (I + 1),
		       Dmax_Sq);
	 end if;
	 Point_Type'Write (Ostr, Knots (I + 1));
      end loop;
   end Plot_Bez_Spline;
     
end Bezier_Spline;
