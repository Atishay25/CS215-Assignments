import math
import numpy as np
import pandas as pd

# Code to show to and compare P^(Z) and P(Z) of Poisson
np.random.seed(10)
result= []

lambda_X = 3
lambda_Y = 4
lambda_Z = lambda_X + lambda_Y

def PMFZ(x):                # theoretical formula for P(Z)
    return (np.exp(-lambda_Z)*pow(lambda_Z,x))/math.factorial(x)

X = np.random.poisson(lambda_X, 10**6)      # Drawing 10^6 instances of X and Y
Y = np.random.poisson(lambda_Y, 10**6)
P_Z = list()

for value in range(26):
    sum = 0
    for i in range(value+1):
        x = 0
        for j in X:
            if(i == j):
                x = x + 1
        y = 0
        for j in Y:
            if(j == value-i):
                y = y + 1
        sum = sum + x*y
    P_Z.append(sum/10**12)

P_theo = list()
for i in range(26):
    P_theo.append(PMFZ(i))

data = {
    "P(Z = k) Emperically" : P_Z,
    "Theoretically" : P_theo
}

index_k = list()
for i in range(26):
    index_k.append("k = " + str(i))

result = pd.DataFrame(data, index = index_k)
print(result)
