create_clock -period 5.000 -name CLK -waveform {0.000 2.500} -add CLK

set_operating_conditions -ambient_temp 30.0
set_switching_activity -deassert_resets 
