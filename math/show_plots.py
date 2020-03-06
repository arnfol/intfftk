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
files = ["do_single_round.dat", "do_single_scaled.dat", "do_single_unscaled.dat", "do_single_unscaled_uni.dat"]
# files = ["do_single_unscaled.dat"]

# -------------------------------------------------------------
# Read results from .dat files
# -------------------------------------------------------------

def read_dat(filename, packet_num=1):
	packet = []

	with open(filename, "r") as f:
		# skip first packets
		for _ in range((packet_num-1)*fft_size):
			next(f)

		# read packet
		for _ in range(fft_size):
			l = f.readline().split()
			packet.append(complex(int(l[0]), int(l[1])))

	return packet

packets = [read_dat(f, packet_num) for f in files]

# -------------------------------------------------------------
# Plots
# -------------------------------------------------------------

def plot_packet(packets, titles):

	if len(packets) > 1:
		plt.subplots_adjust(hspace=0.5)

	for i in range(len(packets)):
		tit = [titles[i] + " RE", titles[i] + " IM"]

		plots = [[x.real for x in packets[i]], [x.imag for x in packets[i]]]

		ymin = [np.floor(np.min([x.real for x in packets[i]])), np.floor(np.min([x.imag for x in packets[i]]))]
		ymax = [np.ceil(np.max([x.real for x in packets[i]])), np.ceil(np.max([x.imag for x in packets[i]]))]

		for j in range(2):
			plt.subplot(len(packets), 2, j+1+i*2)
			plt.title(tit[j]) 
			plt.plot(t, plots[j])
			# plt.stem(t, dre, use_line_collection=True)
			# plt.step(t, x)
			plt.xlim([0, fft_size])
			plt.yticks(np.linspace(ymin[j], ymax[j], 9))
			plt.grid(True)

	plt.show()


plot_packet(packets, files)