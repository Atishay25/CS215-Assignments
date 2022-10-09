# Gumbel Distribution -> part(iii) -> Variance using Reimann Sum approximations

import numpy as np

mu = 1
b = 2

def gumbel_pdf(x):
    z = (x-mu)/b
    return (1/b)*(np.exp(-z))*(np.exp(-np.exp(-z)))

start = -1000
end = 1000
dx = 0.01

def expectation(x):
    avg = 0
    for i in x:
        avg = avg + i*gumbel_pdf(i)*dx
    return avg

x = np.arange(start, end, dx)
mean = expectation(x)

def variance(x):
    var = 0
    for i in range(len(x)-1):       
        var = var + (x[i] - mean)**2*gumbel_pdf(x[i])*dx
    return var

print("Variance (using Reimann Sum) : ",variance(x))
print("Variance (theoretically)     : ",((np.pi*b)**2)/6)
print("Tolerance                    : ", abs(((np.pi*b)**2)/6 - variance(x)))

