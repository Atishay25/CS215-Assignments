# Last part of Q3
# computing mean and variance empirically
# Code for reporting error between -
# Emperical and True Mean and Variance

from numpy import random
from matplotlib import pyplot as plt
import numpy as np
from matplotlib.pyplot import figure
import statistics as stat

figure(figsize=(10, 20), dpi=80)
np.random.seed(1000)

total_walkers = 10**4
length_step = 1/10**3
total_steps = 10**3
result = []
for i in range(total_walkers):
    sum = 0
    for j in range(total_steps):
        step = 0
        if (random.randint(2) == 0):
            step = -(1/10**3)
        else:
            step = 1/10**3
        sum = sum + step
    result.append(sum)
sum = 0
for i in result:
    sum = sum + i
mean = sum/total_walkers
var1 = 0
for i in result:
    var1 = var1 + (i - mean)**2
var1 = var1/total_walkers
print("The errors between true mean and empirical-computed mean         : ", abs(mean - 0))
print("The errors between true variance and empirical-computed variance : ",
      abs(var1 - total_steps*length_step*length_step))
