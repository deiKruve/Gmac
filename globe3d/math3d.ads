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

with Ada.Numerics.Generic_Elementary_functions;
with Ada.Text_IO;



package Math3d is


  package REF is new Ada.Numerics.Generic_Elementary_functions (Long_Float);
  package RIO is new Ada.Text_IO.Float_IO                      (Long_Float);

  type Long_Vector_3d is array(1..3) of aliased Long_Float;

  -------------
  -- Vectors --
  -------------

  function "*"(l: Long_Float; v: Long_Vector_3D) return Long_Vector_3D;
  pragma Inline("*");

  function "*"(v: Long_Vector_3D; l: Long_Float) return Long_Vector_3D;
  pragma Inline("*");

  function "+"(a,b: Long_Vector_3D) return Long_Vector_3D;
  pragma Inline("+");

  function "-"(a: Long_Vector_3D) return Long_Vector_3D;
  -- inverts the direction of a

  function "-"(a,b: Long_Vector_3D) return Long_Vector_3D;
  -- returns the vector from b to a i sink
  
  function "-" (A,B: Long_Vector_3D) return Long_Float;
  -- returns the distance from a to b (always positive)
  
  pragma Inline("-");
  
  -- Stephenson page 318, (35)
  function "*"(a,b: Long_Vector_3D) return Long_Float;      -- dot product
  pragma Inline("*");
  
  -- Stephenson page 320, (54) --
  function "*"(a,b: Long_Vector_3D) return Long_Vector_3D; -- cross product
  pragma Inline("*");
  
  -- Stephenson page 318, (38)
  function Norm(a: Long_Vector_3D) return Long_Float;
  pragma Inline(Norm);
  
  -- Stephenson page 318, (37)
  function Norm2(a: Long_Vector_3D) return Long_Float;
  pragma Inline(Norm2);

  function Normalized(a: Long_Vector_3D) return Long_Vector_3D;


  type Vector_4D is array (1 .. 4) of Long_Float;



   -- Angles
   --

   function Angle (Point_1, Point_2, Point_3 : Long_Vector_3D) return Long_Float;
   --
   -- returns the angle between the vector Point_1 to Point_2 and the vector Point_3 to Point_2.


   function to_Degrees (Radians : Long_Float) return Long_Float;
   function to_Radians (Degrees : Long_Float) return Long_Float;


  --------------
  -- Matrices --
  --------------

  type Matrix    is array (Positive range <>, Positive range <>) of aliased Long_Float;
  type Matrix_33 is new Matrix (1..3, 1..3);
  type Matrix_44 is new Matrix (1..4, 1..4);
  --type Matrix_44 is array(0..3,0..3) of aliased Long_Float; -- for GL.MultMatrix
  --pragma Convention (Fortran, Matrix_44);                 -- GL stores matrices columnwise   -- tbd: use same convention for other matrices ?
  
  --  Stephenson page 289, (26)
  Id_33 : constant Matrix_33:= ((1.0, 0.0, 0.0),
                                (0.0, 1.0, 0.0),
                                (0.0, 0.0, 1.0));


  --  Stephenson page 286, (11, 12)
  function "*"(A,B: Matrix_33) return Matrix_33;
  
  --  Stephenson page 297, (79)
  function "*"(A: Matrix_33; x: Long_Vector_3D) return Long_Vector_3D;
  function "*"(A: Matrix_44; x: Long_Vector_3D) return Long_Vector_3D;
  function "*"(A: Matrix_44; x: Long_Vector_3D) return Vector_4D;
  
  --  Stephenson page 290, (33, 34)
  function Transpose(A: Matrix_33) return Matrix_33;
  function Transpose(A: Matrix_44) return Matrix_44;
  
  --  Stephenson page 289, section (g)
  --  Stephenson page 263, chapter 16
  function Det(A: Matrix_33) return Long_Float;

  function XYZ_rotation(ax,ay,az: Long_Float) return Matrix_33;

  function XYZ_rotation(v: Long_Vector_3D) return Matrix_33;

  -- Gives a rotation matrix that corresponds to look into a certain
  -- direction. Camera swing rotation is arbitrary.
  -- Left-multiply by XYZ_Rotation(0.0,0.0,az) to correct it.
  function Look_at(direction: Long_Vector_3D) return Matrix_33;

   function Look_at (eye, center, up : Long_Vector_3D) return Matrix_33;


  -- This is for correcting cumulation of small computational
  -- errors, making the rotation matrix no more orthogonal
  procedure Re_Orthonormalize(M: in out Matrix_33);

  -- Right-multiply current matrix by A
  --procedure Multiply_GL_Matrix( A: Matrix_33 );

  -- Impose A as current matrix
  --procedure Set_GL_Matrix( A: Matrix_33 );

  -- For replacing the " = 0.0" test which is a Bad Thing
  function Almost_zero(x: Long_Float) return Boolean;
  pragma Inline(Almost_zero);
  function Almost_zero(x: Float) return Boolean;
  pragma Inline(Almost_zero);


  function sub_Matrix (Self : in Matrix;   start_Row, end_Row : in Positive;
                                           start_Col, end_Col : in Positive) return Matrix;


end Math3d;
