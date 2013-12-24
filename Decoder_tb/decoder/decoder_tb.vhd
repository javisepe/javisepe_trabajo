LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoder_decoder_tb_vhd_tb IS
END decoder_decoder_tb_vhd_tb;

ARCHITECTURE behavior OF decoder_decoder_tb_vhd_tb IS 

	COMPONENT decoder
	PORT(
		code : IN  std_logic_vector(3 downto 0);
		led  : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	SIGNAL code : std_logic_vector(3 downto 0);
	SIGNAL led  : std_logic_vector(6 downto 0);

	TYPE vtest is record
		 code : std_logic_vector(3 downto 0);
		 led  : std_logic_vector(6 downto 0);
	END RECORD;

	type vtest_vector is array (natural range <>) of vtest;

	constant test: vtest_vector := (
		(code => "0000", led => "0000001"),
		(code => "0001", led => "1001111"),
		(code => "0010", led => "0010010"),
		(code => "0011", led => "0000110"),
		(code => "0100", led => "1001100"),
		(code => "0101", led => "0100100"),
		(code => "0110", led => "0100000"),
		(code => "0111", led => "0001111"),
		(code => "1000", led => "0000000"),
		(code => "1001", led => "0000100"),
		(code => "1010", led => "1111110"),
		(code => "1011", led => "1111110"),
		(code => "1100", led => "1111110"),
		(code => "1101", led => "1111110"),
		(code => "1110", led => "1111110"),
		(code => "1111", led => "1111110")
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

