# Gumbel Distribution -> part(ii) -> CDF

import numpy as np
from matplotlib import pyplot as plt

mu = 1
beta = 2
dx = 0.01

def gumbel_pdf(x):
    z = (x-mu)/beta;
    return (np.exp(-(z+np.exp(-z))))*beta

CDF = list()

def RSum_pdf(x):
    sum = 0
    for i in x:
        sum = sum + gumbel_pdf(i)*dx
        CDF.append(sum)

x = np.arange(-5, 15, dx)
RSum_pdf(x)

plt.plot(x, CDF, color="blue", label="$\mu$ = 1 , b = 2")
plt.xlabel("$x$")
plt.ylabel("$f_X(x)$")
plt.legend()
plt.title("Gumbel Distribution : CDF")

plt.show()
