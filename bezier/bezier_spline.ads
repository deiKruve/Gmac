
-- <copyright file="BezierSpline.cs" company="Oleg V. Polikarpotchkin">
-- Copyright © 2008-2009 Oleg V. Polikarpotchkin. All Right Reserved
-- </copyright>
-- <author>Oleg V. Polikarpotchkin</author>
-- <email>ov-p@yandex.ru</email>
-- <date>2008-12-17</date>
-- <summary>
-- Methods to calculate Bezier Spline points.
-- Modified: Peter Lee (peterlee.com.cn < at > gmail.com)
--   Update: 2009-03-16



--- <summary>
--- Bezier Spline methods
--- </summary>
--- <remarks>
--- Modified: Peter Lee (peterlee.com.cn < at > gmail.com)
---   Update: 2009-03-16
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
--- where t is in [0,1], and
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
--- </remarks>


package Bezier_Spline is
   
   type Double_Arr_Type is array (Integer range <>) of Long_Float;
   
   type Point_Type is 
      record
	 X : Long_Float;
	 Y : Long_Float;
      end record;
   type Point_Array_Type is array (Integer range <>) of Point_Type;
   
   
   ArgumentNullException : exception; 
   -- ("knots")
   ArgumentException     : exception; 
   -- ("At least two knot points required", "knots")
   
   
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
      Second_Control_Points : out Point_Array_Type);
   
   
   -- only for testing
   function Get_First_Control_Points (Rhs : Double_Arr_Type) return Double_Arr_Type;
   
end Bezier_Spline;
