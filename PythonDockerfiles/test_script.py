import numpy as np
import pandas as pd
import tqdm
import time
from os import system as cmd
import matplotlib.pyplot as plt
from sklearn import datasets
from scipy import signal

print("  ____  _         _____        _          _____  ")
print(" |  _ \(_)       |  __ \      | |        |_   _| ")
print(" | |_) |_  __ _  | |  | | __ _| |_ __ _    | |   ")
print(" |  _ <| |/ _` | | |  | |/ _` | __/ _` |   | |   ")
print(" | |_) | | (_| | | |__| | (_| | || (_| |  _| |_  ")
print(" |____/|_|\__, | |_____/ \__,_|\__\__,_| |_____| ")
print("  _______  __/ | _                   _       _   ")
print(" |__   __||___/ | |                 (_)     | |  ")
print("    | | ___  ___| |_   ___  ___ _ __ _ _ __ | |_ ")
print("    | |/ _ \/ __| __| / __|/ __| '__| | '_ \| __|")
print("    | |  __/\__ \ |_  \__ \ (__| |  | | |_) | |_ ")
print("    |_|\___||___/\__| |___/\___|_|  |_| .__/ \__|")
print("                                      | |        ")
print("                                      |_|        ")


print("\nTesting numpy...\n")
random_matrix = np.random.rand(3,2)
print("Numpy random matrix:", random_matrix, sep="\n")

print("\nTesting pandas...\n")
df = pd.DataFrame(data=random_matrix, index=["row1", "row2", "row3"], columns=["column1", "column2"])
print("Pandas dataframe:", df, sep="\n")

print("\nTesting tqdm...\n")
for i in tqdm.tqdm(range(10)):
	time.sleep(1)

print("\nTesting skitlearn and matplotlib...\n")
# import some data to play with
iris = datasets.load_iris()
X = iris.data[:, :2]  # we only take the first two features.
y = iris.target

x_min, x_max = X[:, 0].min() - .5, X[:, 0].max() + .5
y_min, y_max = X[:, 1].min() - .5, X[:, 1].max() + .5

plt.figure(2, figsize=(8, 6))
plt.clf()

# Plot the training points
plt.scatter(X[:, 0], X[:, 1], c=y, cmap=plt.cm.Set1,
            edgecolor='k')
plt.xlabel('Sepal length')
plt.ylabel('Sepal width')

plt.xlim(x_min, x_max)
plt.ylim(y_min, y_max)
plt.savefig("skitlearn_test_figure.png")
print("Check skitlearn_test_figure.png")
_ = cmd("ls")


print("\nTesting scipy...\n")
b, a = signal.butter(4, 100, 'low', analog=True)
w, h = signal.freqs(b, a)
plt.semilogx(w, 20 * np.log10(abs(h)))
plt.title('Butterworth filter frequency response')
plt.xlabel('Frequency [radians / second]')
plt.ylabel('Amplitude [dB]')
plt.margins(0, 0.1)
plt.grid(which='both', axis='both')
plt.axvline(100, color='green') # cutoff frequency
plt.savefig("scipy_test_figure.png")
print("Check scipy_test_figure.png")
_ = cmd("ls")







