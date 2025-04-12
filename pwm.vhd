library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is
    generic (
        pwm_bits : integer := 8 ;
        clk_cnt_len : positive := 1
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        duty_cycle : in unsigned(pwm_bits - 1 downto 0);
        pwm_out : out std_logic
    );
end pwm;

architecture behavioral of pwm is
    -- internal signals
    signal Timer_cnt : unsigned(pwm_bits - 1 downto 0);
    signal counter_value : unsigned(pwm_bits - 1 downto 0);
    signal Timer_done : std_logic;
    signal up_counter_enable : std_logic;
    signal comp_out : std_logic;

    -- Final value for timer to determine frequency
    constant Final_val : unsigned(pwm_bits - 1 downto 0) := to_unsigned(clk_cnt_len - 1, pwm_bits);

begin
    -- Timer process
    process(clk, rst)
    begin
        if rst = '1' then
            Timer_cnt <= (others => '0');
            Timer_done <= '0';
        elsif rising_edge(clk) then
            if Timer_cnt = Final_val then
                Timer_cnt <= (others => '0');
                Timer_done <= '1';
            else
                Timer_cnt <= Timer_cnt + 1;
                Timer_done <= '0';
            end if;
        end if;
    end process;

    -- Counter process
    process (clk, rst, Timer_done)
    begin
        if rst = '1' then
            counter_value <= (others => '0');
        elsif rising_edge(clk) then
            if Timer_done = '1' then
                counter_value <= counter_value + 1;
            end if;
        end if;
    end process;

    -- Comparator
    comp_out <= '1' when counter_value < duty_cycle else '0';

    -- D Flip-Flop for output synchronization
    process(clk, rst)
    begin
        if rst = '1' then
            pwm_out <= '0';
        elsif rising_edge(clk) then
            pwm_out <= comp_out;
        end if;
    end process;
end behavioral;