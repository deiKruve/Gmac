------------------------------------------------------------------------------
--                                                                          --
--                              GMAC COMPONENTS                             --
--                                                                          --
--                   C L O S E D _ B E Z I E R _ S P L I N E                --
--                                                                          --
--                                  S p e c                                 --
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

--  to make a sequence of individual Bezier curves to be a spline we should 
--  calculate Bezier control points so that the spline curve has 
--  two continuous derivatives at the knot points. 

--  Bezier curve at the single interval is expressed as 

--- B(t) = (1-t)^3 P0 + 3(1-t)^2 t P1 + 3(1-t)t^2 P2 + t^3 P3

--  where t is in [0,1] and 

--  1. P0 – first knot point 

--  2. P1 – first control point (at first knot) 

--  3. P2 – second control point (at second knot) 

--  4. P3 – second knot point 

--  First derivative is: 

--- B'(t) = -3(1-t)^2 P0 + 3(3t^2–4t+1) P1 + 3(2–3t)t P2 + 3t^2 P3
--- 
--  Second derivative is: 

--  B’’(t) = 6 (1 – t) P0 + 3 (6t – 4) P1 + 3 (2 – 6t) P2+ 6 t P3 
--- B''(t) = 6(1-t) P0 + 6(3t-2) P1 + 6(1–3t) P2 + 6t P3

--  Let’s consider piece-wise Bezier curve on the interval with n (n > 2) points: 
--   Pi (0,..,n-1) and n subintervals Si (0,..,n-1). 

--  S[i] = (P[i], P[i+1]) for (i=0,..,n-2) 

--  S[n-1] = (P[n-1], P[0]) for (i=n-1) 

--  Bezier curve at Si (i=0,..,n-2) will be  

--  Bi(t) = (1–t)^3 P[i] + 3(1-t)^2 t P1[i] +3(1-t)t^2 P2[i+1] + t^3 P[i+1]; (i=0,..,n-2) 
----  Bi(t) = (1–t)^3 P[i] + 3(1-t)^2 t P1[i] +3(1-t)t^2 P2[i] + t^3 P[i+1]; (i=0,..,n-2) 
--- B[i](t) = (1-t)^3 P0[i] + 3(1-t)^2 t P1[i] + 
---           3(1-t)t^2 P2[i] + t^3 P3[i]                 (i = 1..n)

--  and the closing Bezier curve at Sn-1 

--  Bi(t) = (1–t)^3 P[n-1] + 3(1-t)^2 t P1[n-1] + 3(1-t)t^2 P2[0] + t^3 P[0] 
----  Bi(t) = (1–t)^3 P[n-1] + 3(1-t)^2 t P1[n-1] + 3(1-t)t^2 P2[n-1] + t^3 P[0] 

--  First derivative at Si (i=0,..,n-2) will be

--  B’[i](t) = -3(1-t)^2 P[i] + 3(3t^2-4t+1) P1[i] + 3(2t–3t^2) P2[i+1] + 3t^2 P[i+1]
----  B’[i](t) = -3(1-t)^2 P[i] + 3(3t^2-4t+1) P1[i] + 3(2t–3t^2) P2[i] + 3t^2 P[i+1]

--  and at S[n-1]

--  B’n-1(t) = -3(1-t)^2 P[n-1] +3(3t^2-4t+1) P1[n-1] + 3(2t–3t^2) P2[0] +3t^2 P[0]
----  B’n-1(t) = -3(1-t)^2 P[n-1] +3(3t^2-4t+1) P1[n-1] + 3(2t–3t^2) P2[n-1] +3t^2 P[0]

--  First derivative continuity condition gives:
---Using the first derivative continuity condition:
--- 
--- B'[i-1](1) = B'[i](0)
--- 
--- we get:

--  P1[i] + P2[i] = 2 P[i] (i=0,..,n-1)                                           (1)

--  Second derivative at S[i] (i=0,..,n-2) will be

--  B’’[i] (t) = 6 (1-t) Pi +6 (3t – 2) P1[i] + 6 (1 – 3t) P2[i+1] + 6t P[i+1]

--  and at S[n-1]

--  B’’[n-1] (t) = 6 (1-t) P[n-1] +6 (3t – 2) P1[n-1] + 6 (1 – 3t) P2[0] + 6t P[0] ????

--  Second derivative continuity condition gives:

--  at P[0]

--  2 P1[0] + P1[n-1] = 2 P2[0] + P2[1]                                         (2.1)

--  at P[i] (i=1,..,n-2)

--  2 P1[i] + P1[i-1] = 2 P2[i] + P2[i+1]                                        (2.2)

--  and at Pn-1

--  2 P1n-1 + P1n-2 = 2 P2n-1 + P20                                              (2.3)

--  Excluding P2 form (2.1-3) with (1) we get the set of equations for P1

--  4 P1[0] + P1[1] + P1[n-1] = 4 P0 + 2 P1 for P0

--  P1[i-1] + 4 P1[i] + P1[i+1] = 4 P[i] + 2 P[i+1] for Pi (i=1,..,n-2)

--  P1[0] + P1[n-2] + 4 P1[n-1] = 4 P[n-1] + 2 P0 for P[n-1]

--  We got the system with the matrix which looks like

--  4 1 0 0 … 0 1 

--  1 4 1 0 … 0 0 

--  0 1 4 1 … 0 0 

--  …………… 

--  1 0 0 0 … 1 4 

--  It’s so-called "cyclic" system which can be solved as effectively as 
--  a tridiagonal system with the trick which you can find in 
--  the "Numerical Recipes", for example.

--  After P1’s found it’s easy to get P2’s from (1).



with Ada.Streams;

package Closed_Bezier_Spline is
   
   type Double_Arr_Type is array (Integer range <>) of Long_Float;
   
   type Point_Type is 
      record
	 X : Long_Float;
	 Y : Long_Float;
      end record;
   type Point_Array_Type is array (Integer range <>) of Point_Type;
   
   procedure Point_Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Point_type);
   for Point_Type'Write use Point_Write;
   
   
   ArgumentException     : exception; 
   -- ("At least two knot points required", "knots")
   
   
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
      Second_Control_Points : out Point_Array_Type);
   
   
   -- for testing only
   Function Cyclic_Solve 
     (A, B, C     : Double_Arr_Type; 
      Alpha, Beta : Long_Float; 
      Rhs         : Double_Arr_Type) return Double_Arr_Type;
   
   
   procedure Plot_Bez_Spline 
     (Knots                 : Point_Array_Type;
      First_Control_Points  : Point_Array_Type;
      Second_Control_Points : Point_Array_Type;
      Dmax                  : Long_Float);

end Closed_Bezier_Spline;
