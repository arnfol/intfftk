onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group UNSCALED /fft_signle_test/xUUT/UUT_UNSCALED/CLK
add wave -noupdate -expand -group UNSCALED /fft_signle_test/xUUT/UUT_UNSCALED/RESET
add wave -noupdate -expand -group UNSCALED /fft_signle_test/xUUT/UUT_UNSCALED/DI_EN
add wave -noupdate -expand -group UNSCALED /fft_signle_test/xUUT/UUT_UNSCALED/DI_IM
add wave -noupdate -expand -group UNSCALED /fft_signle_test/xUUT/UUT_UNSCALED/DI_RE
add wave -noupdate -expand -group UNSCALED /fft_signle_test/xUUT/UUT_UNSCALED/DO_IM
add wave -noupdate -expand -group UNSCALED /fft_signle_test/xUUT/UUT_UNSCALED/DO_RE
add wave -noupdate -expand -group UNSCALED /fft_signle_test/xUUT/UUT_UNSCALED/DO_VL
add wave -noupdate -group SCALED /fft_signle_test/xUUT/UUT_SCALED/CLK
add wave -noupdate -group SCALED /fft_signle_test/xUUT/UUT_SCALED/DI_EN
add wave -noupdate -group SCALED /fft_signle_test/xUUT/UUT_SCALED/DI_IM
add wave -noupdate -group SCALED /fft_signle_test/xUUT/UUT_SCALED/DI_RE
add wave -noupdate -group SCALED /fft_signle_test/xUUT/UUT_SCALED/RESET
add wave -noupdate -group SCALED /fft_signle_test/xUUT/UUT_SCALED/DO_IM
add wave -noupdate -group SCALED /fft_signle_test/xUUT/UUT_SCALED/DO_RE
add wave -noupdate -group SCALED /fft_signle_test/xUUT/UUT_SCALED/DO_VL
add wave -noupdate -group ROUND /fft_signle_test/xUUT/UUT_ROUND/CLK
add wave -noupdate -group ROUND /fft_signle_test/xUUT/UUT_ROUND/DI_EN
add wave -noupdate -group ROUND /fft_signle_test/xUUT/UUT_ROUND/DI_IM
add wave -noupdate -group ROUND /fft_signle_test/xUUT/UUT_ROUND/DI_RE
add wave -noupdate -group ROUND /fft_signle_test/xUUT/UUT_ROUND/RESET
add wave -noupdate -group ROUND /fft_signle_test/xUUT/UUT_ROUND/DO_IM
add wave -noupdate -group ROUND /fft_signle_test/xUUT/UUT_ROUND/DO_RE
add wave -noupdate -group ROUND /fft_signle_test/xUUT/UUT_ROUND/DO_VL
add wave -noupdate -expand -group UNSCALED_UNI /fft_signle_test/xUUT/UUT_UNSCALED_UNI/CLK
add wave -noupdate -expand -group UNSCALED_UNI /fft_signle_test/xUUT/UUT_UNSCALED_UNI/RESET
add wave -noupdate -expand -group UNSCALED_UNI /fft_signle_test/xUUT/UUT_UNSCALED_UNI/DI_EN
add wave -noupdate -expand -group UNSCALED_UNI /fft_signle_test/xUUT/UUT_UNSCALED_UNI/DI_IM
add wave -noupdate -expand -group UNSCALED_UNI /fft_signle_test/xUUT/UUT_UNSCALED_UNI/DI_RE
add wave -noupdate -expand -group UNSCALED_UNI /fft_signle_test/xUUT/UUT_UNSCALED_UNI/DO_IM
add wave -noupdate -expand -group UNSCALED_UNI /fft_signle_test/xUUT/UUT_UNSCALED_UNI/DO_RE
add wave -noupdate -expand -group UNSCALED_UNI /fft_signle_test/xUUT/UUT_UNSCALED_UNI/DO_VL
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {66811388 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {126 us}
