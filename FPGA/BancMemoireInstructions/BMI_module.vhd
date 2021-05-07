----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:21:19 04/16/2021 
-- Design Name: 
-- Module Name:    BMI_module - Behavioral 
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

entity BMI_module is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end BMI_module;

architecture Behavioral of BMI_module is
	type bmi_reg is array(0 to 255) of STD_LOGIC_VECTOR (31 downto 0);
	constant BMI : bmi_reg := ( X"06000200", X"06010500", X"06020100", X"06080800", X"05030000", X"05040100", X"01050001", X"03060800", others=> X"00000000");
begin
	process
	begin 
		WAIT until CLK'event and CLK = '1';
		Output <= BMI(conv_integer(addr));
	end process;

end Behavioral;

