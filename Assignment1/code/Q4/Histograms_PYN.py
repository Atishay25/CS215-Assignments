from numpy import random
from matplotlib import pyplot as plt
import numpy as np
from matplotlib.pyplot import figure

# Code to plot Histograms for each given N in P_YN(.)
np.random.seed(1000)        # Using 1000 as seed

def inverse_CDF(x):         #calculating inverse cdf of x
        if(x == 1/2):
            return 0
        elif(x > 1/2):
            return np.sqrt(2*(x - 1/2))
        else:
            return -np.sqrt(2*(1/2 - x))


def random_number_generator():      #the number generator from previous problem
    p = np.random.uniform(0,1)
    return inverse_CDF(p)

def random_normal_generator(n):     #random number generator for P_Y_N(.)
    data = []
    for j in range(n):
        data.append(random_number_generator())
    return sum(data) / len(data)

N = [1,2,4,8,16,32,64]              #value of N used in P_Y_N(.)
total_numbers = 10**4              #Number of values generated by this code.
for i in N:                         #creating the list result which stores 10**4 random numbers
    result = []
    for j in range(total_numbers):
        result.append(random_normal_generator(i))       #using random_normal_generator to create the values and storing it in result 
    plt.hist(result,bins=250)                           #using histogram to show the plot
    plt.title("Histogram for N = " + str(i))
    plt.xlabel('x')
    plt.ylabel("Frequency")
    plt.show()