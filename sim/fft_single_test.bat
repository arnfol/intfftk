if not exist ".\modelsim" mkdir .\modelsim
cd .\modelsim
vsim -do ..\run.tcl
rem vsim -do "do ..\run.tcl args"