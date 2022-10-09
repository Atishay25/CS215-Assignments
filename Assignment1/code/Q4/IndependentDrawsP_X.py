import numpy as np

# Code to generate independent draws from P_X(.)

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

M = 10                  # M is the number of draws that will be generated.
data = list()           # Generating 10 independent draws as output
for i in range(M):      # just as an illustration for this code
    data.append(random_number_generator())

print(data)
