LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ball IS
	PORT (
		v_sync    : IN STD_LOGIC;
		pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		clk_in    : IN STD_LOGIC;
		btnr      : IN STD_LOGIC;
    btnl      : IN STD_LOGIC;
		red       : OUT STD_LOGIC;
		green     : OUT STD_LOGIC;
		blue      : OUT STD_LOGIC
	);
END ball;

ARCHITECTURE Behavioral OF ball IS
	CONSTANT size  : INTEGER := 8;
	SIGNAL ball_on : STD_LOGIC; -- indicates whether ball is over current pixel position
	-- current ball position - intitialized to center of screen
	SIGNAL ball_x  : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(400, 11);
	SIGNAL ball_y  : STD_LOGIC_VECTOR(10 DOWNTO 0);
	-- current ball motion - initialized to +4 pixels/frame
	SIGNAL ball_y_motion : STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000100";
	SIGNAL count : STD_LOGIC_VECTOR (20 DOWNTO 0); --set the speed of the moving ball  
BEGIN
	red <= '1'; -- color setup for red ball on white background
	green <= NOT ball_on;
	blue  <= NOT ball_on;
	-- process to draw ball current pixel address is covered by ball position
	bdraw : PROCESS (ball_x, ball_y, pixel_row, pixel_col) IS
	BEGIN
		IF (pixel_col >= ball_x - size) AND
		 (pixel_col <= ball_x + size) AND
			 (pixel_row >= ball_y - size) AND
			 (pixel_row <= ball_y + size) THEN
				ball_on <= '1';
		ELSE
			ball_on <= '0';
		END IF;
		END PROCESS;
		-- process to move ball following button inputs 
	   pos : PROCESS (clk_in) is
	   BEGIN
         if rising_edge(clk_in) then
             count <= count + 1;
            IF (btnl = '1' and count = 0 and ball_y > 0) THEN
                 ball_y <= ball_y - 10;
            ELSIF (btnr = '1' and count = 0 and ball_y < 800) THEN
             ball_y <= ball_y + 10;
            END IF;
         end if;
        END PROCESS;
END Behavioral;
