# Laplace Distribution -> part(i) -> PDF

import numpy as np
from matplotlib import pyplot as plt

mu = 2
b = 2

def laplace_pdf(x):
    return (np.exp(-abs(x-mu)/b))/(2*b)

x = np.linspace(-10, 15, 500)

plt.plot(x, laplace_pdf(x), color = "red", label = "$\mu$ = 2 , b = 2")
plt.xlabel("$x$")
plt.ylabel("$P_X(x)$")
plt.legend()
plt.title("Laplace Distribution : PDF")

plt.show()
