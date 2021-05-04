----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:26:30 05/04/2021 
-- Design Name: 
-- Module Name:    processeur - Behavioral 
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

entity processeur is
    Port ( CLKP : in  STD_LOGIC;
           RSTP : in  STD_LOGIC;
           Aout : out  STD_LOGIC_VECTOR (7 downto 0);
			  Bout : out  STD_LOGIC_VECTOR (7 downto 0));
end processeur;

architecture Behavioral of processeur is
-- déclaration des composants

	component ALU_Module
		 Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
				  B : in  STD_LOGIC_VECTOR (7 downto 0);
				  Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0); --Opérations
				  S : out  STD_LOGIC_VECTOR (7 downto 0);
				  N : out  STD_LOGIC; -- valeur négative ==> S < 0
				  O : out  STD_LOGIC; -- overflow len(A OP B) > 8 bits
				  Z : out  STD_LOGIC; -- S = 0
				  C : out  STD_LOGIC); -- si retenue ou pas (carry)
	end component;
	
	--Banc de mémoire
	component BMD_module
		 Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
				  Input : in  STD_LOGIC_VECTOR (7 downto 0);
				  RW : in  STD_LOGIC;
				  RST : in  STD_LOGIC;
				  CLK : in  STD_LOGIC;
				  Output : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	--Banc d'instruction
	component BMI_module
		 Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
				  CLK : in  STD_LOGIC;
				  Output : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	--Banc de registres
	component BR_module 
		 Port ( addrA : in  STD_LOGIC_VECTOR (3 downto 0);
				  addrB : in  STD_LOGIC_VECTOR (3 downto 0);
				  addrW : in  STD_LOGIC_VECTOR (3 downto 0);
				  W : in  STD_LOGIC;
				  DATA : in  STD_LOGIC_VECTOR (7 downto 0);
				  RST : in  STD_LOGIC;
				  CLK : in  STD_LOGIC;
				  QA : out  STD_LOGIC_VECTOR (7 downto 0);
				  QB : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component pipeline
		 Port ( CLK : in  STD_LOGIC;
				  inA : in  STD_LOGIC_VECTOR (7 downto 0);
				  inB : in  STD_LOGIC_VECTOR (7 downto 0);
				  inOP : in  STD_LOGIC_VECTOR (7 downto 0);
				  inC : in  STD_LOGIC_VECTOR (7 downto 0);
				  outA : out  STD_LOGIC_VECTOR (7 downto 0);
				  outB : out  STD_LOGIC_VECTOR (7 downto 0);
				  outOP : out  STD_LOGIC_VECTOR (7 downto 0);
				  outC : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	
	--Déclaration des signaux 
	
	
	--pipeline
	type Pipe is record
		OP: STD_LOGIC_VECTOR(7 downto 0);
		A: STD_LOGIC_VECTOR(7 downto 0);
		B: STD_LOGIC_VECTOR(7 downto 0);
		C: STD_LOGIC_VECTOR(7 downto 0);
	end record;
	signal LI_DI_DI_EX: Pipe;
	signal DI_EX_EX_MEM: Pipe;
	signal EX_MEM_MEM_RE: Pipe;
	signal MEM_RE_OUT: Pipe;
	
	--MUX
	signal LI_DI_MUX_DI_EX: STD_LOGIC_VECTOR(7 downto 0);
	
	--LC
	signal MEM_RE_LC_OUT: std_logic;
	
	--mémoire d'instruction
	signal addr_instruc: STD_LOGIC_VECTOR(7 downto 0) := X"00";
	signal instruc: STD_LOGIC_VECTOR(31 downto 0);
	
	--Banc de registre
	signal QAR, QBR : STD_LOGIC_VECTOR (7 downto 0);

begin
	Aout <= QAR;
	Bout <= QBR;
	--init

	--memoire d'instruction
	MI : BMI_module PORT MAP (
		addr => addr_instruc,
		CLK => CLKP,
		Output => instruc
	);
	
	--pipelines 
	LI_DI :  pipeline PORT MAP (
			CLK => CLKP,
			inA => instruc(23 downto 16),
			inB => instruc(15 downto 8),
			inC => instruc(7 downto 0),
			inOP => instruc(31 downto 24),
			outOP => LI_DI_DI_EX.OP,
			outA => LI_DI_DI_EX.A,
			outB => LI_DI_DI_EX.B,
			outC => LI_DI_DI_EX.C
	);
	
	DI_EX :  pipeline PORT MAP (
			CLK => CLKP,
			inA => LI_DI_DI_EX.A,
			inB => LI_DI_MUX_DI_EX,
			inC => LI_DI_DI_EX.C, --REG_QB,
			inOP => LI_DI_DI_EX.OP,
			outOP => DI_EX_EX_MEM.OP,
			outA => DI_EX_EX_MEM.A,
			outB => DI_EX_EX_MEM.B,
			outC => DI_EX_EX_MEM.C
	);
	
	EX_Mem :  pipeline PORT MAP (
			CLK => CLKP,
			inA => DI_EX_EX_MEM.A,
			inB => DI_EX_EX_MEM.B, --DI_EX_MUX_EX_MEM,
			inC => DI_EX_EX_MEM.C,  --n'existe pas
			inOP => DI_EX_EX_MEM.OP,
			outOP => EX_MEM_MEM_RE.OP,
			outA => EX_MEM_MEM_RE.A,
			outB => EX_MEM_MEM_RE.B,
			outC => EX_MEM_MEM_RE.C  --n'existe pas
	);
	
	Mem_RE :  pipeline PORT MAP (
			CLK => CLKP,
			inA => EX_MEM_MEM_RE.A,
			inB => EX_MEM_MEM_RE.B, --MemD_OUT_MUX_MEM_RE,
			inC => EX_MEM_MEM_RE.C, --n'existe pas
			inOP => EX_MEM_MEM_RE.OP,
			outOP => MEM_RE_OUT.OP,
			outA => MEM_RE_OUT.A,
			outB => MEM_RE_OUT.B,
			outC => MEM_RE_OUT.C    --n'existe pas
	);
	
	--Banc de registres
	BR : BR_module PORT MAP (
			addrA => LI_DI_DI_EX.B(3 downto 0),
			addrB => LI_DI_DI_EX.C(3 downto 0),			
			addrW => MEM_RE_OUT.A(3 downto 0),
			W => MEM_RE_LC_OUT,
			DATA => MEM_RE_OUT.B,
			RST => RSTP,
			CLK=> CLKP,
			QA => QAR,
			QB => QBR
	);
	
	--MUX
	LI_DI_MUX_DI_EX <= LI_DI_DI_EX.B when LI_DI_DI_EX.OP = x"06" else QAR;
	
	
	--LC
	MEM_RE_LC_OUT  <= '1' when MEM_RE_OUT.OP = x"06" or MEM_RE_OUT.OP = x"05" else '0';

	process
	begin
		WAIT until CLKP'event and CLKP = '1';
		addr_instruc <= addr_instruc + X"01";
	end process;


end Behavioral;

