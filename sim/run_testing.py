from pysim import modelsim
from pysim import tester
import wavedat
import numpy as np
from scipy.fft import fft
from pprint import PrettyPrinter

pp = PrettyPrinter()

class TesterFFT(tester.Tester):

	def run_test(self, params: dict):
		fft_size = 2**int(params["NFFT"])

		# prepare input data file 
		in_data = wavedat.gen_wave(size=fft_size, period=5*2*np.pi, 
		amp=2**(int(params["DATA_WIDTH"])-1), wavetype=params["IN_SIGNAL"])
		del params["IN_SIGNAL"]

		## TODO: mkdir data if not exists
		in_file = "data/in_file.dat" 
		wavedat.write_dat(in_data, in_file)
		params["IN_FILE"] = "../" + in_file # correct relative path if modelsim is running from another folder 

		# temp file for output data
		out_file = "data/out_file.dat" 
		params["OUT_FILE"] = "../" + out_file # correct relative path if modelsim is running from another folder 

		# prepare ethalon data result
		math_data = [complex(round(i.real),round(i.imag)) for i in fft(in_data)]

		# run modelsim 
		modelsim.run_with_params(folder="./modelsim", script="../batch_test.tcl", **params)
		tb_data = wavedat.read_dat(out_file, fft_size)

		# wavedat.plot_complex_data({"math" : math_data, "tb" : tb_data})
		# exit()

		# compare results
		result = 1 # OK by default
		diff = 5
		for i in range(len(math_data)):
			if not -diff < (math_data[i].real - tb_data[i].real) < diff \
			or not -diff < (math_data[i].imag - tb_data[i].imag) < diff:
				result = 0 # if error found
				break

		# if result == 0:
		# 	wavedat.plot_complex_data({"math" : math_data, "tb" : tb_data})
		# 	exit()

		return result

if __name__ == '__main__':
	tst = TesterFFT("./testing_tmp.ini")
	tst.run()


