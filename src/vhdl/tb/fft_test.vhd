-------------------------------------------------------------------------------
--
-- Title       : fft_test
-- Design      : fpfftk
-- Author      : Kapitanov Alexander
-- Company     : 
-- E-mail      : sallador@bk.ru
--
-- Description : Testbench file for complex testing FFT / IFFT
--
-- Has several important constants:
--
--   NFFT          - (p) - Number of stages = log2(FFT LENGTH)
--   SCALE         - (s) - Scale factor for float-to-fix transform
--   DATA_WIDTH    - (p) - Data width for signal imitator: 8-32 bits.
--   TWDL_WIDTH    - (p) - Data width for twiddle factor : 16-24 bits.
--
--   RAMB_TYPE     - (p) - Cross-commutation type: "WRAP" / "CONT"
--       "WRAP" - data valid strobe can be bursting (no need continuous valid),
--       "CONT" - data valid must be continuous (strobe length = N/2 points);
--
--   OWIDTH        - (p) - Data width for signal output: 16, 24, 32 bits.
--   FLY_FWD       - (s) - Use butterflies into Forward FFT: 1 - TRUE, 0 - FALSE
--   DBG_FWD       - (p) - 1 - Debug in FFT (save file in FP32 on selected stage)    
--   DT_RND        - (s) - Data output multiplexer for rounding            
--   XSERIES       - (p) - FPGA Series: ULTRASCALE / 7SERIES
--   USE_MLT       - (p) - Use Multiplier for calculation M_PI in Twiddle factor
--   MODE          - (p) - Select output data format and roun mode
--
--           - "UNSCALED" - Output width = Input width + log(N)
--           - "ROUNDING" - Output width = Input width, use round()
--           - "TRUNCATE" - Output width = Input width, use floor()
--
--   Old modes: 
--
--   FORMAT        - (p) - 1 - Use Unscaled mode / 0 - Scaled (truncate) mode
--   RNDMODE       - (p) - 1 - Round, 0 - Floor, while (FORMAT = 0)
--
-- where: (p) - generic parameter, (s) - signal.
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
--  GNU GENERAL PUBLIC LICENSE
--  Version 3, 29 June 2007
--
--  Copyright (c) 2018 Kapitanov Alexander
--
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
--  THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
--  APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT 
--  HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY 
--  OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, 
--  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
--  PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM 
--  IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF 
--  ALL NECESSARY SERVICING, REPAIR OR CORRECTION. 
-- 
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

use ieee.std_logic_textio.all;
use std.textio.all;    

entity fft_test is 
    generic (
            NFFT            : integer:=10; -- Number of stages = log2(FFT LENGTH)
            DATA_WIDTH      : integer:=16; -- Data width for signal imitator    : 8-32.
            TWDL_WIDTH      : integer:=16; -- Data width for twiddle factor     : 16-24.
            FLY_FWD         : std_logic:='1'; -- 1 - Use butterflies for Forward FFT    
            USE_MLT         : boolean:=FALSE; -- 1 - Use Multiplier for calculation M_PI
            RAMB_TYPE       : string:="WRAP"; -- Cross-commutation type: WRAP / CONT
            MODE            : string:="UNSCALED";
            XSERIES         : string:="NEW"; -- FPGA Series: ULTRA / 7SERIES
            IN_FILE         : string:="../../math/di_single.dat";
            OUT_FILE        : string:="../../math/do_single_unscaled.dat"
        );
end fft_test;

architecture fft_test of fft_test is           
  
function set_mode(inmod: string) return integer is
begin
    if    (inmod = "UNSCALED") then return  2;
    elsif (inmod = "ROUNDING") then return  1;
    elsif (inmod = "TRUNCATE") then return  0;
    else                            return -1;
    end if;
end function;

-- **************************************************************** --
-- **** Constant declaration: change any parameter for testing **** --
-- **************************************************************** --
----------------------------------------------------------------
constant FORMAT         : integer:=set_mode(MODE)/2;
constant RNDMOD         : integer:=(set_mode(MODE) mod 2);

-- **************************************************************** --
-- ********* Signal declaration: clocks, reset, data etc. ********* --
-- **************************************************************** --
signal clk               : std_logic:='0';
signal rstn              : std_logic:='0';
signal rstp              : std_logic:='1';
signal start             : std_logic:='0';
---------------- In / Out data ----------------    
signal di_re             : std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0'); 
signal di_im             : std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0'); 
signal di_en             : std_logic:='0';

signal do_re    : std_logic_vector(1*NFFT+DATA_WIDTH-1 downto 0);
signal do_im    : std_logic_vector(1*NFFT+DATA_WIDTH-1 downto 0);
signal do_vl    : std_logic;

begin

clk <= not clk after 5 ns;
rstn <= '0', '1' after 30 ns;
rstp <= not rstn;
start <= '0', '1' after 100 ns;

---------------------------------------------------------------- 
read_signal: process is
    file fl_data      : text;
    constant fl_path  : string:=IN_FILE;

    variable l        : line;    
    variable lt1      : integer:=0; 
    variable lt2      : integer:=0; 
begin            
    wait for 5 ns;
    if (rstp = '1') then    
        di_en <= '0';
        di_re <= (others => '0');
        di_im <= (others => '0');
    else    
        -- wait for 100 ns;
        wait until (start = '1');
        
        -- loop consistent packets
        lp1: for ii in 0 to 6 loop
            file_open( fl_data, fl_path, read_mode );

            while not endfile(fl_data) loop
                wait until rising_edge(clk);
                    readline( fl_data, l );
                    read( l, lt1 ); read( l, lt2 );

                    di_re <= conv_std_logic_vector( lt1, DATA_WIDTH );
                    di_im <= conv_std_logic_vector( lt2, DATA_WIDTH );
                    di_en <= '1'; 
            end loop;
        
            wait until rising_edge(clk);
            di_en <= '0';
            di_re <= (others => '0');
            di_im <= (others => '0');

            file_close( fl_data);
        end loop;
        
        wait until rising_edge(clk);
        wait until rising_edge(clk);

        -- send 1 packet with inconsistent valid
        file_open( fl_data, fl_path, read_mode );

        while not endfile(fl_data) loop
            wait until rising_edge(clk);
                readline( fl_data, l ); 
                read( l, lt1 ); read( l, lt2 );     
                
                di_re <= conv_std_logic_vector( lt1, DATA_WIDTH );
                di_im <= conv_std_logic_vector( lt2, DATA_WIDTH );
                di_en <= '1'; 
                
                wait until rising_edge(clk);
                di_en <= '0';
                di_re <= (others => '0');
                di_im <= (others => '0');
                wait until rising_edge(clk);
                wait until rising_edge(clk);
        end loop;
        
        file_close( fl_data);
        
        lp2_Nk: for ii in 0 to 15 loop
            wait until rising_edge(clk);
        end loop;

        di_en <= 'X';
        di_re <= (others => 'X');
        di_im <= (others => 'X');
        wait for 20 us;
        
        report "simulation finished successfully" severity FAILURE;

    end if;
end process; 


write_singnals: process(clk) is -- write file_io.out (++ done goes to '1')
    file un_log    : TEXT open WRITE_MODE is OUT_FILE;
    variable stx   : LINE;
    variable spc   : string(1 to 4) := (others => ' ');    
begin
    if rising_edge(clk) then

        if (do_vl = '1') then
            write(stx, CONV_INTEGER(do_re), LEFT);
            write(stx, spc);
            write(stx, CONV_INTEGER(do_im), LEFT);
            writeline(un_log, stx);
        end if;
        
    end if;
end process;
    
UUT: entity work.int_fft_single_path
    generic map (
        DATA_WIDTH  => DATA_WIDTH,
        TWDL_WIDTH  => TWDL_WIDTH,
        -- MODE        => "UNSCALED",
        FORMAT      => FORMAT,
        RNDMODE     => RNDMOD,
        XSERIES     => XSERIES,
        NFFT        => NFFT,
        USE_MLT     => USE_MLT
    )
    port map ( 
        ---- Common signals ----
        RESET       => rstp,
        CLK         => clk,    
        ---- Input data ----
        DI_RE       => di_re,
        DI_IM       => di_im,
        DI_EN       => di_en,
        ---- Output data ----
        DO_RE       => do_re,
        DO_IM       => do_im,
        DO_VL       => do_vl,
        ---- Butterflies ----
        FLY_FWD     => fly_fwd
    );

------------------------------------------------
end fft_test; 