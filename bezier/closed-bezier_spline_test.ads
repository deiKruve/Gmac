------------------------------------------------------------------------------
--                                                                          --
--                              GMAC COMPONENTS                             --
--                                                                          --
--             C L O S E D _ B E Z I E R _ S P L I N E _ T E S T            --
--                                                                          --
--                                  S p e c                                 --
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

package Closed_Bezier_Spline_Test is
   
   -- GetCurveControlPoints method test.
   procedure Get_Curve_Control_Points_Test;
   
   -- GetFirstControlPoints method test.
   procedure Get_First_Control_Points_Test;
   
   
   
end Closed_Bezier_Spline_Test;
