----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:40 04/16/2021 
-- Design Name: 
-- Module Name:    BMD_module - Behavioral 
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

entity BMD_module is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           entree : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Sortie : out  STD_LOGIC_VECTOR (7 downto 0));
end BMD_module;

architecture Behavioral of BMD_module is

	type bmd_reg is array(0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
	signal BMD : bmd_reg;

begin

	process
	
	begin
		wait until CLK'event and CLK = '0';
		
		if RST = '0' then 
			BMD <= (others => X"00");
		else
			if RW = '1' then
				--lecture
				Sortie <= BMD(conv_integer(addr));
			elsif RW = '0' then
				-- ecriture
				BMD(conv_integer(addr)) <= entree;
			end if;
		end if;

	end process;

end Behavioral;

