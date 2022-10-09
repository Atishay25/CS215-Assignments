# Distribution of errrors across M repeats for Gaussian Distribution

import matplotlib.pyplot as plt
import numpy as np
 
np.random.seed(10)      # 10 used as seed for this code

def avg(m):             # function to calculate average
    sum = 0
    for j in m:
        sum = sum + j
    return sum/len(m)

N = [5,10,20,40,60,80,100,500,1000,10000]       # various dataset sizes
Result = list()         # list to store results for different values of N

for j in N: 
    M = list()
    for k in range(100):    # repeating experiment 100 times
        data = list()
        for i in range(j):
            data.append(np.random.normal(0,1))   # Gaussian Distribution
        M.append(abs(avg(data)-0))            # True Mean = mu = 0 
    Result.append(M)

# Plotting Box Plot
fig = plt.figure(figsize =(10, 8))
ax = fig.add_subplot(111)
bp = ax.boxplot(Result, patch_artist = True)
colors = ['gold', 'cyan','salmon', 'honeydew','lavenderblush','white','pink','azure','sandybrown','snow']
for patch, color in zip(bp['boxes'], colors):
    patch.set_facecolor(color)
for whisker in bp['whiskers']:
    whisker.set(color ='black', linewidth = 1.5)
for cap in bp['caps']:
    cap.set(color ='black', linewidth = 2)
for median in bp['medians']:
    median.set(color ='midnightblue', linewidth = 3)

ax.set_xticklabels(['5','10','20','40','60','80','100','500','1000','10000'])
plt.xlabel("N")
plt.ylabel("Error")
plt.title("Distribution of Errors (Gaussian Distribution)")
 
plt.show()
