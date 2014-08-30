-- least_square_fit.adb  tailorable code, provide your input and setup


with Ada.text_io;
use  Ada.text_io;
with Ada.Numerics;
use  Ada.Numerics;
with Ada.Numerics.Long_Elementary_Functions;
use  Ada.Numerics.Long_Elementary_Functions;
with real_arrays;
use  real_arrays;

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
-- d/da =  -2 * S * SUM( Y - a*S - b*T - c*U - d*V )
-- d/db =  -2 * T * SUM( Y - a*S - b*T - c*U - d*V )
-- d/dc =  -2 * U * SUM( Y - a*S - b*T - c*U - d*V )
-- d/dd =  -2 * V * SUM( Y - a*S - b*T - c*U - d*V )
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

procedure least_square_fit is
  n : integer;
  A : real_matrix(1..50,1..50);
  C : real_vector(1..50);
  Y : real_vector(1..50);
  rms_err, avg_err, max_err : real;
  idata : integer := 0; -- data pair index used by data_set
  have_data : boolean := true; -- returned by data_set

  package fltio is new float_io(long_float);
  use fltio;
  package intio is new integer_io(integer);
  use intio;

  procedure data_set(y : out real;             -- a   y  value
                     x : out real;             -- an  x  value
                     data : in out boolean) is -- returns true for data
                                               -- starts over if false
    k : integer := 100; -- data values
    -- idata  static
    x1 : real := 0.0;
    dx1 : real := 0.0314; -- approx Pi
    xx : real;
    yy : real;
  begin
    idata := idata+1;
    if idata>k then
      idata := 0;
      data := false;
      return;     -- ready for check
    end if;
    xx := x1 + real(idata) * dx1;
    yy := exp(xx)*sin(xx);
    x := xx;
    y := yy;
  end data_set;

  procedure simeq(n: Integer; -- tailored version for this code
                  A : real_matrix; -- (1..,1..) array
                  Y : real_vector; -- (1..) vector
                  X : out real_vector) is
    B : real_matrix(1..n,1..n+1);  -- working matrix
    row : array(1..n) of integer;  -- row interchange indicies
    hold, i_pivot : integer;       -- pivot indicies
    pivot : real;                  -- pivot element value
    abs_pivot : real;              -- abs of pivot element
    norm1 : real := 0.0;           -- 1 norm of matrix
    matrix_data_error : exception;
  begin
    for i in 1..n loop
      for j in 1..n loop
        B(i,j) := A(i,j);
        if abs B(i,j) > norm1 then
          norm1 := abs B(i,j);
        end if;
      end loop;
      B(i,n+1) := Y(i);
    end loop;
    for k in 1..n loop
      row(k) := k;
    end loop;
    for k in 1..n loop
      pivot := B(row(k),k);
      abs_pivot := abs pivot;
      i_pivot := k;
      for i in k..n loop
        if abs B(row(i),k) > abs_pivot then
          i_pivot := i;
          pivot := B(row(i),k);
          abs_pivot := abs pivot;
        end if;
      end loop;
      if abs_pivot < real'epsilon * norm1 then
        raise matrix_data_error;
      end if;
      hold := row(k);
      row(k) := row(i_pivot);
      row(i_pivot) := hold;
      for j in k+1..n+1 loop
        B(row(k),j) := B(row(k),j)/B(row(k),k);
      end loop;
      for i in 1..n loop
        if i /= k then
          for j in k+1..n+1 loop
            B(row(i),j) := B(row(i),j) - B(row(i),k)*B(row(k),j);
          end loop;
        end if;
      end loop;
    end loop;
    for i in 1..n loop
      X(i) := B(row(i),n+1);
    end loop;
  end simeq;

  procedure fit_pn(n : integer; A : in out real_matrix;
                                Y : in out real_vector;
                                C : in out real_vector) is
    xx, yy : real;
    pwr : real_vector(1..2*n);
  begin
    for i in 1..n loop
      for j in 1..n loop
        A(i,j) := 0.0;
      end loop;
      Y(i) := 0.0;
    end loop;
    have_data := true;
    while have_data loop
      data_set(yy, xx, have_data);
      if not have_data then exit; end if;
      pwr(1) := 1.0;
      for i in 2..2*n loop
        pwr(i) := pwr(i-1)*xx;
      end loop;
      for i in 1..n loop
        for j in 1..n loop
          A(i,j) := A(i,j) + pwr(i)*pwr(j);
        end loop;
        Y(i) := Y(i) + yy*pwr(i);
      end loop;
    end loop; -- on while
    simeq(n, A, Y, C);
    for i in 1..n loop
      put("C(");
      put(i,4);
      put(")=");
      put(C(i),3,4);
      new_line;
    end loop;
  end fit_pn;

  procedure check_pn(n : integer;
                     C : real_vector;
                     rms_err : out real;
                     avg_err : out real;
                     max_err : out real) is
    x, y, ya, diff : real;
    sumsq : real := 0.0;
    sum : real := 0.0;
    maxe : real := 0.0;
    xmin, xmax, ymin, ymax, xbad, ybad : real;
    k, imax : integer;
  begin
    k := 0;
    have_data := true;
    while have_data loop
      data_set(y, x, have_data);
      if not have_data then exit; end if;
      if k=0 then
        xmin := x;
        xmax := x;
        ymin := y;
        ymax := y;
        imax := 1;
        xbad := x;
        ybad := y;
      end if;
      if x>xmax then xmax := x; end if;
      if x<xmin then xmin := x; end if;
      if y>ymax then ymax := y; end if;
      if y<ymin then ymin := y; end if;
      k := k + 1;
      ya := C(n)*x;
      for i in reverse 2..n-1 loop
        ya :=(C(i)+ya)*x;
      end loop;
      ya := ya + C(1);
      diff := abs(y-ya);
      if diff>maxe then
        maxe := diff;
        imax := k;
        xbad := x;
        ybad := y;
      end if;
      sum := sum + diff;
      sumsq := sumsq + diff*diff;
    end loop; -- on while
    put("check_pn k=");
    put(k,3);
    new_line;
    put("xmin=");
    put(xmin,3,3);
    put(", xmax=");
    put(xmax,3,3);
    put(", ymin=");
    put(ymin,3,3);
    put(", ymax=");
    put(ymax,3,3);
    new_line;
    max_err := maxe;
    avg_err := sum/real(k);
    rms_err := sqrt(sumsq/real(k));
    put("max=");
    put(maxe,3,4);
    put(" at ");
    put(imax,3);
    put(", xbad=");
    put(xbad,3,3);
    put(", ybad=");
    put(ybad,3,3);
    new_line;
  end check_pn;

begin
  put_line("least_square_fit.adb");

  -- sample polynomial least square fit, 3th power
  n := 3+1; -- need constant term and five powers 1,2,3,4,5
  put("fit exp(x)*sin(x) 100 points 0.0 to Pi, ");
  put(n-1,3);
  put_line(" degree polynomial");
  fit_pn(n, A, Y, C);
  check_pn(n, C, rms_err, avg_err, max_err);
  put("rms_err=");
  put(rms_Err,3,4);
  put(", avg_err=");
  put(avg_Err,3,4);
  put(", max_err=");
  put(max_Err,3,4);
  new_line;
  new_line;

  n := 4+1; -- need constant term and five powers 1,2,3,4,5
  put("fit exp(x)*sin(x) 100 points 0.0 to Pi, ");
  put(n-1,3);
  put_line(" degree polynomial");
  fit_pn(n, A, Y, C);
  check_pn(n, C, rms_err, avg_err, max_err);
  put("rms_err=");
  put(rms_Err,3,4);
  put(", avg_err=");
  put(avg_Err,3,4);
  put(", max_err=");
  put(max_Err,3,4);
  new_line;
  new_line;

  n := 5+1;
  put("fit exp(x)*sin(x) 100 points 0.0 to Pi, ");
  put(n-1,3);
  put_line(" degree polynomial");
  fit_pn(n, A, Y, C);
  check_pn(n, C, rms_err, avg_err, max_err);
  put("rms_err=");
  put(rms_Err,3,4);
  put(", avg_err=");
  put(avg_Err,3,4);
  put(", max_err=");
  put(max_Err,3,4);
  new_line;
  new_line;

  n := 6+1;
  put("fit exp(x)*sin(x) 100 points 0.0 to Pi, ");
  put(n-1,3);
  put_line(" degree polynomial");
  fit_pn(n, A, Y, C);
  check_pn(n, C, rms_err, avg_err, max_err);
  put("rms_err=");
  put(rms_Err,3,4);
  put(", avg_err=");
  put(avg_Err,3,4);
  put(", max_err=");
  put(max_Err,3,4);
  new_line;
  new_line;

  n := 7+1;
  put("fit exp(x)*sin(x) 100 points 0.0 to Pi, ");
  put(n-1,3);
  put_line(" degree polynomial");
  fit_pn(n, A, Y, C);
  check_pn(n, C, rms_err, avg_err, max_err);
  put("rms_err=");
  put(rms_Err,3,4);
  put(", avg_err=");
  put(avg_Err,3,4);
  put(", max_err=");
  put(max_Err,3,4);
  new_line;

end Least_Square_Fit;
