     subroutine tridag(a,b,c,d,nn)
c    solves a tridiagonal system using the Thomas Algorithm
c    there are nn equations, in the tridiagonal form:
c    a(i)*x(i-1) + b(i)*x(i) + c(i)*x(i+1) = d(i)
c    here, a(1) and c(nn) are assumed 0, and ignored
c    x is returned in d, b is altered
c    code set up to run on WATFOR-77
c    w.h. mason, April 10, 1992
     dimension a(nn),b(nn),c(nn),d(nn)
     if(nn .eq. 1)          then
                            d(1)=d(1)/b(1)
                            return
                            end if
     do 10 k = 2,nn
     km1      = k - 1
     if(b(k-1) .eq. 0.0)    then
                            write(6,100) km1
                            stop
                            end if
     xm       = a(k)/b(km1)
     b(k)     = b(k) - xm*c(km1)
     d(k)     = d(k) - xm*d(km1)
  10 continue
    d(nn)    = d(nn)/b(nn)
    k        = nn
    do 20 i =  2,nn
    k        = nn + 1 - i
    d(k)     = (d(k) - c(k)*d(k+1))/b(k)
 20 continue
    return
100 format(/3x,'diagonal element .eq. 0 in tridag at k = ',i2/)
    end
      
      
              c      main program to check the Tridiagonal system solver
               dimension a(20),b(20),c(20),d(20)
               n        = 10
               do 10 i = 1,n
               a(i)     = -1.
               b(i)     = 2.
               c(i)     = -1.
            10 d(i)     = 0.
               d(1)     = 1.
               call tridag(a,b,c,d,n)
               write(6,610) (i,d(i), i = 1,n)
           610 format(i5,e15.7)
               stop
               end
 results are:
                 1  0.9090909E+00
                 2  0.8181819E+00
                 3  0.7272728E+00
                 4  0.6363637E+00
                 5  0.5454546E+00
                 6  0.4545454E+00
                 7  0.3636363E+00
                 8  0.2727273E+00
                 9  0.1818182E+00
               10   0.9090909E-01
 
