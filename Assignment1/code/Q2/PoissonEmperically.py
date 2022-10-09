import math
import numpy as np
import pandas as pd

# Code to Emperically obtain PMF P(Z) of Poisson
np.random.seed(10)      # Using seed as 10

lambda_X = 3
lambda_Y = 4

X = np.random.poisson(lambda_X, 10**6)      # Drawing 10^6 instances of both X and Y
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

data = {
    "P(Z = k)" : P_Z
}

index_k = list()
for i in range(26):
    index_k.append("k = " + str(i))

result = pd.DataFrame(data, index = index_k)
print(result)