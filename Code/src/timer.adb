with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with MicroBit.Ultrasonic;
use MicroBit;

procedure Measure_WCET is

   type Duration_Array is array (1 .. 100) of Duration; -- Array to store execution times for multiple runs

   function Find_Max_Time(Times : Duration_Array) return Duration is
      Max_Time : Duration := Times(1);
   begin
      for I in Times'Range loop
         if Times(I) > Max_Time then
            Max_Time := Times(I);
         end if;
      end loop;
      return Max_Time;
   end Find_Max_Time;

   -- WCET Measurement Functions

   function Measure_TaskSense return Duration is
      Start_Time, End_Time : Time;
      Elapsed_Time : Duration_Array := (others => 0.0);
      package Sensor1 is new MicroBit.Ultrasonic(MB_P16, MB_P0);
      package Sensor2 is new MicroBit.Ultrasonic(MB_P15, MB_P1);
      Distance1, Distance2 : Distance_cm := 0;
   begin
      for I in Elapsed_Time'Range loop
         Start_Time := Clock;
         Distance1 := Sensor1.Read;
         Distance2 := Sensor2.Read;
         Brain.SetMeasurementSensor1(Distance1);
         Brain.SetMeasurementSensor2(Distance2);
         End_Time := Clock;
         Elapsed_Time(I) := Time_Span(End_Time - Start_Time);
      end loop;
      return Find_Max_Time(Elapsed_Time);
   end Measure_TaskSense;

   function Measure_TaskThink return Duration is
      Start_Time, End_Time : Time;
      Elapsed_Time : Duration_Array := (others => 0.0);
      MinDist : constant Distance_cm := 10;
      MidDist : constant Distance_cm := 20;
   begin
      for I in Elapsed_Time'Range loop
         Start_Time := Clock;
         if Brain.GetMeasurementSensor1 < MinDist or Brain.GetMeasurementSensor2 < MinDist then
            MotorDriver_custom.SetDirection(Backward);
         elsif Brain.GetMeasurementSensor1 > MidDist and Brain.GetMeasurementSensor2 > MidDist then
            MotorDriver_custom.SetDirection(Forward);
         elsif Brain.GetMeasurementSensor1 < MidDist then
            MotorDriver_custom.SetDirection(Forward);
         elsif Brain.GetMeasurementSensor2 > MidDist then
            MotorDriver_custom.SetDirection(Forward);
         end if;
         End_Time := Clock;
         Elapsed_Time(I) := Time_Span(End_Time - Start_Time);
      end loop;
      return Find_Max_Time(Elapsed_Time);
   end Measure_TaskThink;

   function Measure_TaskAct return Duration is
      Start_Time, End_Time : Time;
      Elapsed_Time : Duration_Array := (others => 0.0);
   begin
      for I in Elapsed_Time'Range loop
         Start_Time := Clock;
         declare
            Direction : Directions := MotorDriver_custom.GetDirection;
         begin
            setDrive(Direction);
            Put_Line("Direction is: " & Direction'Image);
         end;
         End_Time := Clock;
         Elapsed_Time(I) := Time_Span(End_Time - Start_Time);
      end loop;
      return Find_Max_Time(Elapsed_Time);
   end Measure_TaskAct;

begin
   -- Run each WCET measurement function and print the results
   declare
      WCET_Sense : Duration := Measure_TaskSense;
      WCET_Think : Duration := Measure_TaskThink;
      WCET_Act   : Duration := Measure_TaskAct;
   begin
      Put_Line("WCET for TaskSense: " & Duration'Image(WCET_Sense));
      Put_Line("WCET for TaskThink: " & Duration'Image(WCET_Think));
      Put_Line("WCET for TaskAct: " & Duration'Image(WCET_Act));
   end;
end Measure_WCET;
