--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:36:19 04/16/2021
-- Design Name:   
-- Module Name:   /home/fleon/Bureau/ProjetSI/FPGA/BancMemoireData/BMD_test.vhd
-- Project Name:  BancMemoireData
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BMD_module
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
 
ENTITY BMD_test IS
END BMD_test;
 
ARCHITECTURE behavior OF BMD_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BMD_module
    PORT(
         addr : IN  std_logic_vector(7 downto 0);
         entree : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         Sortie : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal addr : std_logic_vector(7 downto 0) := (others => '0');
   signal entree : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Sortie : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BMD_module PORT MAP (
          addr => addr,
          entree => entree,
          RW => RW,
          RST => RST,
          CLK => CLK,
          Sortie => Sortie
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
	RST <= '0', '1' after 50 ns, '0' after 300 ns;
	addr <= X"01", X"02" after 200 ns;
	entree <= X"D8", X"23" after 200 ns;
	RW <= '0', '1' after 150 ns;

END;
