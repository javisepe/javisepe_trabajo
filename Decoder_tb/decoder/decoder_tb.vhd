LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoder_tb IS
END decoder_tb;

ARCHITECTURE behavior OF decoder_tb IS 

	COMPONENT decoder
	PORT(
		code : IN  std_logic_vector(2 downto 0);
		led  : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	SIGNAL code : std_logic_vector(2 downto 0);
	SIGNAL led  : std_logic_vector(6 downto 0);

	TYPE vtest is record
		 code : std_logic_vector(2 downto 0);
		 led  : std_logic_vector(6 downto 0);
	END RECORD;

	type vtest_vector is array (natural range <>) of vtest;

	constant test: vtest_vector := (
		(code => "000", led => "0000001"),
		(code => "001", led => "1001111"),
		(code => "010", led => "0010010"),
		(code => "011", led => "0000110"),
		(code => "100", led => "1001100"),
		(code => "101", led => "0100100"),
		(code => "110", led => "0100000"),
		(code => "111", led => "0001111")
		
	);

BEGIN

	uut: decoder PORT MAP(
		code => code,
		led  => led
	);

-- *** Test Bench - User Defined Section ***
	tb: PROCESS

	begin

		for i in 0 to test'high loop
			code <= test(i).code;
			wait for 20 ns; 
			assert led = test(i).led
				report "Salida incorrecta."
				severity failure;
		end loop;

		assert false
			report "Simulación finalizada. Test superado."
			severity failure;

	end process;
-- *** End Test Bench - User Defined Section ***

END;

