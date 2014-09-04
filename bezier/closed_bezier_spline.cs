
  1  ﻿// <copyright file="ClosedBezierSpline.cs" company="Oleg V. Polikarpotchkin">
  2  // Copyright © 2009 Oleg V. Polikarpotchkin. All Right Reserved
  3  // </copyright>
  4  // <author>Oleg V. Polikarpotchkin</author>
  5  // <email>ov-p@yandex.ru</email>
  6  // <date>2009-02-28</date>
  7  // <summary>Method to calculate Closed Bezier Spline Control Points.</summary>
  8  
  9  using System.Windows;
 10  using NumericalRecipes;
 11  
 12  namespace ovp
 13  {
 14  	/// <summary>
 15  	/// Closed Bezier Spline Control Points calculation.
 16  	/// </summary>
 17  	public static class ClosedBezierSpline
 18  	{
 19  		/// <summary>
 20  		/// Get Closed Bezier Spline Control Points.
 21  		/// </summary>
 22  		/// <param name="knots">Input Knot Bezier spline points.</param>
 23  		/// <param name="firstControlPoints">Output First Control points array of the same 
 24  		/// length as the <paramref name="knots"/> array.</param>
 25  		/// <param name="secondControlPoints">Output Second Control points array of of the same
 26  		/// length as the <paramref name="knots"/> array.</param>
 27  		public static void GetCurveControlPoints(Point[] knots, out Point[] firstControlPoints, out Point[] secondControlPoints)
 28  		{
 29  			int n = knots.Length;
 30  			if (n <= 2)
 31  			{
 32  				firstControlPoints = new Point[0];
 33  				secondControlPoints = new Point[0];
 34  				return;
 35  			}
 36  
 37  			// Calculate first Bezier control points
 38  
 39  			// The matrix.
 40  			double[] a = new double[n], b = new double[n], c = new double[n];
 41  			for (int i = 0; i < n; ++i)
 42  			{
 43  				a[i] = 1;
 44  				b[i] = 4;
 45  				c[i] = 1;
 46  			}
 47  
 48  			// Right hand side vector for points X coordinates.
 49  			double[] rhs = new double[n];
 50  			for (int i = 0; i < n; ++i)
 51  			{
 52  				int j = (i == n - 1) ? 0 : i + 1;
 53  				rhs[i] = 4 * knots[i].X + 2 * knots[j].X;
 54  			}
 55  			// Solve the system for X.
 56  			double[] x = Cyclic.Solve(a, b, c, 1, 1, rhs);
 57  
 58  			// Right hand side vector for points Y coordinates.
 59  			for (int i = 0; i < n; ++i)
 60  			{
 61  				int j = (i == n - 1) ? 0 : i + 1;
 62  				rhs[i] = 4 * knots[i].Y + 2 * knots[j].Y;
 63  			}
 64  			// Solve the system for Y.
 65  			double[] y = Cyclic.Solve(a, b, c, 1, 1, rhs);
 66  
 67  			// Fill output arrays.
 68  			firstControlPoints = new Point[n];
 69  			secondControlPoints = new Point[n];
 70  			for (int i = 0; i < n; ++i)
 71  			{
 72  				// First control point.
 73  				firstControlPoints[i] = new Point(x[i], y[i]);
 74  				// Second control point.
 75  				secondControlPoints[i] = new Point(2 * knots[i].X - x[i], 2 * knots[i].Y - y[i]);
 76  			}
 77  		}
 78  	}
 79  }

