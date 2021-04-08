--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:16:22 04/07/2021
-- Design Name:   
-- Module Name:   /home/fleon/Bureau/ProjetSI/TD/cpt8/test_cpt8.vhd
-- Project Name:  cpt8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: moduleCPT8
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
 
ENTITY test_cpt8 IS
END test_cpt8;
 
ARCHITECTURE behavior OF test_cpt8 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT moduleCPT8
    PORT(
         CK : IN  std_logic;
         RST : IN  std_logic;
         SENS : IN  std_logic;
         LOAD : IN  std_logic;
         EN : IN  std_logic;
         Din : IN  std_logic_vector(7 downto 0);
         Dout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CK : std_logic := '0';
   signal RST : std_logic := '0';
   signal SENS : std_logic := '0';
   signal LOAD : std_logic := '0';
   signal EN : std_logic := '0';
   signal Din : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant CK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: moduleCPT8 PORT MAP (
          CK => CK,
          RST => RST,
          SENS => SENS,
          LOAD => LOAD,
          EN => EN,
          Din => Din,
          Dout => Dout
        );

   -- Clock process definitions
   CK_process :process
   begin
		CK <= '0';
		wait for CK_period/2;
		CK <= '1';
		wait for CK_period/2;
   end process;
	
	RST <= '1', '0' after 100ns, '1' after 110ns;
	SENS <= '1', '0' after 50ns, '1' after 150ns;
	LOAD <= '1', '0' after 75ns, '1' after 100ns, '0' after 120ns;
	EN <= '0', '1' after 25ns, '0' after 50ns, '1' after 75ns, '0' after 100ns;
	Din <= X"12", X"02" after 40ns;

END;
