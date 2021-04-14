----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:08:31 04/14/2021 
-- Design Name: 
-- Module Name:    dma_module - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dma_module is
    Port ( CS : in  STD_LOGIC;
           RS1 : in  STD_LOGIC;
           RS2 : in  STD_LOGIC;
           BG : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RD : out  STD_LOGIC;
           WR : out  STD_LOGIC;
           BR : out  STD_LOGIC;
           DMA_ASK : in  STD_LOGIC;
           DMA_ACK : out  STD_LOGIC;
           LE : out  STD_LOGIC; -- lecture/ecriture;
			  addrBus : out STD_LOGIC_VECTOR(31 downto 0);SSSSS
			  dataBus : inout STD_LOGIC_VECTOR(31 downto 0)); 
end dma_module;

architecture Behavioral of dma_module is
	signal addrReg: STD_LOGIC_VECTOR(15 downto 0);
	signal cptReg: STD_LOGIC_VECTOR(15 downto 0);
	signal ctrlReg: STD_LOGIC_VECTOR(2 downto 0);
begin
	addrBus <= addrReg;
	process 
	wait until CLK'event and CLK = '1';
	if RST = '1' then --kill -9 -1
		if CS = '1' then
			--registre adresse a activer ? 
			if RS1 = '1' and RS2 = '0' then 
				-- registre compteur octets
			elsif RS2 = '1' and RS1 = '0' then 
				-- registre ctrl
		end if;
		
		
		
		
		
		addrReg = addrReg + X"0004";
	else
		addrReg = X"0000";
		cptReg = X"0000";
		ctrlReg = "000";
	end if;
	
	
	
	
	end process;

end Behavioral;

