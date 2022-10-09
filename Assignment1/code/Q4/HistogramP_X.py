from numpy import random
from matplotlib import pyplot as plt
import numpy as np
from matplotlib.pyplot import figure

# Histogram using 10^5 draws from P(x)

np.random.seed(10)          # Using 10 as seed for this code

def PDF(x):                 # Given P_X(x)
    if(abs(x)>1):
        return 0
    else:
        return abs(x)

def inverse_CDF(x):         # Calculating its inverse CDF
    if(x == 1/2):
        return 0
    elif(x > 1/2):
        return np.sqrt(2*(x - 1/2))
    else:
        return -np.sqrt(2*(1/2 - x))

def random_number_generator():      # Random Number Generator for P_X(x) 
    p = np.random.uniform(0,1)      # Using uniform random number generator
    return inverse_CDF(p)

data = list()
M = 10**5                           # using 10^5 independent draws from PDF P(x)
for i in range(M):
    data.append(random_number_generator())

plt.hist(data,bins = 200)
plt.title("Histogram of $P_X(x)$")
plt.xlabel('x')
plt.ylabel('N')
plt.show()  
