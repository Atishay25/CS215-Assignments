# Cauchy Distribution -> part(i) -> PDF

import numpy as np
from matplotlib import pyplot as plt

x_0 = 0
gamma = 1

def cauchy_pdf(x):
    z = (x-x_0)/gamma
    func = np.pi*gamma*(1+(z*z))
    return 1/func

x = np.linspace(-7, 7, 500)

plt.plot(x, cauchy_pdf(x), color="red", label="$x_0 = 0 ,\gamma = 1$")
plt.xlabel("$x$")
plt.ylabel("$P_X(x)$")
plt.legend()
plt.title("Cauchy Distribution : PDF")

plt.show()
