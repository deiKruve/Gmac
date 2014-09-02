//the amount of steps in the bezier curve
unsigned int steps=?;
//the 4 bezier points
double p[4]={?,?,?,?};

//== The algorithm itself begins here ==
double f, fd, fdd, fddd, fdd_per_2, fddd_per_2, fddd_per_6;
double t = 1.0 / double(steps);
double temp = t * t;

//I've tried to optimize the amount of
//multiplications here, but these are exactly
//the same formulas that were derived earlier
//for f(0), f'(0)*t etc.
f = p[0];
fd = 3 * (p[1] - p[0]) * t;
fdd_per_2 = 3 * (p[0] - 2 * p[1] + p[2]) * temp;
fddd_per_2 = 3 * (3 * (p[1] - p[2]) + p[3] - p[0]) * temp * t;

fddd = fddd_per_2 + fddd_per_2;
fdd = fdd_per_2 + fdd_per_2;
fddd_per_6 = fddd_per_2 * (1.0 / 3);

for (unsigned int loop=0; loop < steps; loop++) {
  drawBezierpoint(f);

  f = f + fd + fdd_per_2 + fddd_per_6;
  fd = fd + fdd + fddd_per_2;
  fdd = fdd + fddd;
  fdd_per_2 = fdd_per_2 + fddd_per_2;
}

drawBezierpoint(x[3]);
