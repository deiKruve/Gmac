------------------------------------------------------------------------------
--                                                                          --
--                              GMAC COMPONENTS                             --
--                                                                          --
--             C L O S E D _ B E Z I E R _ S P L I N E _ T E S T            --
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
--  <summary> Tests for Bezier_Spline class.</summary>
--

with Closed_Bezier_Spline;
with Ada.Assertions;
with Ada.Text_IO; 

package body Closed_Bezier_Spline_Test is
   package Bs renames Closed_Bezier_Spline;
   package Ass renames Ada.Assertions;
   package Tio renames Ada.Text_IO;
   
   
   -- Check for the second derivative continuity.
   --
   -- "p1"    : The first control points.
   -- "p2"    : The second control points.
   procedure Check_Second_Derivative_Continuity
     (P1    : Bs.Point_Array_Type;
      P2    : Bs.Point_Array_Type)
   is
   begin
      for I in P1'First + 1 .. P1'Last - 1 loop
	 Ass.Assert 
	   (abs ((P1 (I - 1).X + 2.0 * P1 (I).X) - (P2 (I + 1).X + 2.0 * P2 (I).X)) 
	      < 10.0e-7, "Check_Second_Derivative_Continuity X");
	 Ass.Assert 
	   (abs ((P1 (I - 1).Y + 2.0 * P1 (I).Y) - (P2 (I + 1).Y + 2.0 * P2 (I).Y)) 
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
      for I in P1'First .. P1'Last loop
	 Ass.Assert 
	   (abs (2.0 * Knots (I).X - (P1 (I).X + P2 (I).X)) 
	      < 10.0e-7, "Check_First_Derivative_Continuity X");
	 Ass.Assert 
	   (abs (2.0 * Knots (I).Y - (P1 (I).Y + P2 (I).Y)) 
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
      Ass.Assert 
	((Knots'Length > 2 and then P1'Length = Knots'Length and then P2'Length = P1'Length),
	"Check_CP_Arrays_Length");
   end Check_CP_Arrays_Length;
   
   
   -- GetFirstControlPoints method test.
   --
   -- "knots" : The knots.
   procedure Get_First_Control_Points_Test
     (Knots : Bs.Point_Array_Type)
   is
      A  : Bs.Double_Arr_Type (Knots'First .. Knots'Last) := (others => 1.0);
      B  : Bs.Double_Arr_Type (Knots'First .. Knots'Last) := (others => 4.0);
      C  : Bs.Double_Arr_Type (Knots'First .. Knots'Last) := (others => 1.0);
      Plx,
      Ply,
      Rhs : Bs.Double_Arr_Type (Knots'First .. Knots'Last);
   begin
      
      --- Right hand side X values.
      for I in Rhs'First .. Rhs'Last loop
	 if I = Rhs'Last then
	    Rhs (I) := 4.0 * Knots (I).X + 2.0 * Knots (Knots'First).X;
	 else 
	    Rhs (I) := 4.0 * Knots (I).X + 2.0 * Knots (I + 1).X;
	 end if;
      end loop;
      -- Solve the system for X.
      Plx := Bs.Cyclic_Solve (A, B, C, 1.0, 1.0, Rhs);
      
      -- First equation
      Ass.Assert (abs ((4.0 * Knots (Knots'First).X + 
			  2.0 * Knots (Knots'First + 1).X) - 
			 (Plx (Knots'Last) + 4.0 * Plx (Knots'First) + 
			    Plx (Knots'First + 1))) 
		       < 10.0e-7, "Get_First_Control_Points_Test X 1st");
      -- Intermediate equations.
      for I in Knots'First + 1 .. Knots'Last - 1 loop
	 Ass.Assert (abs ((4.0 * Knots (I).X + 2.0 * Knots (I + 1).X) - 
			    (Plx (I - 1) + 4.0 * Plx (I) + Plx (I + 1))) 
		       < 10.0e-7, "Get_First_Control_Points_Test X 2nd");
      end loop;
      -- last equation
      Ass.Assert (abs ((4.0 * Knots (Knots'Last).X + 2.0 * Knots (Knots'First).X) - 
			 (Plx (Knots'Last - 1) + 4.0 * Plx (Knots'Last) + 
			    Plx (Knots'First))) 
		    < 10.0e-7, "Get_First_Control_Points_Test X 3rd");
      
     --- Right hand side Y values.
      for I in Rhs'First .. Rhs'Last loop
	 if I = Rhs'Last then
	    Rhs (I) := 4.0 * Knots (I).Y + 2.0 * Knots (Knots'First).Y;
	 else 
	    Rhs (I) := 4.0 * Knots (I).Y + 2.0 * Knots (I + 1).Y;
	 end if;
      end loop;
      -- Solve the system for Y.
      Ply := Bs.Cyclic_Solve (A, B, C, 1.0, 1.0, Rhs);
      
      -- First equation
      Ass.Assert (abs ((4.0 * Knots (Knots'First).Y + 
			  2.0 * Knots (Knots'First + 1).Y) - 
			 (Ply (Knots'Last) + 4.0 * Ply (Knots'First) + 
			    Ply (Knots'First + 1))) 
		       < 10.0e-7, "Get_First_Control_Points_Test Y 1st");
      -- Intermediate equations.
      for I in Knots'First + 1 .. Knots'Last - 1 loop
	 Ass.Assert (abs ((4.0 * Knots (I).Y + 2.0 * Knots (I + 1).Y) - 
			    (Ply (I - 1) + 4.0 * Ply (I) + Ply (I + 1))) 
		       < 10.0e-7, "Get_First_Control_Points_Test Y 2nd");
      end loop;
      -- last equation
      Ass.Assert (abs ((4.0 * Knots (Knots'Last).Y + 2.0 * Knots (Knots'First).Y) - 
			 (Ply (Knots'Last - 1) + 4.0 * Ply (Knots'Last) + 
			    Ply (Knots'First))) 
		    < 10.0e-7, "Get_First_Control_Points_Test Y 3rd");
   end Get_First_Control_Points_Test;
   
   
   -- GetCurveControlPoints method test.
   procedure Get_Curve_Control_Points_Test
     (Knots : Bs.Point_Array_Type)     
   is
      P1,
      P2    : Bs.Point_Array_Type (Knots'First .. Knots'Last);
   begin
      Bs.Get_Curve_Control_Points (Knots, P1, P2);
      Check_CP_Arrays_Length (Knots , P1, P2);
      if (Knots'Length < 3) then
	 return;
      end if;
      Check_First_Derivative_Continuity (Knots, P1, P2);
      Check_Second_Derivative_Continuity (P1, P2);
      --Check_Boundary_Conditions (Knots, P1, P2);
      Bs.Plot_Bez_Spline (Knots, P1, P2, 5.0);---------------------------------
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
   
			
   
   
   
end Closed_Bezier_Spline_Test;
