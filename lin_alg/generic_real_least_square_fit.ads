------------------------------------------------------------------------------
--                                                                          --
--                             GMAC COMPONENTS                              --
--                                                                          --
--         G E N E R I C _ R E A L _ L E A S T _ S Q U A R E _ F I T        --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--         Copyright (C) 1983-2014, Free Software Foundation, Inc.          --
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
--                  Gmac is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
--  Generic_Real_Least_Square_Fit  is written by JON SQUIRE , 27 FEB 1983   --
--                  Modified for ADA 2012 by jan de Kruijf.                 --
------------------------------------------------------------------------------
--

with Ada.Numerics.Generic_Real_Arrays;

generic
   type Real is digits <>;
package Generic_Real_Least_Square_Fit is
   package Gra is new Ada.Numerics.Generic_Real_Arrays (Real);

   subtype Real_Polynomial is Gra.Real_Vector;

   Array_Index_Error : exception;

-- The purpose of this package is to provide a reliable and convenient
-- means for fitting existing data by a few coefficients. The companion
-- package check_fit provides the means to use the coefficients for
-- interpolation and limited extrapolation.
--
-- This package implements the least square fit.
--
-- The problem is stated as follows :
--   Given measured data for values of Y based on values of X1,X2 and X3. e.g.
--
--    Y_actual         X1      X2     X3
--    --------       -----   -----  -----
--     32.5           1.0     2.5    3.7
--      7.2           2.0     2.5    3.6
--      6.9           3.0     2.7    3.5
--     22.4           2.2     2.1    3.1
--     10.4           1.5     2.0    2.6
--     11.3           1.6     2.0    3.1
--
--  Find a, b and c such that   Y_approximate =  a * X1 + b * X2 + c * X3
--  and such that the sum of (Y_actual - Y_approximate) squared is minimized.
--
-- The method for determining the coefficients a, b and c follows directly
-- form the problem definition and mathematical analysis. (See more below)
--
-- Y is called the dependent variable and X1 .. Xn the independent variables.
-- The procedures below implements a few special cases and the general case.
--    The number of independent variables can vary.
--    The approximation equation may use powers of the independent variables
--    The user may create additional independent variables e.g. X2 = SIN(X1)
--    with the restriction that the independent variables are linearly
--    independent.  e.g.  Xi not equal  p Xj + q  for all i,j,p,q
--
--
--
-- The mathematical derivation of the least square fit is as follows :
--
-- Given data for the independent variable Y in terms of the dependent
-- variables S,T,U and V  consider that there exists a function F
-- such that     Y = F(S,T,U,V)
-- The problem is to find coefficients a,b,c and d such that
--            Y_approximate = a * S + b * T + c * U + d * V
-- and such that the sum of ( Y - Y_approximate ) squared is minimized.
--
-- Note: a, b, c, d are scalars. S, T, U, V, Y, Y_approximate are vectors.
--
-- To find the minimum of  SUM( Y - Y_approximate ) ** 2
-- the derivatives must be taken with respect to a,b,c and d and
-- all must equal zero simultaneously. The steps follow :
--
--  SUM( Y - Y_approximate ) ** 2 = SUM( Y - a*S - b*T - c*U - d*V ) ** 2
--
-- d/da =  -2 * S * SUM( Y - A*S - B*T - C*U - D*V )
-- d/db =  -2 * T * SUM( Y - A*S - B*T - C*U - D*V )
-- d/dc =  -2 * U * SUM( Y - A*S - B*T - C*U - D*V )
-- d/dd =  -2 * V * SUM( Y - A*S - B*T - C*U - D*V )
--
-- Setting each of the above equal to zero and putting constant term on left
--    the -2 is factored out,
--    the independent variable is moved inside the summation
--
--  SUM( a*S*S + b*S*T + c*S*U + d*S*V = S*Y )
--  SUM( a*T*S + b*T*T + c*T*U + d*T*V = T*Y )
--  SUM( a*U*S + b*U*T + c*U*U + d*U*V = U*Y )
--  SUM( a*V*S + b*V*T + c*V*U + d*V*V = V*Y )
--
-- Distributing the SUM inside yields
--
--  a * SUM(S*S) + b * SUM(S*T) + c * SUM(S*U) + d * SUM(S*V) = SUM(S*Y)
--  a * SUM(T*S) + b * SUM(T*T) + c * SUM(T*U) + d * SUM(T*V) = SUM(T*Y)
--  a * SUM(U*S) + b * SUM(U*T) + c * SUM(U*U) + d * SUM(U*V) = SUM(U*Y)
--  a * SUM(V*S) + b * SUM(V*T) + c * SUM(V*U) + d * SUM(V*V) = SUM(V*Y)
--
-- To find the coefficients a,b,c and d solve the linear system of equations
--
--    | SUM(S*S)  SUM(S*T)  SUM(S*U)  SUM(S*V) |   | a |   | SUM(S*Y) |
--    | SUM(T*S)  SUM(T*T)  SUM(T*U)  SUM(T*V) | x | b | = | SUM(T*Y) |
--    | SUM(U*S)  SUM(U*T)  SUM(U*U)  SUM(U*V) |   | c |   | SUM(U*Y) |
--    | SUM(V*S)  SUM(V*T)  SUM(V*U)  SUM(V*V) |   | d |   | SUM(V*Y) |
--
-- Some observations :
--     S,T,U and V must be linearly independent.
--     There must be more data sets (Y, S, T, U, V) than variables.
--     The analysis did not depend on the number of independent variables
--     A polynomial fit results from the substitutions S=1, T=X, U=X**2, V=X**3
--     The general case for any order polynomial follows, fit_pn.
--     Any substitution such as three variables to various powers may be used.
--

   -------------------------------
   --                Y = C * X  --
   -------------------------------
   procedure Fit (Y, X :     Gra.Real_Vector; 
		  C    : out Real);

   -------------------------------------------
   --                Y = C1 * X1 + C2 * X2  --
   -------------------------------------------
   procedure Fit (Y, X1, X2 :     Gra.Real_Vector; 
		  C1, C2    : out Real);

   -----------------------------------------------------
   --                Y = C1 * X1 + C2 * X2 + C3 * X3  --
   -----------------------------------------------------
   procedure Fit (Y, X1, X2, X3 :     Gra.Real_Vector; 
		  C1, C2, C3    : out Real);

   ---------------------------------------------------------------
   --                Y = C1 * X1 + C2 * X2 + C3 * X3 + C4 * X4  --
   ---------------------------------------------------------------
   procedure Fit
     (Y, X1, X2, X3, X4 :     Gra.Real_Vector;
      C1, C2, C3, C4    : out Real);

   ---------------------------------------------------------------------
   --                Y = EVALUATE ( C , X )                           --
   --                Y = C(0) + C(1)*X + C(2)*X**2 + C(3)*X**3 + ...  --
   --                    to  C(C'LAST)*X**C'LAST                      --
   ---------------------------------------------------------------------
   procedure Fit (Y, X :     Gra.Real_Vector; 
		  C    : out Real_Polynomial);

   -------------------------------------------------------------------------
   --                Y = C11 * X1 + C12 * X1**2 + C21 * X2 + C22 * X2**2  --
   -------------------------------------------------------------------------
   procedure Fit (Y, X1, X2          :     Gra.Real_Vector; 
		  C11, C12, C21, C22 : out Real);

   --------------------------------------------------
   --                Y = C11 * X1 + C12 * X1**2 +  --
   --                    C21 * X2 + C22 * X2**2 +  --
   --                    C31 * X3 + C32 * X3**2    --
   --------------------------------------------------
   procedure Fit
     (Y, X1, X2, X3                :     Gra.Real_Vector;
      C11, C12, C21, C22, C31, C32 : out Real);

   ----------------------------------------------------------------
   --                Y = C11 * X1 + C12 * X1**2 + C13 * X1**3 +  --
   --                    C21 * X2 + C22 * X2**2 + C23 * X2**3    --
   ----------------------------------------------------------------
   procedure Fit
     (Y, X1, X2                    :     Gra.Real_Vector;
      C11, C12, C13, C21, C22, C23 : out Real);

   -----------------------------------------------------------------------
   --                Y = C(1,1)*X1 + C(1,2)*X1**2 + C(1,3)*X1**3 + ...  --
   --                    to  C(1,C'LAST)*X1**C'LAST + ...               --
   --                    C(2,1)*X2 + C(2,2)*X2**2 + C(2,3)*X2**3 + ...  --
   --                    to  C(2,C'LAST)*X2**C'LAST                     --
   -----------------------------------------------------------------------
   procedure Fit (Y, X1, X2 :        Gra.Real_Vector; 
		  C         : in out Gra.Real_Matrix);

   -----------------------------------------------------------------------
   --                Y = C(1,1)*X1 + C(1,2)*X1**2 + C(1,3)*X1**3 + ...  --
   --                    to  C(1,C'LAST)*X1**C'LAST + ...               --
   --                    C(2,1)*X2 + C(2,2)*X2**2 + C(2,3)*X2**3 + ...  --
   --                    to  C(2,C'LAST)*X2**C'LAST + ...               --
   --                    C(3,1)*X3 + C(3,2)*X3**2 + C(3,3)*X3**3 + ...  --
   --                    to  C(3,C'LAST)*X3**C'LAST                     --
   -----------------------------------------------------------------------
   procedure Fit (Y, X1, X2, X3 :        Gra.Real_Vector; 
		  C             : in out Gra.Real_Matrix);

   -----------------------------------------------------------------------
   --                Y = C(1,1)*X1 + C(1,2)*X1**2 + C(1,3)*X1**3 + ...  --
   --                    to  C(1,C'LAST)*X1**C'LAST + ...               --
   --                    C(2,1)*X2 + C(2,2)*X2**2 + C(2,3)*X2**3 + ...  --
   --                    to  C(2,C'LAST)*X2**C'LAST + ...               --
   --                    C(3,1)*X3 + C(3,2)*X3**2 + C(3,3)*X3**3 + ...  --
   --                    to  C(3,C'LAST)*X3**C'LAST + ...               --
   --                    C(4,1)*X4 + C(4,2)*X4**2 + C(4,3)*X3**3 + ...  --
   --                    to  C(4,C'LAST)*X4**C'LAST                     --
   -----------------------------------------------------------------------
   procedure Fit
     (Y, X1, X2, X3, X4 :        Gra.Real_Vector;
      C                 : in out Gra.Real_Matrix);

   ------------------------------------------------------------------------------
   --                Y(K) = C(I,J) * X(I,K) ** J  summed over I in C'RANGE(1)  --
   --                                             over J in C'RANGE(2)         --
   ------------------------------------------------------------------------------
   procedure Fit
     (Y :        Gra.Real_Vector;
      X :        Gra.Real_Matrix;
      C : in out Gra.Real_Matrix);

end Generic_Real_Least_Square_Fit;
