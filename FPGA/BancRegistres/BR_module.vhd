----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:03:04 04/14/2021 
-- Design Name: 
-- Module Name:    BR_module - Behavioral 
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

entity BR_module is
    Port ( addrA : in  STD_LOGIC_VECTOR (3 downto 0);
           addrB : in  STD_LOGIC_VECTOR (3 downto 0);
           addrW : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end BR_module;

architecture Behavioral of BR_module is
	type banc_reg is array(0 to 15) of STD_LOGIC_VECTOR (7 downto 0);
	signal BR : banc_reg;
begin
	
	QA <= BR(conv_integer(addrA)) when addrA /= addrW else
			DATA when addrA = addrW and W = '1';
	QB <= BR(conv_integer(addrB)) when addrB /= addrW else
			DATA when addrB = addrW and W = '1';

	process
	
	begin
		wait until CLK'event and CLK = '1';
		
		if RST = '0' then 
			BR <= (others => X"00");
		else
			if W = '1' then
			BR(conv_integer(addrW)) <= DATA;
			end if;
		end if;
		
		
		
		
	end process;


end Behavioral;
-- WAIT until CK'event and CK = '1';
