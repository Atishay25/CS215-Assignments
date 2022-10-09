# Laplace Distribution -> part(ii) -> CDF (using Reimann Sum)

import numpy as np
from matplotlib import pyplot as plt

mu = 2
b = 2
dx = 0.01

def laplace_pdf(x):
    return (np.exp(-abs(x-mu)/b))/(2*b)

CDF = list()

def RSum_pdf(x):
    sum = 0
    for i in x:
        sum = sum + laplace_pdf(i)*dx
        CDF.append(sum)

x = np.arange(-10, 15, dx)
RSum_pdf(x)
plt.plot(x, CDF, color = 'blue', label = "$\mu$ = 2 , b = 2")
plt.xlabel("$x$")
plt.ylabel("$f_X(x)$")
plt.legend()
plt.title("Laplace Distribution : CDF")

plt.show()
