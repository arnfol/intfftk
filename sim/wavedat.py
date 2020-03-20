import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft
from scipy import signal
import random


# -------------------------------------------------------------
# Methods
# -------------------------------------------------------------
def gen_wave(size, period, amp, wavetype):
	"""Genereate list of values according to the provided parameters"""
	t = np.linspace(0, 1, size)
	phase = 0

	if wavetype == "sawtooth":
		return [int(s) for s in amp * signal.sawtooth(period * t)]
	elif wavetype == "triangle":
		return [int(s) for s in amp * signal.sawtooth(period * t, 0.5)]
	elif wavetype == "square":
		return [int(s) for s in amp * signal.square(period * t)]
	elif wavetype == "complsin":
		return [complex(int(s.real),int(s.imag)) for s in amp * np.exp(1j*(period*t + phase))]
	elif wavetype == "sin":
		return [int(s) for s in amp * np.sin(period * t + phase)]


def write_dat(wave, filename):
	"""Output list of complex values to file"""
	with open(filename, mode='w') as f:
		for n in wave:
			f.write("{} {}\n".format(int(n.real), int(n.imag)))


def read_dat(filename, size, packet_num=1):
	"""Read .dat file and returns the list of complex values.
	.dat file can contain several data packets, so the number 
	of the packet to read should be provided"""

	packet = []

	with open(filename, "r") as f:
		# skip first packets
		for _ in range((packet_num-1)*size):
			next(f)

		# read packet
		for _ in range(size):
			l = f.readline().split()
			packet.append(complex(int(l[0]), int(l[1])))

	return packet


def add_noise(wave, noise_amp):
	"""Add random noise to the provided list"""
	for i, w in enumerate(wave):
		re = w.real + random.randrange(-noise_amp, noise_amp)
		im = w.imag + random.randrange(-noise_amp, noise_amp)
		wave[i] = complex(re, im)


def plot_complex_data(data:dict):
	titles = []
	for x in data.keys():
		titles.append(x + " Re")
		titles.append(x + " Im")

	plots = []
	for d in data.values():
		plots.append([x.real for x in d])
		plots.append([x.imag for x in d])

	if len(data) > 1:
		plt.subplots_adjust(hspace=0.7)

	for i in range(len(plots)):
		t = range(len(plots[i]))
		plt.subplot(len(data), 2, i+1)
		plt.title(titles[i]) 
		plt.plot(t, plots[i])
		# plt.stem(t, dre, use_line_collection=True)
		# plt.step(t, x)
		plt.xlim([0, len(plots[i])])
		# plt.yticks(np.linspace(ymin[i], ymax[i], 9))
		plt.grid(True)


	plt.show()


# -------------------------------------------------------------
# 
# -------------------------------------------------------------
if __name__ == '__main__':

	nfft = 10
	fft_size = 2 ** nfft
	data_width = 16
		
	sin      = gen_wave(size=fft_size, period=5*2*np.pi, amp=2**(data_width-1), wavetype="sin")
	sawtooth = gen_wave(size=fft_size, period=5*2*np.pi, amp=2**(data_width-1), wavetype="sawtooth")
	triangle = gen_wave(size=fft_size, period=5*2*np.pi, amp=2**(data_width-1), wavetype="triangle")
	square   = gen_wave(size=fft_size, period=5*2*np.pi, amp=2**(data_width-1), wavetype="square")
	complsin = gen_wave(size=fft_size, period=5*2*np.pi, amp=2**(data_width-1), wavetype="complsin")

	data = {
		"sin"      : sin,
		"sawtooth" : sawtooth,
		"triangle" : triangle,
		"square"   : square,
		"complsin" : complsin,
	}

	# for k, i in data.items():
	# 	add_noise(i, 30)

	plot_complex_data(data)