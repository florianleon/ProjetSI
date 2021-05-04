--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:54:02 05/04/2021
-- Design Name:   
-- Module Name:   /home/fleon/Bureau/ProjetSI/FPGA/Processeur/processeur_test.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: processeur
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
 
ENTITY processeur_test IS
END processeur_test;
 
ARCHITECTURE behavior OF processeur_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT processeur
    PORT(
         CLKP : IN  std_logic;
         RSTP : IN  std_logic;
         Aout : OUT  std_logic_vector(7 downto 0);
         Bout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLKP : std_logic := '0';
   signal RSTP : std_logic := '0';

 	--Outputs
   signal Aout : std_logic_vector(7 downto 0);
   signal Bout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLKP_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: processeur PORT MAP (
          CLKP => CLKP,
          RSTP => RSTP,
          Aout => Aout,
          Bout => Bout
        );

   -- Clock process definitions
   CLKP_process :process
   begin
		CLKP <= '0';
		wait for CLKP_period/2;
		CLKP <= '1';
		wait for CLKP_period/2;
   end process;
 
	RSTP <= '0', '1' after 100 ns;


END;
