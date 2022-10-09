import math
import numpy as np
import pandas as pd

# Code to theoretically obtain PMF P(Z) using formula of Poisson

lambda_X = 3
lambda_Y = 4
lambda_Z = lambda_X + lambda_Y

def PMFZ(x):            # Using formula for P(Z = k)
    return (np.exp(-lambda_Z)*pow(lambda_Z,x))/math.factorial(x)
P_z = list()
for i in range(26):
    P_z.append(PMFZ(i))
data = {
    "Theoretically P(Z)" : P_z
}
index_k = list()
for i in range(26):
    index_k.append("k = " + str(i))

result = pd.DataFrame(data, index = index_k)
print(result)