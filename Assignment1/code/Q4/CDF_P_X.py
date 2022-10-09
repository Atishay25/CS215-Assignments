from numpy import random
from matplotlib import pyplot as plt
import numpy as np
from matplotlib.pyplot import figure

# CDF using 10^5 independent draws from P_X(.)

np.random.seed(10)    # Using 10 as seed for this code

def PDF(x):           # Given P_X(x)
    if(abs(x)>1):
        return 0
    else:
        return abs(x)

def inverse_CDF(x):   # Calculating its inverse CDF
    if(x == 1/2):
        return 0
    elif(x > 1/2):
        return np.sqrt(2*(x - 1/2))
    else:
        return -np.sqrt(2*(1/2 - x))

def random_number_generator():      # Random Number Generator for P_X(x) 
    p = np.random.uniform(0,1)      # Using uniform random number generator
    return inverse_CDF(p)

M = 10**5               # using 10^5 independent draws from PDF P(x)
data = list()           
for i in range(M):    
    data.append(random_number_generator())

pdf = [0]*200           # Calculated pdf at each index 
for i in data:
    p = np.math.floor(i*100) + 100
    pdf[p] = pdf[p] + 1

sum = 0
cdf = list()        
for i in pdf:           # Calculating cdf from pdf by Cumulative addition
    sum = sum + i
    cdf.append(sum/M)
x = np.linspace(-1,0.99,200)

plt.plot(x,cdf)
plt.xlabel('x')
plt.ylabel('$f_X(x)$')
plt.title("CDF using $10^5$ draws from $P_X(x)$")
plt.show()
