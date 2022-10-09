import numpy as np
import math
import pandas as pd

# Code to show and compare PMF P^(Z) and P(Z) , Poisson Thinning
np.random.seed(10)   # using 10 as seed

lambda_Y = 4
result = list()
Y = np.random.poisson(lambda_Y,10**5)   # drawing 10^5 instances from Y
bino = list()
p = 0.8
for i in Y:
    bino.append(np.random.binomial(i,p,1))

def Z(k):
    occurence = 0
    for j in bino:
        if j == k:
            occurence = occurence + 1
    return occurence/10**5
index_k = []
P_theo = []
for i in range(26):
    result.append(Z(i))
    index_k.append("k = " + str(i))
    P_theo.append((np.exp(-(lambda_Y*p))*((lambda_Y*p)**i))/math.factorial(i))

data = {
    "P (Z = k) Emperically" : result,
    "Theoretically" : P_theo
}
Comparison = pd.DataFrame(data, index = index_k)
print(Comparison)