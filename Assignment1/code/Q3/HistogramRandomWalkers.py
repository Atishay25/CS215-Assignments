from numpy import random
from matplotlib import pyplot as plt
import numpy as np
from matplotlib.pyplot import figure

# Code to plot Histogram of the final locations
# of all the random walkers

np.random.seed(1000)        # Using 1000 as seed
figure(figsize=(10, 20), dpi=80)

total_walkers = 10**4       # Plotting Histogram for 10^4 Random Walkers
total_steps = 10**3         # Each walker takes 10^3 steps in total
stepLength = 1/10**3        # Each step is of length 10^(-3)
finalLocation = list()

for i in range(total_walkers):
    time = []
    sum = 0
    for j in range(total_steps):
        step = 0
        if(random.randint(2) == 0):     # A Random Walker takes right or left 
            step = -(stepLength)        # steps at equal probability
        else:
            step = stepLength
        time.append(j)
        sum = sum + step
    finalLocation.append(sum)

w = 0.001
figure(figsize=(20, 8), dpi=80)   
plt.hist(finalLocation,bins=np.arange(min(finalLocation), max(finalLocation) + w, w))
plt.ylabel("Number of Walkers")
plt.xlabel("Final Location")
plt.title("Histogram (Random Walkers)")

plt.show()
