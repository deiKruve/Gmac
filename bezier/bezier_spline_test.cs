// <copyright file="BezierSplineTest.cs" company="Oleg V. Polikarpotchkin">
// Copyright © 2008-2009 Oleg V. Polikarpotchkin. All Right Reserved
// </copyright>
// <author>Oleg V. Polikarpotchkin</author>
// <email>ov-p@yandex.ru</email>
// <date>2009-03-20</date>
// <summary>Tests for BezierSpline class.</summary>

using System.Windows;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ovp;

namespace UnitTests
{
    /// <summary>
    ///This is a test class for BezierSpline and is intended
    ///to contain all BezierSpline Unit Tests
    ///</summary>
	[TestClass()]
	public class BezierSplineTest
	{
		#region TestContext
		private TestContext testContextInstance;

		/// <summary>
		///Gets or sets the test context which provides
		///information about and functionality for the current test run.
		///</summary>
		public TestContext TestContext
		{
			get
			{
				return testContextInstance;
			}
			set
			{
				testContextInstance = value;
			}
		}
		#endregion TestContext

		#region Additional test attributes
		// 
		//You can use the following additional attributes as you write your tests:
		//
		//Use ClassInitialize to run code before running the first test in the class
		//[ClassInitialize()]
		//public static void MyClassInitialize(TestContext testContext)
		//{
		//}
		//
		//Use ClassCleanup to run code after all tests in a class have run
		//[ClassCleanup()]
		//public static void MyClassCleanup()
		//{
		//}
		//
		//Use TestInitialize to run code before running each test
		//[TestInitialize()]
		//public void MyTestInitialize()
		//{
		//}
		//
		//Use TestCleanup to run code after each test has run
		//[TestCleanup()]
		//public void MyTestCleanup()
		//{
		//}
		//
		#endregion

		/// <summary>
		/// GetCurveControlPoints method test.
		///</summary>
		[TestMethod()]
		public void GetCurveControlPointsTest()
		{
			GetCurveControlPointsTest(GetKnotsArc3Points());
			GetCurveControlPointsTest(GetKnotsArc5Points());
			GetCurveControlPointsTest(GetKnotsRunge5Points());
		}

		/// <summary>
		/// GetFirstControlPoints method test.
		///</summary>
		[TestMethod()]
		[DeploymentItem("BezierCurve.exe")]
		public void GetFirstControlPointsTest()
		{
			GetFirstControlPointsTest(GetKnotsArc3Points());
			GetFirstControlPointsTest(GetKnotsArc5Points());
			GetFirstControlPointsTest(GetKnotsRunge5Points());
		}

		#region Test data
		/// <summary>
		/// Generates test data.
		/// </summary>
		/// <returns>Knot points array.</returns>
		static Point[] GetKnotsArc3Points()
		{
			return new Point[] 
			{ // "Arc" curve with 3 points.
			    new Point(200, 100),
			    //new Point(30, 170),
			    new Point(29.2893218813453, 170.710678118655),
			    new Point(100, 0)
			};
		}

		/// <summary>
		/// Generates test data.
		/// </summary>
		/// <returns>Knot points array.</returns>
		static Point[] GetKnotsArc5Points()
		{
			return new Point[] 
			{ // "Arc" curve with 5 points.
			    new Point(200, 100),
			    new Point(138.268343236509, 192.387953251129),
			    new Point(29.2893218813453, 170.710678118655),
			    new Point(7.6120467488713, 61.7316567634911),
			    new Point(100, 0)
			};
		}

		/// <summary>
		/// Generates test data.
		/// </summary>
		/// <returns>Knot points array.</returns>
		static Point[] GetKnotsRunge5Points()
		{
			return new Point[] 
			{ // "Runge" curve with 5 points.
			    new Point(0, 96.1538461538462),
			    new Point(50, 86.2068965517241),
			    new Point(100, 0),
			    new Point(150, 86.2068965517241),
			    new Point(200, 96.1538461538462)
			};
		}
		#endregion Test data

		/// <summary>
		/// GetCurveControlPoints method test.
		///</summary>
		void GetCurveControlPointsTest(Point[] knots)
		{
			Point[] p1, p2; // Control points arrays.
			BezierSpline.GetCurveControlPoints(knots, out p1, out p2);

			CheckCPArraysLength(knots, p1, p2);
			if (knots.Length < 2)
				return;

			CheckFirstDerivativeContinuity(knots, p1, p2);
			CheckSecondDerivativeContinuity(p1, p2);
			CheckBoundaryConditions(knots, p1, p2);
		}

		/// <summary>
		/// GetFirstControlPoints method test.
		///</summary>
		void GetFirstControlPointsTest(Point[] knots)
		{
			int n = knots.Length - 1;
			double[] rhs = new double[n];

			// Right hand side X values.
			for (int i = 1; i < n - 1; ++i)
				rhs[i] = 4 * knots[i].X + 2 * knots[i + 1].X;
			rhs[0] = knots[0].X + 2 * knots[1].X;
			rhs[n - 1] = (8 * knots[n - 1].X + knots[n].X) / 2.0;
			// Solve the system to get first control points X-values.
			double[] p1x = BezierSpline_Accessor.GetFirstControlPoints(rhs);

			// Check the system solution.
			// First equation.
			Assert.AreEqual(knots[0].X + 2 * knots[1].X, 2 * p1x[0] + p1x[1], 10e-7);
			// Intermediate equations.
			for (int i = 2; i < n; ++i)
			{
				Assert.AreEqual(4 * knots[i - 1].X + 2 * knots[i].X
					, p1x[i - 2] + 4 * p1x[i - 1] + p1x[i], 10e-7);
			}
			// Last equation.
			Assert.AreEqual((8 * knots[n - 1].X + knots[n].X) / 2, 3.5 * p1x[n - 1] + p1x[n - 2], 10e-7);

			// Right hand side Y values.
			for (int i = 1; i < n - 1; ++i)
				rhs[i] = 4 * knots[i].Y + 2 * knots[i + 1].Y;
			rhs[0] = knots[0].Y + 2 * knots[1].Y;
			rhs[n - 1] = (8 * knots[n - 1].Y + knots[n].Y) / 2.0;
			// Solve the system to get first control points X-values.
			double[] p1y = BezierSpline_Accessor.GetFirstControlPoints(rhs);

			// Check the system solution.
			// First equation.
			Assert.AreEqual(knots[0].Y + 2 * knots[1].Y, 2 * p1y[0] + p1y[1], 10e-7);
			// Intermediate equations.
			for (int i = 2; i < n; ++i)
			{
				Assert.AreEqual(4 * knots[i - 1].Y + 2 * knots[i].Y
					, p1y[i - 2] + 4 * p1y[i - 1] + p1y[i], 10e-7);
			}
			// Last equation.
			Assert.AreEqual((8 * knots[n - 1].Y + knots[n].Y) / 2, 3.5 * p1y[n - 1] + p1y[n - 2], 10e-7);
		}

		#region Checks
		/// <summary>
		/// Check control points arrays length.
		/// </summary>
		/// <param name="knots">The knots.</param>
		/// <param name="p1">The first control points.</param>
		/// <param name="p2">The second control points.</param>
		static void CheckCPArraysLength(Point[] knots, Point[] p1, Point[] p2)
		{
			Assert.IsTrue(p1.Length == p2.Length);
			Assert.IsTrue((knots.Length < 2 && p1.Length == 0)
				|| p1.Length == knots.Length - 1);
		}

		/// <summary>
		/// Check for the first derivative continuity.
		/// </summary>
		/// <param name="knots">The knots.</param>
		/// <param name="p1">The first control points.</param>
		/// <param name="p2">The second control points.</param>
		static void CheckFirstDerivativeContinuity(Point[] knots, Point[] p1, Point[] p2)
		{
			for (int i = 1; i < knots.Length - 1; ++i)
			{
				Assert.AreEqual(2 * knots[i].X, p1[i].X + p2[i - 1].X, 10e-7);
				Assert.AreEqual(2 * knots[i].Y, p1[i].Y + p2[i - 1].Y, 10e-7);
			}
		}

		/// <summary>
		/// Check for the second derivative continuity.
		/// </summary>
		/// <param name="p1">The first control points.</param>
		/// <param name="p2">The second control points.</param>
		static void CheckSecondDerivativeContinuity(Point[] p1, Point[] p2)
		{
			for (int i = 1; i < p1.Length; ++i)
			{
				Assert.AreEqual(p1[i - 1].X + 2 * p1[i].X, p2[i].X + 2 * p2[i - 1].X, 10e-7);
				Assert.AreEqual(p1[i - 1].Y + 2 * p1[i].Y, p2[i].Y + 2 * p2[i - 1].Y, 10e-7);
			}
		}

		/// <summary>
		/// Check for the boundary conditions.
		/// </summary>
		/// <param name="knots">The knots.</param>
		/// <param name="p1">The first control points.</param>
		/// <param name="p2">The second control points.</param>
		static void CheckBoundaryConditions(Point[] knots, Point[] p1, Point[] p2)
		{
			// Left bound
			Assert.AreEqual(knots[0].X, 2 * p1[0].X - p2[0].X, 10e-7);
			Assert.AreEqual(knots[0].Y, 2 * p1[0].Y - p2[0].Y, 10e-7);
			// Right bound
			int n = knots.Length;
			Assert.AreEqual(knots[n - 1].X, 2 * p2[n - 2].X - p1[n - 2].X, 10e-7);
			Assert.AreEqual(knots[n - 1].Y, 2 * p2[n - 2].Y - p1[n - 2].Y, 10e-7);
		}
		#endregion Checks
	}
}