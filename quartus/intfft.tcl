package require ::quartus::project
package require ::quartus::flow

# -----------------------------------------------------------------------
# Project config
# -----------------------------------------------------------------------
# Create the project and overwrite any settings and files that exist
project_new intfft -overwrite

set_global_assignment -name FAMILY "Arria V"
set_global_assignment -name DEVICE "5AGXFB3H4F35C5"
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY "output_files"
set_global_assignment -name TOP_LEVEL_ENTITY "int_fftNk"

# # Check that the right project is open
# if {[is_project_open]} {
# 	if {[string compare $quartus(project) "int_addsub_dsp48"]} {
# 		puts "Project int_addsub_dsp48 is not open"
# 	}
# } else {
# 	# Only open if not already open
# 	if {[project_exists int_addsub_dsp48]} {
# 		project_open -revision int_addsub_dsp48 int_addsub_dsp48
# 	} else {
# 		project_new -revision int_addsub_dsp48 int_addsub_dsp48
# 	}
# }


# -----------------------------------------------------------------------
# Source files
# -----------------------------------------------------------------------
set_global_assignment -name VHDL_FILE ../../src/vhdl/main/xilinx_dsp.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/mults/mlt25x18_dsp48.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/mults/mlt35x25_dsp48e1.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/mults/mlt35x27_dsp48e2.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/mults/mlt42x18_dsp48e1.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/mults/mlt44x18_dsp48e2.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/mults/mlt52x25_dsp48e1.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/mults/mlt52x27_dsp48e2.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/mults/mlt59x18_dsp48e1.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/mults/mlt61x18_dsp48e2.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/int_addsub_dsp48.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/cmult/int_cmult_dbl18_dsp48.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/cmult/int_cmult_dbl35_dsp48.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/cmult/int_cmult_trpl18_dsp48.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/cmult/int_cmult_trpl52_dsp48.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/cmult/int_cmult18x25_dsp48.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/math/cmult/int_cmult_dsp48.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/twiddle/row_twiddle_tay.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/twiddle/rom_twiddle_int.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/buffers/ramb_tdp_rw.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/delay/int_align_fft.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/delay/int_align_ifft.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/delay/int_delay_line.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/delay/int_delay_line_old.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/delay/int_delay_wrap.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/buffers/inbuf_half_path.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/buffers/inbuf_half_wrap.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/buffers/int_bitrev_cache.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/buffers/int_bitrev_order.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/buffers/iobuf_flow_int2.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/buffers/iobuf_wrap_int2.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/buffers/outbuf_half_path.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/buffers/ramb_tdp_one_clk2.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/fft/int_dif2_fly.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/fft/int_dit2_fly.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/fft/int_fftNk.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/fft/int_ifftNk.vhd 
set_global_assignment -name VHDL_FILE ../../src/vhdl/main/int_fft_single_path.vhd 

# set_global_assignment -name SDC_FILE constr.sdc

# -----------------------------------------------------------------------
# HDL parameters
# -----------------------------------------------------------------------
set_parameter -name XSER "UNI"
set_parameter -name NFFT 8
set_parameter -name DATA_WIDTH 16
set_parameter -name TWDL_WIDTH 16

# -----------------------------------------------------------------------
# Virtual pins for IP compile
# -----------------------------------------------------------------------
proc make_all_pins_virtual_except { args } {

    remove_all_instance_assignments -name VIRTUAL_PIN
    execute_module -tool map
    set name_ids [get_names -filter * -node_type pin]

    foreach_in_collection name_id $name_ids {
        set pin_name [get_name_info -info full_path $name_id]

        if { -1 == [lsearch -exact $args $pin_name] } {
            post_message "Making VIRTUAL_PIN assignment to $pin_name"
            set_instance_assignment -to $pin_name -name VIRTUAL_PIN ON
        } else {
            post_message "Skipping VIRTUAL_PIN assignment to $pin_name"
        }
    }
}

make_all_pins_virtual_except { CLK }

# -----------------------------------------------------------------------
# 
# -----------------------------------------------------------------------
export_assignments
# compile the project
execute_flow -compile
project_close


