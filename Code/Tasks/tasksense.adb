with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.UltrasonicExtended;
with Exceptions;
with ExceptionHandler; use ExceptionHandler;
with MicroBit.Types; use MicroBit.Types;
use MicroBit;
with Profiler;
with Config; use Config;


package body TaskSense is

    leftSensorBuffer : distanceBuffer := (others => 0);
    rightSensorBuffer : distanceBuffer := (others => 0);
    leftIndex : Integer := 1;
    rightIndex : Integer := 1;

    task body sense is
   myClock : Time;
    begin
        loop
        myClock := Clock;
            if profilerMode then
                Profiler.Timer("Sense", 100, deadline, coreSense'Access);
            else
                coreSense;
                 delay until myClock + deadline;
            end if;
        end loop;
    end sense;

    function averageBuffer(Buffer : distanceBuffer) return Distance_cm is
        Sum : Natural := 0;
    begin
        for I in Buffer'Range loop
            Sum := Sum + Natural(Buffer(I));
        end loop;
        return Distance_cm(Sum / Natural(Buffer'Length));
    end averageBuffer;

    procedure updateBuffer(SensorBuffer : in out distanceBuffer;
                           Index : in out Integer;
                           NewDistance : in Distance_cm) is
    begin
        SensorBuffer(Index) := NewDistance;
        Index := Index + 1;
        if Index > distanceBuffer'Last then
            Index := distanceBuffer'First;
        end if;
    end UpdateBuffer;

    procedure coreSense is
        package leftSensorPackage is new UltrasonicExtended(MB_P16, MB_P0);
        package rightSensorPackage is new UltrasonicExtended(MB_P15, MB_P1);

        leftDistance : Distance_cm := 0;
        rightDistance : Distance_cm := 0;
    begin
        leftDistance := leftSensorPackage.Read;
        rightDistance := rightSensorPackage.Read;

        Handler.setErrorState(False);

        updateBuffer(leftSensorBuffer, leftIndex, leftDistance);
        updateBuffer(rightSensorBuffer, rightIndex, rightDistance);

        if debugMode then
            Put_Line("Raw Left Distance: " & Distance_cm'Image(leftSensorPackage.Read));
            Put_Line("Smoothed Left Distance: " & Distance_cm'Image(leftDistance));
            Put_Line("Raw Right Distance: " & Distance_cm'Image(rightSensorPackage.Read));
            Put_Line("Smoothed Right Distance: " & Distance_cm'Image(rightDistance));
        end if;

        Brain.leftSetMeasurementSensor(averageBuffer(leftSensorBuffer));
        Brain.rightSetMeasurementSensor(averageBuffer(rightSensorBuffer));
    exception
      when Exceptions.SensorError =>
        Handler.setErrorState(True);
    end coreSense;
end TaskSense;
