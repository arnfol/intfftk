# -------------------------------------------------------------------
# config
# -------------------------------------------------------------------

set worklib "work"
set top_lvl "fft_test"
set macro_file ""
set do_wave "false"
set dsp48_dummy "false"

set cmd "vsim \"$worklib.$top_lvl\" "

# Run vsim command with generics parsed from args passed to this script
if {$argc > 0} {
	foreach param [lrange [lindex $argv end] 2 end] {
		# set param [split $a "="]
        set cmd "$cmd-G$param "
	}
}

# -------------------------------------------------------------------
# make libs
# -------------------------------------------------------------------

vlib $worklib
if {$dsp48_dummy} { vlib unisim }

# -------------------------------------------------------------------
# compile
# -------------------------------------------------------------------

# package-replacement for Xilinx DSP components
if {$dsp48_dummy} {
	vcom -work unisim "../../src/vhdl/math/vcomponents.vhd"
} 

# source files
vcom -work $worklib {*}" \
../../src/vhdl/math/mults/mlt25x18_dsp48.vhd \
../../src/vhdl/math/mults/mlt35x25_dsp48e1.vhd \
../../src/vhdl/math/mults/mlt35x27_dsp48e2.vhd \
../../src/vhdl/math/mults/mlt42x18_dsp48e1.vhd \
../../src/vhdl/math/mults/mlt44x18_dsp48e2.vhd \
../../src/vhdl/math/mults/mlt52x25_dsp48e1.vhd \
../../src/vhdl/math/mults/mlt52x27_dsp48e2.vhd \
../../src/vhdl/math/mults/mlt59x18_dsp48e1.vhd \
../../src/vhdl/math/mults/mlt61x18_dsp48e2.vhd \
../../src/vhdl/math/int_addsub_dsp48.vhd \
../../src/vhdl/math/cmult/int_cmult_dbl18_dsp48.vhd \
../../src/vhdl/math/cmult/int_cmult_dbl35_dsp48.vhd \
../../src/vhdl/math/cmult/int_cmult_trpl18_dsp48.vhd \
../../src/vhdl/math/cmult/int_cmult_trpl52_dsp48.vhd \
../../src/vhdl/math/cmult/int_cmult18x25_dsp48.vhd \
../../src/vhdl/math/cmult/int_cmult_dsp48.vhd \
../../src/vhdl/twiddle/row_twiddle_tay.vhd \
../../src/vhdl/twiddle/rom_twiddle_int.vhd \
../../src/vhdl/buffers/ramb_tdp_rw.vhd \
../../src/vhdl/delay/int_align_fft.vhd \
../../src/vhdl/delay/int_align_ifft.vhd \
../../src/vhdl/delay/int_delay_line.vhd \
../../src/vhdl/delay/int_delay_line_old.vhd \
../../src/vhdl/delay/int_delay_wrap.vhd \
../../src/vhdl/buffers/inbuf_half_path.vhd \
../../src/vhdl/buffers/inbuf_half_wrap.vhd \
../../src/vhdl/buffers/int_bitrev_cache.vhd \
../../src/vhdl/buffers/int_bitrev_order.vhd \
../../src/vhdl/buffers/iobuf_flow_int2.vhd \
../../src/vhdl/buffers/iobuf_wrap_int2.vhd \
../../src/vhdl/buffers/outbuf_half_path.vhd \
../../src/vhdl/buffers/ramb_tdp_one_clk2.vhd \
../../src/vhdl/fft/int_dif2_fly.vhd \
../../src/vhdl/fft/int_dit2_fly.vhd \
../../src/vhdl/fft/int_fftNk.vhd \
../../src/vhdl/fft/int_ifftNk.vhd \
../../src/vhdl/main/int_fft_ifft_pair.vhd \
../../src/vhdl/main/int_fft_single_path.vhd \
"

# testbench
vcom -work $worklib "../../src/vhdl/tb/fft_test.vhd"

# -------------------------------------------------------------------
# simulate
# -------------------------------------------------------------------

# some windows
if {$do_wave} {
	view structure
	view signals
	view wave
}

eval $cmd

if {!($macro_file eq "")} { do $macro_file }

# run
if {$do_wave} { configure wave -timelineunits ns }
run -all
if {$do_wave} { wave zoom full}

exit