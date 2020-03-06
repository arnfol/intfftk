import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft
import random

# -------------------------------------------------------------
# Config
# -------------------------------------------------------------

nfft = 10
fft_size = 2**nfft

sig_a = 31   # amplitude
sig_p = 15   # phase
noise_val = 70

t = [i for i in range(fft_size)]

# -------------------------------------------------------------
# Create signal
# -------------------------------------------------------------
dre = [np.round(sig_a * np.cos(sig_p * (i-1) * 2 * np.pi / fft_size)) for i in range(fft_size)]
dim = [np.round(sig_a * np.sin(sig_p * (i-1) * 2 * np.pi / fft_size)) for i in range(fft_size)]


# -------------------------------------------------------------
# Add noise to signal
# -------------------------------------------------------------
for i in range(fft_size):
	dre[i] += random.randrange(-noise_val, noise_val)
	dim[i] += random.randrange(-noise_val, noise_val)

# -------------------------------------------------------------
# FFT
# -------------------------------------------------------------

data = [complex(dre[i], dim[i]) for i in range(fft_size)]

spect = fft(data)

sre = [spect[i].real for i in range(fft_size)]
sim = [spect[i].imag for i in range(fft_size)]

# -------------------------------------------------------------
# Plots
# -------------------------------------------------------------
titles = ['dre', 'dim', 'sre', 'sim']
plots = [dre, dim, sre, sim]
ymax = [np.floor(np.min(dre+dim)), np.floor(np.min(dre+dim)), np.floor(np.min(sre+sim)), np.floor(np.min(sre+sim))]
ymin = [np.ceil(np.max(dre+dim)), np.ceil(np.max(dre+dim)), np.ceil(np.max(sre+sim)), np.ceil(np.max(sre+sim))]

for i in range(4):
	plt.subplot(2, 2, i+1)
	plt.title(titles[i]) 
	plt.plot(t, plots[i])
	# plt.stem(t, dre, use_line_collection=True)
	# plt.step(t, x)
	plt.xlim([0, fft_size])
	plt.yticks(np.linspace(ymin[i], ymax[i], 9))
	plt.grid(True)


plt.show()