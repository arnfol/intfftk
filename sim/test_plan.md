# FFT test plan

## Perfect plan
* Parameters and their ranges to test:
    * DATA_WIDTH: 8, 16, 32
    * TWDL_WIDTH: 8, 16, 24
    * MODE: UNSCALED, SCALED, ROUNDED
    * XSERIES: "OLD", "NEW", "UNI"   
    * NFFT: 64, 512, 1024, 2048, 8192
    * USE_MLT: 1, 0
* Operation modes to test:
	* Bypass mode (FLY_FWD=0)
* Input valid randomization
* Input signals to test
	* Sin wave
	* Square wave
	* Sawtooth wave
* Check long-run work

## Realistic plan
* Parameters and their ranges to test:
    * DATA_WIDTH: 8, 16, 32
    * TWDL_WIDTH: 8, 16, 24
    * MODE: UNSCALED
    * XSERIES: "NEW", "UNI"   
    * NFFT: 64, 512, 1024, 2048, 8192
* Input valid randomization
* Input signals to test
	* Sin wave
	* Square wave
	* Sawtooth wave