# Cauchy Distribution -> part(i) -> CDF (using Riemann Sum approximation)

import numpy as np
from matplotlib import pyplot as plt

x_0 = 0
gamma = 1
dx = 0.01

def cauchy_pdf(x):
    z = (x-x_0)/gamma
    func = np.pi*gamma*(1+(z*z))
    return 1/func

CDF = list()

def RSum_pdf(x):
    sum = 0
    for i in x:
        sum = sum + cauchy_pdf(i)*dx
        CDF.append(sum)

x = np.arange(-15, 15, dx)
RSum_pdf(x)

plt.plot(x, CDF, color="blue", label="$x_0 = 0 ,\gamma = 1$")
plt.xlabel("x")
plt.ylabel("f_X(x)")
plt.legend()
plt.title("Cauchy Distribution : CDF")

plt.show()
