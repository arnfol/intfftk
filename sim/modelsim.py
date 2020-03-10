import subprocess

def run_with_params(folder: str, script: str, logfile="../vsim.log", modelsim_path="vsim", **kwargs):
	"""
	Runs modelsim with dict of parameters.
	If logfile="" log file will not be created.
	"""
	vsim = 'cd ' + folder + ' && '
	vsim += 'vsim -c -do "do ' + script + ' '

	vsim += ' '.join('%s=%s' % x for x in kwargs.items()) 
	vsim += '"' 

	if logfile != "": vsim += ' > ' + logfile

	# print(vsim)

	subprocess.call(vsim, shell=True)

if __name__ == '__main__':

	params = {
		"NFFT"       : 10,
		"DATA_WIDTH" : 16,
		"TWDL_WIDTH" : 16,
		"MODE"       : "UNSCALED",
		"XSERIES"    : "UNI",
		"IN_FILE"    : "../../math/di_single.dat",
		"OUT_FILE"   : "../../math/do_single_unscaled1.dat"
	}
	
	run_with_params(folder="./modelsim", script="../batch_test.tcl", **params)

