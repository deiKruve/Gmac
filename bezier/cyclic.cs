  1  ��// <copyright file="Cyclic.cs" company="Numerical Recipes">
  2  
  3  // Copyright � Numerical Recipes.</copyright>
  4  
  5  // <email>ov-p@yandex.ru</email>
  6  
  7  // <summary>Chapter 2.7 Sparse Linear Systems.
  8  
  9  // Solution of the cyclic set of linear equations.</summary>
 10  
 11  
 12  
 13  using System;
 14  
 15  
 16  
 17  namespace NumericalRecipes
 18  
 19  {
 20  
 21  	/// <summary>
 22  
 23  	/// Solves the cyclic set of linear equations.
 24  
 25  	/// </summary>
 26  
 27  	/// <remarks>
 28  
 29  	/// The cyclic set of equations have the form
 30  
 31  	/// ---------------------------
 32  
 33  	/// b0 c0  0 � � � � � � �>
 34  
 35  	///	a1 b1 c1 � � � � � � �
 36  
 37  	///  � � � � � � � � � � � 
 38  
 39  	///  � � � a[n"2] b[n"2] c[n"2]
 40  
 41  	/// �>  � � � � 0  a[n-1] b[n-1]
 42  
 43  	/// ---------------------------
 44  
 45  	/// This is a tridiagonal system, except for the matrix elements �> and �> in the corners.
 46  
 47  	/// </remarks>
 48  
 49  	public static class Cyclic
 50  
 51  	{
 52  
 53  		/// <summary>
 54  
 55  		/// Solves the cyclic set of linear equations. 
 56  
 57  		/// </summary>
 58  
 59  		/// <remarks>
 60  
 61  		/// All vectors have size of n although some elements are not used.
 62  
 63  		/// The input is not modified.
 64  
 65  		/// </remarks>
 66  
 67  		/// <param name="a">Lower diagonal vector of size n; a[0] not used.</param>
 68  
 69  		/// <param name="b">Main diagonal vector of size n.</param>
 70  
 71  		/// <param name="c">Upper diagonal vector of size n; c[n-1] not used.</param>
 72  
 73  		/// <param name="alpha">Bottom-left corner value.</param>
 74  
 75  		/// <param name="beta">Top-right corner value.</param>
 76  
 77  		/// <param name="rhs">Right hand side vector.</param>
 78  
 79  		/// <returns>The solution vector of size n.</returns>
 80  
 81          public static double[] Solve(double[] a, double[] b, double[] c, double alpha, double beta, double[] rhs)
 82  
 83  		{
 84  
 85  			// a, b, c and rhs vectors must have the same size.
 86  
 87  			if (a.Length != b.Length || c.Length != b.Length || rhs.Length != b.Length)
 88  
 89  				throw new ArgumentException("Diagonal and rhs vectors must have the same size.");
 90  
 91  			int n = b.Length;
 92  
 93  			if (n <= 2) 
 94  
 95  				throw new ArgumentException("n too small in Cyclic; must be greater than 2.");
 96  
 97  
 98  
 99  			double gamma = -b[0]; // Avoid subtraction error in forming bb[0].
100  
101  			// Set up the diagonal of the modified tridiagonal system.
102  
103  			double[] bb = new Double[n];
104  
105  			bb[0] = b[0] - gamma;
106  
107  			bb[n-1] = b[n - 1] - alpha * beta / gamma;
108  
109  			for (int i = 1; i < n - 1; ++i)
110  
111  				bb[i] = b[i];
112  
113  			// Solve A � x = rhs.
114  
115  			double[] solution = Tridiagonal.Solve(a, bb, c, rhs);
116  
117  			double[] x = new Double[n];
118  
119  			for (int k = 0; k < n; ++k)
120  
121  				x[k] = solution[k];
122  
123  
124  
125  			// Set up the vector u.
126  
127  			double[] u = new Double[n];
128  
129  			u[0] = gamma;
130  
131  			u[n-1] = alpha;
132  
133  			for (int i = 1; i < n - 1; ++i) 
134  
135  				u[i] = 0.0;
136  
137  			// Solve A � z = u.
138  
139  			solution = Tridiagonal.Solve(a, bb, c, u);
140  
141  			double[] z = new Double[n];
142  
143  			for (int k = 0; k < n; ++k)
144  
145  				z[k] = solution[k];
146  
147  
148  
149  			// Form v � x/(1 + v � z).
150  
151  			double fact = (x[0] + beta * x[n - 1] / gamma)
152  
153  				/ (1.0 + z[0] + beta * z[n - 1] / gamma);
154  
155  
156  
157  			// Now get the solution vector x.
158  
159  			for (int i = 0; i < n; ++i) 
160  
161  				x[i] -= fact * z[i];
162  
163  			return x;
164  
165  		} 
166  
167  	}
168  
169  }
170  
171          /*
172  
173          private void button1_Click(object sender, System.EventArgs e)
174  
175  		{
176  
177  			double[] a = new Double[4];
178  
179  			double[] b = new Double[4];
180  
181      		double[] c = new Double[4];
182  
183  			double[] r = new Double[4];
184  
185  			double[] x = new Double[4];
186  
187  			
188  
189  			a[0] = 1.0;
190  
191  			a[1] = 2.0;
192  
193  			a[2] = 3.0;
194  
195  			a[3] = 4.0;
196  
197  
198  
199  			b[0] = 1.0;
200  
201  			b[1] = 2.0;
202  
203  			b[2] = 3.0;
204  
205  			b[3] = 4.0;
206  
207  
208  
209  			c[0] = 1.0;
210  
211  			c[1] = 2.0;
212  
213  			c[2] = 3.0;
214  
215  			c[3] = 4.0;
216  
217  
218  
219  			r[0] = 1.0;
220  
221  			r[1] = 2.0;
222  
223  			r[2] = 3.0;
224  
225  			r[3] = 4.0;
226  
227  
228  
229  			double alpha = 1.0;
230  
231  			double beta = 1.0;
232  
233  	
234  
235  			
236  
237  			
238  
239  			NR.SolutionOfLinearAlgebraicEquations.Cyclic ob = 
240  
241  				new NR.SolutionOfLinearAlgebraicEquations.Cyclic();
242  
243  			
244  
245  			ob.cyclic(a,b,c,alpha,beta,r,x,4);
246  
247  
248  
249  			for(int i = 0; i < 4; i++)
250  
251          		textBox1.Text += Convert.ToString(x[i]) + "\r\n"; 
252  
253      	}  
254  
255  		*/