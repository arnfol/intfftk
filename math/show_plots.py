import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft

# -------------------------------------------------------------
# Config
# -------------------------------------------------------------

nfft = 10
fft_size = 2**nfft
t = [i for i in range(fft_size)]

packet_num = 1
# files = ["do_single_round.dat", "do_single_scaled.dat", "do_single_unscaled.dat", "do_single_unscaled_uni.dat"]
files = ["do_single_unscaled.dat"]

do_round = []
do_scaled = []
do_unscaled = []
do_unscaled_uni = []
# packet = [do_round, do_scaled, do_unscaled, do_unscaled_uni]
packets = [do_unscaled]


# -------------------------------------------------------------
# Read results from .dat files
# -------------------------------------------------------------
for i, f in enumerate(files):
	with open(f, "r") as inp:
		for _ in range(fft_size):
			l = inp.readline().split()
			packets[i].append(complex(int(l[0]), int(l[1])))


# -------------------------------------------------------------
# Plots
# -------------------------------------------------------------
# titles = ["do_round", "do_scaled", "do_unscaled", "do_unscaled_uni"]
titles = ["unscaled_re", "unscaled_im"]
plots = [[x.real for x in do_unscaled], [x.imag for x in do_unscaled]]
ymin = [np.floor(np.min([x.real for x in do_unscaled])), np.floor(np.min([x.imag for x in do_unscaled]))]
ymax = [np.ceil(np.max([x.real for x in do_unscaled])), np.ceil(np.max([x.imag for x in do_unscaled]))]

for i in range(packets.size()):
	plt.subplot(2, 2, i+1)
	plt.title(titles[i]) 
	plt.plot(t, plots[i])
	# plt.stem(t, dre, use_line_collection=True)
	# plt.step(t, x)
	plt.xlim([0, fft_size])
	plt.yticks(np.linspace(ymin[i], ymax[i], 9))
	plt.grid(True)


plt.show()