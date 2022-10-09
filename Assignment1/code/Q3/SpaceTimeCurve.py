from numpy import random
from matplotlib import pyplot as plt
import numpy as np
from matplotlib.pyplot import figure

# Code to Plot space-time curves for showing path
# taken by each Random Walker

np.random.seed(100)         # Using 100 as seed

figure(figsize=(15, 15), dpi=80)
total_walkers = 10**3       # Plotting space-time curves for first 10^3 walkers
total_steps = 10**3         # Each walker takes 10^3 steps in total
stepLength = 1/10**3        # Each step is of length 10^(-3)

for i in range(total_walkers):   # Plotting for each Random Walker
    path = list()
    time = list()
    sum = 0
    for j in range(total_steps):
        step = 0
        if(random.randint(2) == 0):     # A Random Walker moves left or 
            step = -(stepLength)        # right steps with equal probability
        else:
            step = stepLength
        time.append(j)
        sum = sum + step
        path.append(sum)
    plt.plot(path,time) 

plt.xlabel("Position")
plt.ylabel("Steps taken")
plt.title("Space-time curves of paths taken by Random Walkers")
plt.show()