import modelsim
import numpy as np


# -----------------------------------------------------------------------
#
# -----------------------------------------------------------------------
def run_test(params: dict, verbose=True):
	# print status
	if verbose:
		teststring = ""

		for key, value in params.items():
			teststring += "{}={:4} ".format(key, str(value))

		print(teststring, end='')

	# temp file for output data
	result_file = "" 
	params["OUT_FILE"] = result_file
	params["IN_FILES"] += ""

	# prepare ethalon data result

	# run modelsim 
	# modelsim.run_with_params(folder="./modelsim", script="../batch_test.tcl", **params)

	# compare results
	result = "UNKNOWN"

	# print results
	if verbose: 
		print(" - {}".format(result))

	return 1 if result else 0

if __name__ == '__main__':
	# lists of parameter values
	DATA_WIDTH = [8, 16, 32]
	TWDL_WIDTH = [8, 16, 24]
	MODE = ["UNSCALED"]
	XSERIES = ["NEW", "UNI"]
	FFT_SIZE = [64, 512, 1024, 2048, 8192]
	IN_SIGNALS = ["sin", "square", "saw"]

	# iterate through all the possible conbinations
	for xser in XSERIES:
		for md in MODE:
			for dw in DATA_WIDTH:
				for tw in TWDL_WIDTH:
					for size in FFT_SIZE:
						for sig in IN_SIGNALS:
							params = {
								"NFFT"       : int(np.log2(size)),
								"DATA_WIDTH" : dw,
								"TWDL_WIDTH" : tw,
								"MODE"       : md,
								"XSERIES"    : xser,
								"IN_FILE"    : sig,
							}
							run_test(params)


