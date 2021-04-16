--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:03:04 04/16/2021
-- Design Name:   
-- Module Name:   /home/fleon/Bureau/ProjetSI/FPGA/BancMemoireInstructions/BMI_test.vhd
-- Project Name:  BancMemoireInstructions
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BMI_module
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY BMI_test IS
END BMI_test;
 
ARCHITECTURE behavior OF BMI_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BMI_module
    PORT(
         addr : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal addr : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BMI_module PORT MAP (
          addr => addr,
          CLK => CLK,
          Output => Output
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
	addr <= X"00", X"01" after 50 ns, X"02" after 100 ns, X"21" after 150 ns;

END;
