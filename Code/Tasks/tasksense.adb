with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;
with MicroBit.Types; use MicroBit.Types;
use MicroBit;
with Profiler;
with Config; use Config;


package body TaskSense is

    leftSensorBuffer : Distance_Buffer := (others => 0);
    rightSensorBuffer : Distance_Buffer := (others => 0);
    leftIndex : Integer := 1;
    rightIndex : Integer := 1;

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

      function Average_Buffer(Buffer : Distance_Buffer) return Distance_cm is
         Sum : Natural := 0;
      begin
         for I in Buffer'Range loop
               Sum := Sum + Natural(Buffer(I));
         end loop;
         return Distance_cm(Sum / Natural(Buffer'Length));
      end Average_Buffer;

    procedure coreSense is
        package leftSensorPackage is new Ultrasonic(MB_P16, MB_P0);
        package rightSensorPackage is new Ultrasonic(MB_P15, MB_P1);

        leftDistance : Distance_cm := 0;
        rightDistance : Distance_cm := 0;
        myClock : Time;

    begin
        myClock := Clock;

        leftDistance := leftSensorPackage.Read;
        rightDistance := rightSensorPackage.Read;

        leftSensorBuffer(leftIndex) := leftDistance;
        leftIndex := leftIndex + 1;
        if leftIndex > 5 then
            leftIndex := 1;
        end if;


        rightSensorBuffer(rightIndex) := rightDistance;
        rightIndex := rightIndex + 1;
        if rightIndex > 5 then
            rightIndex := 1;
        end if;

        leftDistance := Average_Buffer(leftSensorBuffer);
        rightDistance := Average_Buffer(rightSensorBuffer);

        if debugMode then
            Put_Line("Smoothed Left Distance: " & Distance_cm'Image(leftDistance));
            Put_Line("Smoothed Right Distance: " & Distance_cm'Image(rightDistance));
        end if;

        Brain.leftSetMeasurementSensor(leftDistance);
        Brain.rightSetMeasurementSensor(rightDistance);

        delay until myClock + Milliseconds(60);
    end coreSense;

end TaskSense;
