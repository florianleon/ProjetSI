----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:10 05/04/2021 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline is
    Port ( CLK : in  STD_LOGIC;
			  inA : in  STD_LOGIC_VECTOR (7 downto 0);
           inB : in  STD_LOGIC_VECTOR (7 downto 0);
           inOP : in  STD_LOGIC_VECTOR (7 downto 0);
           inC : in  STD_LOGIC_VECTOR (7 downto 0);
           outA : out  STD_LOGIC_VECTOR (7 downto 0);
           outB : out  STD_LOGIC_VECTOR (7 downto 0);
           outOP : out  STD_LOGIC_VECTOR (7 downto 0);
           outC : out  STD_LOGIC_VECTOR (7 downto 0));
end pipeline;

architecture Behavioral of pipeline is

begin
	process 
	
	begin
		wait until CLK'event and CLK ='1';
		outA <= inA;
		outB <= inB;
		outOP <= inOP;
		outC <= inC;
	end process;

end Behavioral;

