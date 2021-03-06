
-----------------------------------------------------------------------
--
-- Replacement for unisim.vcomponents, if unisim is undefined and 
-- XSER="UNI" is used.
--
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package vcomponents is
        
    component DSP48E2
        generic (
            ACASCREG                  : integer                       := 1              ;
            ADREG                     : integer                       := 1              ;
            ALUMODEREG                : integer                       := 1              ;
            AMULTSEL                  : string                        := "A"            ;
            AREG                      : integer                       := 1              ;
            AUTORESET_PATDET          : string                        := "NO_RESET"     ;
            AUTORESET_PRIORITY        : string                        := "RESET"        ;
            A_INPUT                   : string                        := "DIRECT"       ;
            BCASCREG                  : integer                       := 1              ;
            BMULTSEL                  : string                        := "B"            ;
            BREG                      : integer                       := 1              ;
            B_INPUT                   : string                        := "DIRECT"       ;
            CARRYINREG                : integer                       := 1              ;
            CARRYINSELREG             : integer                       := 1              ;
            CREG                      : integer                       := 1              ;
            DREG                      : integer                       := 1              ;
            INMODEREG                 : integer                       := 1              ;
            IS_ALUMODE_INVERTED       : std_logic_vector(3 downto 0) := "0000"         ;
            IS_CARRYIN_INVERTED       : bit                           := '0'            ;
            IS_CLK_INVERTED           : bit                           := '0'            ;
            IS_INMODE_INVERTED        : std_logic_vector(4 downto 0) := "00000"        ;
            IS_OPMODE_INVERTED        : std_logic_vector(8 downto 0) := "000000000"    ;
            IS_RSTALLCARRYIN_INVERTED : bit                           := '0'            ;
            IS_RSTALUMODE_INVERTED    : bit                           := '0'            ;
            IS_RSTA_INVERTED          : bit                           := '0'            ;
            IS_RSTB_INVERTED          : bit                           := '0'            ;
            IS_RSTCTRL_INVERTED       : bit                           := '0'            ;
            IS_RSTC_INVERTED          : bit                           := '0'            ;
            IS_RSTD_INVERTED          : bit                           := '0'            ;
            IS_RSTINMODE_INVERTED     : bit                           := '0'            ;
            IS_RSTM_INVERTED          : bit                           := '0'            ;
            IS_RSTP_INVERTED          : bit                           := '0'            ;
            MASK                      : std_logic_vector(47 downto 0) := X"3FFFFFFFFFFF";
            MREG                      : integer                       := 1              ;
            OPMODEREG                 : integer                       := 1              ;
            PATTERN                   : std_logic_vector(47 downto 0) := X"000000000000";
            PREADDINSEL               : string                        := "A"            ;
            PREG                      : integer                       := 1              ;
            RND                       : std_logic_vector(47 downto 0) := X"000000000000";
            SEL_MASK                  : string                        := "MASK"         ;
            SEL_PATTERN               : string                        := "PATTERN"      ;
            USE_MULT                  : string                        := "MULTIPLY"     ;
            USE_PATTERN_DETECT        : string                        := "NO_PATDET"    ;
            USE_SIMD                  : string                        := "ONE48"        ;
            USE_WIDEXOR               : string                        := "FALSE"        ;
            XORSIMD                   : string                        := "XOR24_48_96"   
        );
        port (
            ACOUT          : out std_logic_vector(29 downto 0);
            BCOUT          : out std_logic_vector(17 downto 0);
            CARRYCASCOUT   : out std_ulogic                   ;
            CARRYOUT       : out std_logic_vector(3 downto 0) ;
            MULTSIGNOUT    : out std_ulogic                   ;
            OVERFLOW       : out std_ulogic                   ;
            P              : out std_logic_vector(47 downto 0);
            PATTERNBDETECT : out std_ulogic                   ;
            PATTERNDETECT  : out std_ulogic                   ;
            PCOUT          : out std_logic_vector(47 downto 0);
            UNDERFLOW      : out std_ulogic                   ;
            XOROUT         : out std_logic_vector(7 downto 0) ;
            A              : in  std_logic_vector(29 downto 0);
            ACIN           : in  std_logic_vector(29 downto 0);
            ALUMODE        : in  std_logic_vector(3 downto 0) ;
            B              : in  std_logic_vector(17 downto 0);
            BCIN           : in  std_logic_vector(17 downto 0);
            C              : in  std_logic_vector(47 downto 0);
            CARRYCASCIN    : in  std_ulogic                   ;
            CARRYIN        : in  std_ulogic                   ;
            CARRYINSEL     : in  std_logic_vector(2 downto 0) ;
            CEA1           : in  std_ulogic                   ;
            CEA2           : in  std_ulogic                   ;
            CEAD           : in  std_ulogic                   ;
            CEALUMODE      : in  std_ulogic                   ;
            CEB1           : in  std_ulogic                   ;
            CEB2           : in  std_ulogic                   ;
            CEC            : in  std_ulogic                   ;
            CECARRYIN      : in  std_ulogic                   ;
            CECTRL         : in  std_ulogic                   ;
            CED            : in  std_ulogic                   ;
            CEINMODE       : in  std_ulogic                   ;
            CEM            : in  std_ulogic                   ;
            CEP            : in  std_ulogic                   ;
            CLK            : in  std_ulogic                   ;
            D              : in  std_logic_vector(26 downto 0);
            INMODE         : in  std_logic_vector(4 downto 0) ;
            MULTSIGNIN     : in  std_ulogic                   ;
            OPMODE         : in  std_logic_vector(8 downto 0) ;
            PCIN           : in  std_logic_vector(47 downto 0);
            RSTA           : in  std_ulogic                   ;
            RSTALLCARRYIN  : in  std_ulogic                   ;
            RSTALUMODE     : in  std_ulogic                   ;
            RSTB           : in  std_ulogic                   ;
            RSTC           : in  std_ulogic                   ;
            RSTCTRL        : in  std_ulogic                   ;
            RSTD           : in  std_ulogic                   ;
            RSTINMODE      : in  std_ulogic                   ;
            RSTM           : in  std_ulogic                   ;
            RSTP           : in  std_ulogic                    
        );
    end component;

    component DSP48E1
        generic (
            ACASCREG            : integer                      := 1              ;
            ADREG               : integer                      := 1              ;
            ALUMODEREG          : integer                      := 1              ;
            AREG                : integer                      := 1              ;
            AUTORESET_PATDET    : string                       := "NO_RESET"     ;
            A_INPUT             : string                       := "DIRECT"       ;
            BCASCREG            : integer                      := 1              ;
            BREG                : integer                      := 1              ;
            B_INPUT             : string                       := "DIRECT"       ;
            CARRYINREG          : integer                      := 1              ;
            CARRYINSELREG       : integer                      := 1              ;
            CREG                : integer                      := 1              ;
            DREG                : integer                      := 1              ;
            INMODEREG           : integer                      := 1              ;
            IS_ALUMODE_INVERTED : std_logic_vector(3 downto 0) := "0000"         ;
            IS_CARRYIN_INVERTED : bit                          := '0'            ;
            IS_CLK_INVERTED     : bit                          := '0'            ;
            IS_INMODE_INVERTED  : std_logic_vector(4 downto 0) := "00000"        ;
            IS_OPMODE_INVERTED  : std_logic_vector(6 downto 0) := "0000000"      ;
            MASK                : bit_vector                   := X"3FFFFFFFFFFF";
            MREG                : integer                      := 1              ;
            OPMODEREG           : integer                      := 1              ;
            PATTERN             : bit_vector                   := X"000000000000";
            PREG                : integer                      := 1              ;
            SEL_MASK            : string                       := "MASK"         ;
            SEL_PATTERN         : string                       := "PATTERN"      ;
            USE_DPORT           : boolean                      := FALSE          ;
            USE_MULT            : string                       := "MULTIPLY"     ;
            USE_PATTERN_DETECT  : string                       := "NO_PATDET"    ;
            USE_SIMD            : string                       := "ONE48"         
        );
        port (
            ACOUT          : out std_logic_vector(29 downto 0);
            BCOUT          : out std_logic_vector(17 downto 0);
            CARRYCASCOUT   : out std_ulogic                   ;
            CARRYOUT       : out std_logic_vector(3 downto 0) ;
            MULTSIGNOUT    : out std_ulogic                   ;
            OVERFLOW       : out std_ulogic                   ;
            P              : out std_logic_vector(47 downto 0);
            PATTERNBDETECT : out std_ulogic                   ;
            PATTERNDETECT  : out std_ulogic                   ;
            PCOUT          : out std_logic_vector(47 downto 0);
            UNDERFLOW      : out std_ulogic                   ;
            A              : in  std_logic_vector(29 downto 0);
            ACIN           : in  std_logic_vector(29 downto 0);
            ALUMODE        : in  std_logic_vector(3 downto 0) ;
            B              : in  std_logic_vector(17 downto 0);
            BCIN           : in  std_logic_vector(17 downto 0);
            C              : in  std_logic_vector(47 downto 0);
            CARRYCASCIN    : in  std_ulogic                   ;
            CARRYIN        : in  std_ulogic                   ;
            CARRYINSEL     : in  std_logic_vector(2 downto 0) ;
            CEA1           : in  std_ulogic                   ;
            CEA2           : in  std_ulogic                   ;
            CEAD           : in  std_ulogic                   ;
            CEALUMODE      : in  std_ulogic                   ;
            CEB1           : in  std_ulogic                   ;
            CEB2           : in  std_ulogic                   ;
            CEC            : in  std_ulogic                   ;
            CECARRYIN      : in  std_ulogic                   ;
            CECTRL         : in  std_ulogic                   ;
            CED            : in  std_ulogic                   ;
            CEINMODE       : in  std_ulogic                   ;
            CEM            : in  std_ulogic                   ;
            CEP            : in  std_ulogic                   ;
            CLK            : in  std_ulogic                   ;
            D              : in  std_logic_vector(24 downto 0);
            INMODE         : in  std_logic_vector(4 downto 0) ;
            MULTSIGNIN     : in  std_ulogic                   ;
            OPMODE         : in  std_logic_vector(6 downto 0) ;
            PCIN           : in  std_logic_vector(47 downto 0);
            RSTA           : in  std_ulogic                   ;
            RSTALLCARRYIN  : in  std_ulogic                   ;
            RSTALUMODE     : in  std_ulogic                   ;
            RSTB           : in  std_ulogic                   ;
            RSTC           : in  std_ulogic                   ;
            RSTCTRL        : in  std_ulogic                   ;
            RSTD           : in  std_ulogic                   ;
            RSTINMODE      : in  std_ulogic                   ;
            RSTM           : in  std_ulogic                   ;
            RSTP           : in  std_ulogic                    
        );
    end component;
end vcomponents;
