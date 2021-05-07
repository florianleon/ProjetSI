----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:04:04 04/14/2021 
-- Design Name: 
-- Module Name:    ALU_Module - Behavioral 
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

entity ALU_Module is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0); --Opérations
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC; -- valeur négative ==> S < 0
           O : out  STD_LOGIC; -- overflow len(A OP B) > 8 bits
           Z : out  STD_LOGIC; -- S = 0
           C : out  STD_LOGIC); -- si retenue ou pas (carry)
end ALU_Module;

architecture Behavioral of ALU_Module is
	-- Ctrl_Alu : 
	-- 001 --> +
	-- 010 --> *
	-- 011 --> -
	-- 100 --> / --> ne pas faire
	signal Aext: STD_LOGIC_VECTOR (15 downto 0);
	signal Bext: STD_LOGIC_VECTOR (15 downto 0);
	signal Result: STD_LOGIC_VECTOR (15 downto 0);
begin
	Aext <= X"00" & A ;
	Bext <= X"00" & B ;
	S <= Result(7 downto 0);
	
	process (Aext, Bext, Ctrl_Alu)
		
	begin
		Z <= '0';
		N <= '0';
		O <= '0';
		C <= '0';
		
		-- ADD
		if Ctrl_Alu = "001" then 
			--carry
			if Aext + Bext > X"FF" then 
				C <= '1';
			else
				C <= '0';
			end if;
			-- 0
			if Aext + Bext = X"0000" then 
				Z <= '1';
			else
				Z <= '0';
			end if;
			Result <= Aext + Bext;
			
		-- SUB
		elsif Ctrl_Alu = "011" then 
			Result <= Aext - Bext;
			-- 0
			if Aext = Bext then 
				Z <= '1';
			else
				Z <= '0';
			end if;
			-- <0
			if Aext < Bext then 
				N <= '1';
			else
				N <= '0';
			end if;
		
		-- MUL
		elsif Ctrl_Alu = "010" then 
			--overflow
			if Aext(7 downto 0) * Bext(7 downto 0) > X"FF" then 
				O <= '1';
			else
				O <= '0';
			end if;
			-- 0
			if Aext = X"0000" or Bext = X"0000" then 
				Z <= '1';
			else
				Z <= '0';
			end if;
			Result <= Aext(7 downto 0) * Bext(7 downto 0);
		end if;
	
	end process;

end Behavioral;

