--0 to 999 counter on FPGA by Ninad Waingankar
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter999 is
port(clk:in std_logic;
		rst:in std_logic;
	dig1,dig2,dig3:out std_logic_vector(6 downto 0));
end counter999;

architecture behav of counter999 is
	signal divider:std_logic_vector(23 downto 0);	--clock divider signal
begin
	process(clk,rst) 
	begin
		if(rst='1') then
			divider<=(others=>'0');
		elsif(rising_edge(clk)) then
			divider<=divider+'1';
		end if;
	end process;

	process(divider(23),rst)
		variable count1:natural range 0 to 10:=0;
		variable count2:natural range 0 to 10:=0;
		variable count3:natural range 0 to 10:=0;
		
	begin
		if(rst='1') then
			count1:=0;
			count2:=0;
			count3:=0;
		elsif(rising_edge(divider(23))) then
			count1:=count1+1;
			if(count1=10) then
				count1:=0;
				count2:=count2+1;
				if(count2=10) then
					count2:=0;
					count3:=count3+1;
					if(count3=10) then
						count1:=0;
						count2:=0;
						count3:=0;
					end if;
				end if;				
			end if;
		end if;
		
	--codes for Common anode 7 segment display	abcdefg format
	
	--for digit 1
		case count1 is 
			when 0=>dig1<="0000001";-- shows 0
			when 1=>dig1<="1001111";-- shows 1
			when 2=>dig1<="0010010";-- shows 2
			when 3=>dig1<="0000110";-- shows 3
			when 4=>dig1<="1001100";-- shows 4
			when 5=>dig1<="0100100";-- shows 5
			when 6=>dig1<="0100000";-- shows 6
			when 7=>dig1<="0001111";-- shows 7
			when 8=>dig1<="0000000";-- shows 8 
			when 9=>dig1<="0000100";-- shows 9
			when others=>null;
		end case;
		
		--for digit 2
		case count2 is 
			when 0=>dig2<="0000001";--
			when 1=>dig2<="1001111";--
			when 2=>dig2<="0010010";--
			when 3=>dig2<="0000110";--
			when 4=>dig2<="1001100";--
			when 5=>dig2<="0100100";--
			when 6=>dig2<="0100000";--
			when 7=>dig2<="0001111";--
			when 8=>dig2<="0000000";--
			when 9=>dig2<="0000100";
			when others=>null;
		end case;
		
		--for digit 3
		case count3 is 
			when 0=>dig3<="0000001";--
			when 1=>dig3<="1001111";--
			when 2=>dig3<="0010010";--
			when 3=>dig3<="0000110";--
			when 4=>dig3<="1001100";--
			when 5=>dig3<="0100100";--
			when 6=>dig3<="0100000";--
			when 7=>dig3<="0001111";--
			when 8=>dig3<="0000000";--
			when 9=>dig3<="0000100";--
			when others=>null;
		end case;
		
	end process;	
end behav;
