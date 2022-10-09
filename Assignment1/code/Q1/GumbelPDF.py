# Gumbel Distribution -> part(i) -> PDF

import numpy as np
from matplotlib import pyplot as plt

mu = 1
beta = 2

def gumbel_pdf(x):
    z = (x-mu)/beta;
    return (np.exp(-(z+np.exp(-z))))*beta

x = np.linspace(-5, 15, 500)

plt.plot(x, gumbel_pdf(x), color="red", label="$\mu$ = 1 , b = 2")
plt.xlabel("$x$")
plt.ylabel("$P_X(x)$")
plt.legend()
plt.title("Gumbel Distribution : PDF")

plt.show()
