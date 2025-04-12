library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM_tb is
end PWM_tb;

architecture behavior of PWM_tb is
    -- Component declaration
    component pwm is
        generic (
            pwm_bits : integer;
            clk_cnt_len : positive := 1
        );
        port (
            clk : in std_logic;
            rst : in std_logic;
            duty_cycle : in unsigned(pwm_bits - 1 downto 0);
            pwm_out : out std_logic
        );
    end component;
    
    -- Constants and signals
    constant pwm_bits : integer := 8;
    constant clk_period : time := 10 ns;
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal duty_cycle : unsigned(pwm_bits - 1 downto 0);
    signal pwm_out : std_logic;
    
begin
    PWM_inst : pwm
        generic map (
            pwm_bits => pwm_bits,
            clk_cnt_len => 10
        )
        port map (
            clk => clk,
            rst => rst,
            duty_cycle => duty_cycle,
            pwm_out => pwm_out
        );
        
    -- Clock generation process
    clk <= not clk after clk_period / 2;
    
    -- Stimulus process
    process
    begin
        -- Reset sequence
        rst <= '1';
        wait for clk_period * 2;
        rst <= '0';
        
        duty_cycle <= to_unsigned(0, pwm_bits); -- 0% duty cycle
        wait for clk_period * 100;
        
        duty_cycle <= to_unsigned(64, pwm_bits); -- (64/256) 25% duty cycle (roughly)
        wait for clk_period * 100;
        
        duty_cycle <= to_unsigned(128, pwm_bits); -- 50% duty cycle
        wait for clk_period * 100;
        
        duty_cycle <= to_unsigned(192, pwm_bits); -- 75% duty cycle (roughly)
        wait for clk_period * 100;
        
        duty_cycle <= to_unsigned(255, pwm_bits); -- 100% duty cycle
        wait for clk_period * 100;
        
        wait; -- Suspend process indefinitely
    end process;
    
end behavior;