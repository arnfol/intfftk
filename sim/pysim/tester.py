import configparser 
import itertools
import pprint
from math import ceil

pp = pprint.PrettyPrinter(indent=4)

class Tester():
	"""docstring for Tester"""
	def __init__(self, cfgfile):
		self.cfg = configparser.ConfigParser()
		self.cfg.optionxform = str
		self.cfg.read(cfgfile)

	def run_test(self, params: dict):
		"""User-defined single test method. Should return 1 if test is OK, 0 if test fails,
		or any other user-defined error code presented in config file"""
		pass

	def run(self, verbose=True):
		""" Runs run_test method with all combinations of params in config file """

		# read and convert config file to dict
		params = dict(self.cfg.items("params"))
		max_str_len = {}
		for k, v in params.items():
			params[k] = [x.strip() for x in v.split(",")]
			# get max parameter string len for pretty output
			max_str_len[k]= max([len(x) for x in params[k]]) 

		# get all combinations of parameters
		test_combinations = list(itertools.product(*list(params.values())))

		# get config-defined test errors
		try:
			err_codes = dict(self.cfg.items("error codes"))
		except configparser.NoSectionError:
			err_codes = {"0": "FAIL", "1": "OK"}

		# Run tests
		print("Running {} test combinations.\n".format(len(test_combinations)))
		result = [] # list of results of all tests
		for i, t in enumerate(test_combinations):
			run_params = dict(zip(params.keys(), t))

			# print parameter string
			if verbose:
				teststring = 'Run test #{:<{width}} : '.format(i+1, width=len(str(len(test_combinations))))
				for key, value in run_params.items():
					teststring += "{}={:{width}} ".format(key, str(value), width=max_str_len[key])
				print(teststring, end='')
				
			# run testing method
			res = self.run_test(run_params)

			# print the result
			print(" - ", end='')
			if verbose:
				if str(res) in err_codes.keys():
					print(err_codes[str(res)], end='')
				else:
					print("UNKNOWN", end='')

			print(", {:3.1f}% complete".format((i+1)*100/len(test_combinations)))
			result.append(res)

		return result

if __name__ == '__main__':
	tst = Tester("../testing.ini")
	tst.run()