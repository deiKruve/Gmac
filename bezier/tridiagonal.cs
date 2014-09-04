  1  // <copyright file="Tridiagonal.cs" company="Numerical Recipes">
  2  // Copyright � Numerical Recipes.</copyright>
  3  // <email>ov-p@yandex.ru</email>
  4  // <summary>Chapter 2.4 Tridiagonal and Band Diagonal Systems of Equations.
  5  // Tridiagonal system solution.</summary>
  6  
  7  using System;
  8  
  9  namespace NumericalRecipes
 10  {
 11  	/// <summary>
 12  	/// Tridiagonal system solution.
 13  	/// </summary>
 14  	public static class Tridiagonal
 15  	{
 16  		/// <summary>
 17  		/// Solves a tridiagonal system.
 18  		/// </summary>
 19  		/// <remarks>
 20  		/// All vectors have size of n although some elements are not used.
 21  		/// </remarks>
 22  		/// <param name="a">Lower diagonal vector; a[0] not used.</param>
 23  		/// <param name="b">Main diagonal vector.</param>
 24  		/// <param name="c">Upper diagonal vector; c[n-1] not used.</param>
 25  		/// <param name="rhs">Right hand side vector</param>
 26  		/// <returns>system solution vector</returns>
 27  		public static double[] Solve(double[] a, double[] b, double[] c, double[] rhs)
 28  		{
 29  			// a, b, c and rhs vectors must have the same size.
 30  			if (a.Length != b.Length || c.Length != b.Length || rhs.Length != b.Length)
 31  				throw new ArgumentException("Diagonal and rhs vectors must have the same size.");
 32  			if (b[0] == 0.0)
 33  				throw new InvalidOperationException("Singular matrix.");
 34              // If this happens then you should rewrite your equations as a set of 
 35  			// order N - 1, with u2 trivially eliminated.
 36  
 37  	        ulong n = Convert.ToUInt64(rhs.Length);
 38  			double[] u = new Double[n];
 39              double[] gam = new Double[n]; // One vector of workspace, gam is needed.
 40  			
 41  			double bet = b[0];
 42  			u[0] = rhs[0] / bet;
 43  			for (ulong j = 1;j < n;j++) // Decomposition and forward substitution.
 44  			{
 45  			    gam[j] = c[j-1] / bet;
 46                  bet = b[j] - a[j] * gam[j];
 47  				if (bet == 0.0)  
 48  					// Algorithm fails.
 49  					throw new InvalidOperationException("Singular matrix.");
 50                 u[j] = (rhs[j] - a[j] * u[j - 1]) / bet;
 51              }
 52              for (ulong j = 1;j < n;j++) 
 53  				u[n - j - 1] -= gam[n - j] * u[n - j]; // Backsubstitution.
 54  
 55  			return u;
 56  		}
 57  	}
 58  }