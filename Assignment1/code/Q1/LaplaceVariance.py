# Laplace Distribution -> part(iii) -> Variance using Riemann Sum approximations
import numpy as np

mu = 2
b = 2

dx = 0.01
start = -1000
end = 1000

def laplace_pdf(x):
    return (np.exp(-abs(x-mu)/b))/(2*b)

def expectation(x):
    sum = 0
    for i in x:
        sum = sum + i*laplace_pdf(i)*dx
    return sum

x = np.arange(start,end,dx)
mean = expectation(x)

def variance(f,x):
    R_sum = 0
    for i in range(len(x)):
        R_sum = R_sum + (x[i]-mean)*(x[i]-mean)*f(x[i])*dx
    return R_sum

print("Variance (using Reimann Sum) : ", variance(laplace_pdf,x))
print("Variance (theoretically)     : ", 2*b*b)
print("Tolerance                    : ", abs(2*b*b - variance(laplace_pdf,x)))
