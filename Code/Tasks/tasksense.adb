with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;
with MicroBit.Types; use MicroBit.Types;
use MicroBit;
with Profiler;
with Config; use Config;

package body TaskSense is

    task body sense is
    begin
        loop
            if debugMode then
                Profiler.Timer("Sense", 10, coreSense'Access);
            else
                coreSense;
            end if;
        end loop;
    end sense;

    procedure coreSense is
        package sensor1 is new Ultrasonic(MB_P16, MB_P0);
        package sensor2 is new Ultrasonic(MB_P15, MB_P1);

        leftDistance : Distance_cm := 0;
        rightDistance : Distance_cm := 0;
        myClock : Time;
    begin
        myClock := Clock;

        leftDistance := sensor1.Read;
        rightDistance := sensor2.Read;

        if debugMode then
            Put_Line("Left Distance: " & Distance_cm'Image(leftDistance));
            Put_Line("Right Distance: " & Distance_cm'Image(rightDistance));
        end if;

        Brain.SetMeasurementSensor1(leftDistance);
        Brain.SetMeasurementSensor2(rightDistance);

        delay until myClock + Milliseconds(200);
    end coreSense;

end TaskSense;
