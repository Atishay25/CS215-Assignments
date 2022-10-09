import numpy as np
import math
import pandas as pd

# Code for theoretical PMF P(Z) using formula , Poisson Thinning

lambda_Y = 4
p = 0.8
index_k = []
P_theo = []
for i in range(26):
    index_k.append("k = " + str(i))
    P_theo.append((np.exp(-(lambda_Y*p))*((lambda_Y*p)**i))/math.factorial(i))

data = {
    "P(Z = k) Theoretically" : P_theo
}
Theoretical = pd.DataFrame(data, index = index_k)
print(Theoretical)