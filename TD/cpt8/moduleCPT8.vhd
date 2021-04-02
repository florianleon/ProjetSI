----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:16:00 04/02/2021 
-- Design Name: 
-- Module Name:    moduleCPT8 - Behavioral 
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

entity moduleCPT8 is
    Port ( CK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SENS : in  STD_LOGIC;
           LOAD : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (7 downto 0);
           Dout : out  STD_LOGIC_VECTOR (7 downto 0));
end moduleCPT8;

architecture Behavioral of moduleCPT8 is
	signal N: STD_LOGIC_VECTOR (7 downto 0);
begin
	Dout <= N;
	process
	begin
		WAIT until CK'event and CK = '1';
		if RST = '0' then
			N <= "00000000";
		else
			if LOAD = '1' then
				N <= Din;
			elsif EN = '0' then
				if SENS = '1' then
					N <= N + 1;
				elsif SENS = '0' then 
					N <= N - 1;
				end if;
			end if;
		end if;
	
	end process;

end Behavioral;



entity test_cpt8 is
end test_cpt8;

architecture bench of test_cpt8 is
	COMPONENT moduleCPT8 is
		Port ( CK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SENS : in  STD_LOGIC;
           LOAD : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (7 downto 0);
           Dout : out  STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT;
		
	For all : moduleCPT8 use entity work.adder(bebehavioral);
		
	SIGNAL CK, SENS, RST, LOAD, EN : STD_LOGIC;
	SIGNAL Din, Dout : STD_LOGIC_VECTOR (7 downto 0);
		
	BEGIN
	END bench;
