--  <copyright file="BezierSplineTest.cs" company="Oleg V. Polikarpotchkin">
--  Copyright © 2008-2009 Oleg V. Polikarpotchkin. All Right Reserved
--  </copyright>
--  <author>Oleg V. Polikarpotchkin</author>
--  <email>ov-p@yandex.ru</email>
--  <date>2009-03-20</date>
--  <summary>Tests for BezierSpline class.</summary>
--

with Ada.Assertions;
with Ada.Text_IO;

package body  Bezier_Spline_Test is
   package Bs renames Bezier_Spline;
   package Ass renames Ada.Assertions;
   package Tio renames Ada.Text_IO;
   
   
   -- Check for the boundary conditions.
   --
   -- "knots" : The knots.
   -- "p1"    : The first control points.
   -- "p2"    : The second control points.
   procedure Check_Boundary_Conditions 
     (Knots : Bs.Point_Array_Type;
      P1    : Bs.Point_Array_Type;
      P2    : Bs.Point_Array_Type)
   is
   begin
      -- left bound
      Ass.Assert 
	(abs (Knots (Knots'first).X - (2.0 * P1 (P1'first).X - P2 (P2'first).X)) 
	   < 10.0e-7, "Check_Boundary_Conditions 1 X");
      Ass.Assert 
	(abs (Knots (Knots'first).Y - (2.0 * P1 (P1'first).Y - P2 (P2'first).Y)) 
	   < 10.0e-7, "Check_Boundary_Conditions 1 Y");
      -- right bound
      Ass.Assert 
	(abs (Knots (Knots'last).X - (2.0 * P2 (P2'last).X - P1 (P1'last).X)) 
	   < 10.0e-7, "Check_Boundary_Conditions 2 X");
      Ass.Assert 
	(abs (Knots (Knots'last).Y - (2.0 * P2 (P2'last).Y - P1 (P1'last).Y)) 
	   < 10.0e-7, "Check_Boundary_Conditions 2 Y");
   end Check_Boundary_Conditions;
   
   
   -- Check for the second derivative continuity.
   --
   -- "p1"    : The first control points.
   -- "p2"    : The second control points.
   procedure Check_Second_Derivative_Continuity
     (P1    : Bs.Point_Array_Type;
      P2    : Bs.Point_Array_Type)
   is
   begin
      for I in P1'First + 1 .. P1'Last loop
	 
	 Tio.Put_Line (Integer'Image (I));
	 Tio.Put_Line ("Xp1 " & Long_Float'Image (P1 (I - 1).X) & " + " & Long_Float'Image (2.0 * P1 (I).X));
	 Tio.Put_Line ("Xp2 " & Long_Float'Image (P2 (I).X) & " + " &  Long_Float'Image (2.0 * P2 (I - 1).X));
	 Tio.Put_Line ("X " & Long_Float'Image (P1 (I - 1).X + 2.0 * P1 (I).X) & Long_Float'Image (P2 (I).X + 2.0 * P2 (I - 1).X));
	 Tio.Put_Line ("Y " & Long_Float'Image (P1 (I - 1).Y + 2.0 * P1 (I).Y) & Long_Float'Image (P2 (I).Y + 2.0 * P2 (I - 1).Y));
	 
	 Ass.Assert 
	   (abs ((P1 (I - 1).X + 2.0 * P1 (I).X) - (P2 (I).X + 2.0 * P2 (I - 1).X)) 
	      < 10.0e-7, "Check_Second_Derivative_Continuity X");
	 Ass.Assert 
	   (abs ((P1 (I - 1).Y + 2.0 * P1 (I).Y) - (P2 (I).Y + 2.0 * P2 (I - 1).Y)) 
	      < 10.0e-7, "Check_Second_Derivative_Continuity Y");
      end loop;
   end Check_Second_Derivative_Continuity;
   
   
   -- Check for the first derivative continuity.
   --
   -- "knots" : The knots.
   -- "p1"    : The first control points.
   -- "p2"    : The second control points.
   procedure Check_First_Derivative_Continuity
     (Knots : Bs.Point_Array_Type;
      P1    : Bs.Point_Array_Type;
      P2    : Bs.Point_Array_Type)
   is
   begin
      for I in P1'First + 1 .. P1'Last loop
	 Ass.Assert 
	   (abs (2.0 * Knots (I).X - (P1 (I).X + P2 (I - 1).X)) 
	      < 10.0e-7, "Check_First_Derivative_Continuity X");
	 Ass.Assert 
	   (abs (2.0 * Knots (I).Y - (P1 (I).Y + P2 (I - 1).Y)) 
	      < 10.0e-7, "Check_First_Derivative_Continuity Y");
      end loop;
   end Check_First_Derivative_Continuity;
   

   -- Check control points arrays length.
   --
   -- "knots" : The knots.
   -- "p1"    : The first control points.
   -- "p2"    : The second control points.
   procedure Check_CP_Arrays_Length
     (Knots : Bs.Point_Array_Type;
      P1    : Bs.Point_Array_Type;
      P2    : Bs.Point_Array_Type)
   is
   begin
      Ass.Assert (P1'Length = P2'Length);
      Ass.Assert 
	((Knots'Length < 2 and then P1'Length = 0) or P1'Length = Knots'Length - 1,
	"Check_CP_Arrays_Length");
   end Check_CP_Arrays_Length;
   
   
   -- GetFirstControlPoints method test.
   --
   -- "knots" : The knots.
   procedure Get_First_Control_Points_Test
     (Knots : Bs.Point_Array_Type)
   is
      Plx,
      Ply,
      Rhs : Bs.Double_Arr_Type (Knots'First .. Knots'Last - 1);
   begin
      
      --- Right hand side X values.
      Rhs (Rhs'First) := Knots (Knots'First).X + 2.0 * Knots (Knots'First + 1).X;
      for I in Knots'First + 1 .. Knots'Last - 2 loop
	 Rhs (I) := 4.0 * Knots (I).X + 2.0 * Knots (I + 1).X;
      end loop;
      Rhs (Rhs'Last) := 
	(8.0 * Knots (Knots'Last - 1).X + Knots (Knots'Last).X) / 2.0;
      -- Solve the system to get first control points X-values.
      Plx := Bs.Get_First_Control_Points (Rhs);
      -- Check the system solution.
      -- First equation.
      Ass.Assert (abs ((Knots (Knots'First).X + 2.0 * Knots (Knots'First + 1).X) - 
			 (2.0 * Plx (Plx'First) + Plx (Plx'First + 1))) 
		    < 10.0e-7, "Get_First_Control_Points_Test X 1st");
      -- Intermediate equations.
      for I in Knots'First + 2 .. Knots'Last - 1 loop
	 Ass.Assert (abs ((4.0 * Knots (I - 1).X + 2.0 * Knots (I).X) - 
			    (Plx (I - 2) + 4.0 * Plx (I - 1) + Plx (I))) 
		       < 10.0e-7, "Get_First_Control_Points_Test X 2nd");
      end loop;
      -- Last equation.
      Ass.Assert 
	(abs (((8.0 * Knots (Knots'Last - 1).X + Knots (Knots'Last).X) / 2.0) -
			 (3.5 * Plx (Plx'Last) + Plx (Plx'Last - 1)))
		    < 10.0e-7, "Get_First_Control_Points_Test X 3rd");
      
      --- Right hand side Y values.
      Rhs (Rhs'First) := Knots (Knots'First).Y + 2.0 * Knots (Knots'First + 1).Y;
      for I in Knots'First + 1 .. Knots'Last - 2 loop
	 Rhs (I) := 4.0 * Knots (I).Y + 2.0 * Knots (I + 1).Y;
      end loop;
      Rhs (Rhs'Last) := 
	(8.0 * Knots (Knots'Last - 1).Y + Knots (Knots'Last).Y) / 2.0;
      -- Solve the system to get first control points X-values.
      Ply := Bs.Get_First_Control_Points (Rhs);
      -- Check the system solution.
      -- First equation.
      Ass.Assert (abs ((Knots (Knots'First).Y + 2.0 * Knots (Knots'First + 1).Y) - 
			 (2.0 * Ply (Ply'First) + Ply (Ply'First + 1))) 
		    < 10.0e-7, "Get_First_Control_Points_Test Y 1st");
      -- Intermediate equations.
      for I in Knots'First + 2 .. Knots'Last - 1 loop
	 Ass.Assert (abs ((4.0 * Knots (I - 1).Y + 2.0 * Knots (I).Y) - 
			    (Ply (I - 2) + 4.0 * Ply (I - 1) + Ply (I))) 
		       < 10.0e-7, "Get_First_Control_Points_Test Y 2nd");
      end loop;
      -- Last equation.
      Ass.Assert 
	(abs (((8.0 * Knots (Knots'Last - 1).Y + Knots (Knots'Last).Y) / 2.0) -
			 (3.5 * Ply (Ply'Last) + Ply (Ply'Last - 1)))
		    < 10.0e-7, "Get_First_Control_Points_Test Y 3rd");
   end Get_First_Control_Points_Test;
   
   
   -- GetCurveControlPoints method test.
   procedure Get_Curve_Control_Points_Test
     (Knots : Bs.Point_Array_Type)     
   is
      P1,
      P2    : Bs.Point_Array_Type (Knots'First .. Knots'Last  - 1);
   begin
      --
      Tio.Put_Line (Integer'Image(Knots'First) &" "&Integer'Image(Knots'Last));
      --
      Bs.Get_Curve_Control_Points (Knots, P1, P2);
      Check_CP_Arrays_Length (Knots , P1, P2);
      if (Knots'Length < 2) then
	 return;
      end if;
      Check_First_Derivative_Continuity (Knots, P1, P2);
      Check_Second_Derivative_Continuity (P1, P2);
      Check_Boundary_Conditions (Knots, P1, P2);
   end Get_Curve_Control_Points_Test;
   
   
   -- Generates test data.
   --
   -- returns : Knot points array.
   function Get_Knots_Arc_3Points return Bs.Point_Array_Type
   is
      Pa : Bs.Point_Array_Type := ((200.0, 100.0),
				   (29.2893218813453, 170.710678118655), 
				   (100.0, 0.0)); -- "Arc" curve with 3 points.
   begin
      Tio.Put_Line (Integer'Image (Pa'First) &" "& Integer'Image (Pa'Last));
      return Pa;
   end Get_Knots_Arc_3Points;
   
   
   -- Generates test data.
   --
   -- returns : Knot points array.
   function Get_Knots_Arc_5Points return Bs.Point_Array_Type
   is
      Pa : Bs.Point_Array_Type := ((200.0, 100.0),
				   (138.268343236509, 192.387953251129),
				   (29.2893218813453, 170.710678118655),
				   (7.6120467488713, 61.7316567634911),
				   (100.0, 0.0)); -- "Arc" curve with 5 points.
   begin
      return Pa;
   end Get_Knots_Arc_5Points;
   
   
   -- Generates test data.
   --
   -- returns : Knot points array.
   function Get_Knots_Runge_5Points return Bs.Point_Array_Type
   is
      Pa : Bs.Point_Array_Type := ((0.0, 96.1538461538462),
				   (50.0, 86.2068965517241),
				   (100.0, 0.0),
				   (150.0, 86.2068965517241),
				   (200.0, 96.1538461538462));
   begin
      return Pa;
   end Get_Knots_Runge_5Points;
   
   
   ---------------------------------
   -- GetCurveControlPoints test. --
   ---------------------------------
   procedure Get_Curve_Control_Points_Test
   is
   begin
      Tio.Put_Line ("Get_Curve_Control_Points_Test : ");
      Tio.Put_Line ("Arc_3Points");
      Get_Curve_Control_Points_Test (Get_Knots_Arc_3Points);
      Tio.Put_Line ("Arc_5Points");
      Get_Curve_Control_Points_Test (Get_Knots_Arc_5Points);
      Tio.Put_Line ("Runge_5Points");
      Get_Curve_Control_Points_Test (Get_Knots_Runge_5Points);
      Tio.Put_Line ("Test passed.");
      null;
   end Get_Curve_Control_Points_Test;
   
   
   ---------------------------------
   -- GetFirstControlPoints test. --
   ---------------------------------
   procedure Get_First_Control_Points_Test
   is
   begin
      Tio.Put_Line ("Get_First_Control_Points_Test : ");
      Tio.Put_Line ("Arc_3Points");
      Get_First_Control_Points_Test (Get_Knots_Arc_3Points);
      Tio.Put_Line ("Arc_5Points");
      Get_First_Control_Points_Test (Get_Knots_Arc_5Points);
      Tio.Put_Line ("Runge_5Points");
      Get_First_Control_Points_Test (Get_Knots_Runge_5Points);
      Tio.Put_Line ("Test passed.");
      null;
   end Get_First_Control_Points_Test;
   
					 
   
   
end Bezier_Spline_Test;
