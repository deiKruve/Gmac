------------------------------------------------------------------------------
--                                                                          --
--                            POST COMPONENTS                               --
--                                                                          --
--                              M A T H 3 D                                 --
--                                                                          --
--                                 B o d y                                  --
--                                        
--  this is a modified copy of the module found in
--  GLOBE_3D - GL-based, real-time, 3D engine
--
--  Copyright (c) Gautier de Montmollin 2001..2012
--  SWITZERLAND
--  Copyright (c) Rod Kay 2006..2008
--  AUSTRALIA
--
--  Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  in the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is
--  furnished to do so, subject to the following conditions:

--  The above copyright notice and this permission notice shall be included in
--  all copies or substantial portions of the Software.

--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
--  THE SOFTWARE.

-- NB: this is the MIT License, as found 12-Sep-2007 on the site
-- http://www.opensource.org/licenses/mit-license.php

------------------------------------------------------------------------------
--                                                                          --
--                  Post is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--


with Text_Io; 
with Ada.Text_IO;
with GNATCOLL.Traces;

package body Math3d is
   package Gct renames GNATCOLL.Traces;
   package Tio    renames Text_Io; 
   
   package Pvio  is new Ada.Text_IO.Float_IO (Num => Long_Float);
   
   use REF;
   
   Stream1   : constant Gct.Trace_Handle := Gct.Create ("MATH3D");
   Stream2   : constant Gct.Trace_Handle := Gct.Create ("MATH3D.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("MATH3D.DEBUG");
   
   
   procedure Debug_Print_Vector (V : Math3d.Long_Vector_3d)
   is
   begin
      Tio.Put (" mX");
      Pvio.Put (V(1), 4, 3, 0);
      Tio.Put (" mY");
      Pvio.Put (V(2), 4, 3, 0);
      Tio.Put (" mZ");
      Pvio.Put (V(3), 4, 3, 0);
      Tio.Put_Line (" in math3d");
   end Debug_Print_Vector;

  -------------
  -- Vectors --
  -------------

  function "*"(L: Long_Float; v: Long_Vector_3D) return Long_Vector_3D 
  is
  begin
    return (L * v(1), L * v(2), L * v(3));
  end "*";

  function "*"(v: Long_Vector_3D; l: Long_Float) return Long_Vector_3D is
  begin
    return (L * v(1), L * v(2), L * v(3));
  end "*";
  
  function "+"(a,b: Long_Vector_3D) return Long_Vector_3D is
  begin
    return (a(1) + b(1), a(2) + b(2), a(3) + b(3));
  end "+";
  
  function "-"(a: Long_Vector_3D) return Long_Vector_3D is
  begin
    return (-a(1), -a(2), -a(3));
  end "-";

  function "-"(a,b: Long_Vector_3D) return Long_Vector_3D is
  begin
    return (a(1) - b(1), a(2) - b(2), a(3) - b(3));
  end "-";
  
  -- distance (or magnitude of the vector) from a to b
  function "-" (A,B: Long_Vector_3D) return Long_Float 
  is
  begin
     return Sqrt 
       ((B(1) - A(1)) ** 2 + (B(2) - A(2)) ** 2 + (B(3) - A(3)) ** 2);
  end "-";
  
  
  -- scalar product
  function "*"(a,b: Long_Vector_3D) return Long_Float is      -- dot product
  begin
    return a(1) * b(1) + a(2) * b(2) + a(3) * b(3);
  end "*";
  
  -- vector product
  function "*"(a,b: Long_Vector_3D) return Long_Vector_3D is -- cross product
  begin
    return ( a(2) * b(3) - a(3) * b(2),
             a(3) * b(1) - a(1) * b(3),
             a(1) * b(2) - a(2) * b(1) );
  end "*";
  
  
  
  -- length from origin
  function Norm(a: Long_Vector_3D) return Long_Float is
  begin
    return Sqrt(a(1)*a(1)+a(2)*a(2)+a(3)*a(3));
  end Norm;
  
  -- length from origin squared
  function Norm2(a: Long_Vector_3D) return Long_Float is
  begin
    return a(1)*a(1)+a(2)*a(2)+a(3)*a(3);
  end Norm2;
  
  
  function Normalized(a: Long_Vector_3D) return Long_Vector_3D is
  begin
    return a * (1.0 / Norm(a));
  end Normalized;
  
  pragma Inline ("*", "+", "-");
  pragma Inline (Norm, Norm2, Normalized);
  


   -- Angles
   --


   function Angle (Point_1, Point_2, Point_3 : Long_Vector_3D) return Long_Float
   is
      Vector_1  : constant Long_Vector_3D := Normalized (Point_1 - Point_2);
      Vector_2  : constant Long_Vector_3D := Normalized (Point_3 - Point_2);
      Cos_Theta : constant Long_Float     := Vector_1 * Vector_2; --dotp
      --  V1, V2  : Long_Vector_3D;
      --  L1, L2, L3, L4,
      --  	Cos_Theta : Long_Float;
   begin
      --  V1 := Point_1 - Point_2;
      --  V2 := Point_3 - Point_2;
      --  L1 := Point_1 - Point_2;
      --  L2 := Point_3 - Point_2;
      --  L3 := (V1 * V2);
      --  L4 := (L1 * L2);
      --  Cos_Theta := (V1 * V2) / (L1 * L2);
      if Cos_Theta /= Cos_Theta then
	 Gct.Trace (Debug_Str, "cos_theta is NaN******");
      else
	 Gct.Trace (Debug_Str, "cos_theta : " & Long_Float'Image (Cos_Theta)); 
      end if;
      if Cos_Theta /= Cos_Theta or cos_Theta >= 1.0 then
         return 4.0 * Ada.numerics.Pi;
      else
         return arcCos (cos_Theta);
      end if;

   end;





   function to_Degrees (Radians : Long_Float) return Long_Float
   is
   begin
      return Radians * 180.0 / Ada.Numerics.Pi;
   end;




   function to_Radians (Degrees : Long_Float) return Long_Float
   is
   begin
      return Degrees * Ada.Numerics.Pi / 180.0;
   end;

   pragma Inline (Angle, To_Degrees, To_Radians);



  --------------
  -- Matrices --
  --------------

  function "*"(A,B: Matrix_33) return Matrix_33 is
    r: Long_Float; AB: Matrix_33;
  begin
    for i in 1..3 loop
      for j in 1..3 loop
        r:= 0.0;
        for k in 1..3 loop
          r:= r + (A(i,k) * B(k,j));
        end loop;
        AB(i,j):= r;
      end loop;
    end loop;
    return AB;
  end "*";


  -- solution of linear equations
  function "*"(A: Matrix_33; x: Long_Vector_3D) return Long_Vector_3D is
    r: Long_Float;
    Ax: Long_Vector_3D;
    -- banana skin: Matrix has range 1..3, Vector 0..2 (GL)
    -- no bananaskin anymore (jdk)
  begin
    for i in 1..3 loop
      r:= 0.0;
      for j in 1..3 loop
	 --r:= r + A(i,j) * x(j-1);
	 r:= r + A(i,j) * x(J);
      end loop;
      --Ax(i-1):= r;
      Ax(I) := R;
    end loop;
    return Ax;
  end "*";



  function "*"(A: Matrix_44; x: Long_Vector_3D) return Long_Vector_3D is
    r: Long_Float;

      type Vector_4D is array (0..3) of Long_Float;
      x_4D : constant Vector_4D := (x(1), x(2), x(3) , 1.0);
      Ax   : Vector_4D;

      -- banana skin: Matrix has range 1..3, Vector 0..2 (GL)
      -- no banana skin, jdk
  begin
    for i in 1..4 loop
      r:= 0.0;
      for j in 1..4 loop
          r:= r + A(i,j) * x_4D(j);
      end loop;
      Ax(i):= r;
    end loop;
    return (Ax (1), Ax (2), Ax(3));
  end "*";




  function "*"(A: Matrix_44; x: Long_Vector_3D) return Vector_4D is
    r: Long_Float;

      x_4D : constant Vector_4D := (x(1), x(2), x(3) , 1.0);
      Ax   : Vector_4D;

      -- banana skin: Matrix has range 1..3, Vector 0..2 (GL)
      -- no banana skin, jdk
  begin
    for i in 1..4 loop
      r:= 0.0;
      for j in 1..4 loop
          r:= r + A(i,j) * x_4D(j);
      end loop;
      Ax(i):= r;
    end loop;
    return Ax;
  end "*";


  function Transpose(A: Matrix_33) return Matrix_33 is
  begin
    return ( (a(1,1), a(2,1), a(3,1)),
             (a(1,2), a(2,2), a(3,2)),
             (a(1,3), a(2,3), a(3,3)));
  end Transpose;


  function Transpose(A: Matrix_44) return Matrix_44 is
  begin
    return ( (a(1,1),a(2,1),a(3,1),a(4,1)),
             (a(1,2),a(2,2),a(3,2),a(4,2)),
             (a(1,3),a(2,3),a(3,3),a(4,3)),
             (a(1,4),a(2,4),a(3,4),a(4,4)));
  end Transpose;


  function Det(A: Matrix_33) return Long_Float is
  begin
    return
      a(1,1) * a(2,2) * a(3,3) +
      a(2,1) * a(3,2) * a(1,3) +
      a(3,1) * a(1,2) * a(2,3) -
      a(3,1) * a(2,2) * a(1,3) -
      a(2,1) * a(1,2) * a(3,3) -
      a(1,1) * a(3,2) * a(2,3);
  end Det;

  function XYZ_rotation(ax,ay,az: Long_Float) return Matrix_33 is
    Mx, My, Mz: Matrix_33; c,s: Long_Float;
  begin
    -- Around X
    c:= Cos( ax );
    s:= Sin( ax );
    Mx:= ( (1.0,0.0,0.0),
           (0.0,  c, -s),
           (0.0,  s,  c) );
    -- Around Y
    c:= Cos( ay );
    s:= Sin( ay );
    My:= ( (  c,0.0, -s),
           (0.0,1.0,0.0),
           (  s,0.0,  c) );
    -- Around Z
    c:= Cos( az );
    s:= Sin( az );
    Mz:= ( (  c, -s,0.0),
           (  s,  c,0.0),
           (0.0,0.0,1.0) );
    return Mz * My * Mx;
  end XYZ_rotation;
  
  
  function XYZ_rotation(v: Long_Vector_3D) return Matrix_33 
  is
  begin
    return XYZ_rotation(v(1),v(2),v(3));
  end XYZ_rotation;
  
  
  function Look_at(direction: Long_Vector_3D) return Matrix_33 
  is
    v1, v2, v3: Long_Vector_3D;
  begin
    -- GL's look direction is the 3rd dimension (z)
    v3:= Normalized(direction);
    v2:= Normalized((v3(3),0.0,-v3(1)));
    v1:= v2 * v3;
    return
      (((v1(1), v2(1), v3(1)),
        (v1(2), v2(2), v3(2)),
        (v1(3), v2(3), v3(3))
      ));
  end Look_at;




  function sub_Matrix (Self : in Matrix;   
		       start_Row, end_Row : in Positive;
		       start_Col, end_Col : in Positive) return Matrix
   is
      the_sub_Matrix : Matrix (1 .. end_Row - start_Row + 1,
                               1 .. end_Col - start_Col + 1);
   begin
      for Row in the_sub_Matrix'range (1) loop
         for Col in the_sub_Matrix'range (2) loop
            the_sub_Matrix (Row, Col) := self (Row + start_Row - 1,
                                               Col + start_Col - 1);
         end loop;
      end loop;

      return the_sub_Matrix;
   end;


   function Look_at (eye, center, up : Long_Vector_3D) return Matrix_33
   is
      forward : constant Long_Vector_3D := 
	Normalized ((center (1) - eye (1), 
		     center (2) - eye (2),  center (3) - eye (3)));
      side    : constant Long_Vector_3D := Normalized (forward * up);
      new_up  : constant Long_Vector_3D := side * forward;
   begin
      return (( side    (1),    side    (2),    side    (3)),
              ( new_up  (1),    new_up  (2),    new_up  (3)),
              (-forward (1),   -forward (2),   -forward (3)));
   end;


  -- Following procedure is from Project Spandex, by Paul Nettle
  procedure Re_Orthonormalize(M: in out Matrix_33) is
    dot1,dot2,vlen: Long_Float;
  begin
    dot1:= m(1,1) * m(2,1) + m(1,2) * m(2,2) + m(1,3) * m(2,3);
    dot2:= m(1,1) * m(3,1) + m(1,2) * m(3,2) + m(1,3) * m(3,3);

    m(1,1) := m(1,1) - dot1 * m(2,1) - dot2 * m(3,1);
    m(1,2) := m(1,2) - dot1 * m(2,2) - dot2 * m(3,2);
    m(1,3) := m(1,3) - dot1 * m(2,3) - dot2 * m(3,3);

    vlen:= 1.0 / Sqrt(m(1,1) * m(1,1) +
                      m(1,2) * m(1,2) +
                      m(1,3) * m(1,3));

    m(1,1):= m(1,1) * vlen;
    m(1,2):= m(1,2) * vlen;
    m(1,3):= m(1,3) * vlen;

    dot1:= m(2,1) * m(1,1) + m(2,2) * m(1,2) + m(2,3) * m(1,3);
    dot2:= m(2,1) * m(3,1) + m(2,2) * m(3,2) + m(2,3) * m(3,3);

    m(2,1) := m(2,1) - dot1 * m(1,1) - dot2 * m(3,1);
    m(2,2) := m(2,2) - dot1 * m(1,2) - dot2 * m(3,2);
    m(2,3) := m(2,3) - dot1 * m(1,3) - dot2 * m(3,3);

    vlen:= 1.0 / Sqrt(m(2,1) * m(2,1) +
                      m(2,2) * m(2,2) +
                      m(2,3) * m(2,3));

    m(2,1):= m(2,1) * vlen;
    m(2,2):= m(2,2) * vlen;
    m(2,3):= m(2,3) * vlen;

    m(3,1):= m(1,2) * m(2,3) - m(1,3) * m(2,2);
    m(3,2):= m(1,3) * m(2,1) - m(1,1) * m(2,3);
    m(3,3):= m(1,1) * m(2,2) - m(1,2) * m(2,1);
  end Re_Orthonormalize;

--    type Matrix_44 is array(0..3,0..3) of aliased Long_Float; -- for GL.MultMatrix
--    pragma Convention(Fortran, Matrix_44);  -- GL stores matrices columnwise

  -- M: Matrix_44;
  -- M is a global variable for a clean 'Access and for setting once 4th dim
  -- pM: constant GL.doublePtr:= M (1, 1)'Unchecked_Access;

  --  procedure Multiply_GL_Matrix( A: Matrix_33 ) is
  --  begin
  --    for i in 1..3 loop
  --      for j in 1..3 loop
  --        M(i,j):= A(i,j);
  --        --  Funny deformations...
  --        --  if j=2 then
  --        --    M(i-1,j-1):= 0.5 * A(i,j);
  --        --  end if;
  --      end loop;
  --    end loop;
  --    GL.MultMatrixd(pM);
  --  end Multiply_GL_Matrix;

  --  procedure Set_GL_Matrix( A: Matrix_33 ) is
  --  begin
  --    GL.LoadIdentity;
  --    Multiply_GL_Matrix( A );
  --  end Set_GL_Matrix;

  -- Ada 95 Quality and Style Guide, 7.2.7:
  -- Tests for
  --
  -- (1) absolute "equality" to 0 in storage,
  -- (2) absolute "equality" to 0 in computation,
  -- (3) relative "equality" to 0 in storage, and
  -- (4) relative "equality" to 0 in computation:
  --
  --  abs X <= Float_Type'Model_Small                      -- (1)
  --  abs X <= Float_Type'Base'Model_Small                 -- (2)
  --  abs X <= abs X * Float_Type'Model_Epsilon            -- (3)
  --  abs X <= abs X * Float_Type'Base'Model_Epsilon       -- (4)

  function Almost_zero(x: Long_Float) return Boolean is
  begin
    return  abs X <= Long_Float'Base'Model_Small;
  end Almost_zero;

  function Almost_zero(x: Float) return Boolean is
  begin
    return  abs X <= Float'Base'Model_Small;
  end Almost_zero;
  
  pragma Inline 
    (Transpose, Det, XYZ_Rotation, Look_At, Sub_Matrix, Almost_zero);
  
begin
  --  for i in 1..3 loop
  --    M(i,4):= 0.0;
  --    M(4,i):= 0.0;
  --  end loop;
  --  M(4,4):= 1.0;
   null;
end Math3d;
