with Ada.Execution_Time; use Ada.Execution_Time;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Extended; use MicroBit.Extended;
with MicroBit.Console; use MicroBit.Console;
with HAL;
with Profiler;
with Config; use Config;

with MyMotorDriver; use MyMotorDriver;
with MyBrain; use MyBrain;
with Priorities;


package TaskThink is

   task Think with Priority=> Priorities.Think;

   procedure coreThink;
   procedure UpdateMotorDirection(turningDirection : Directions; motorSpeed : HAL.UInt12);
   function whichSensor(Left_Sensor, Right_Sensor, Min_Distance : Distance_cm) return Directions;
   function CalculateMotorSpeed(closest_distance : Distance_cm) return HAL.UInt12;
   procedure ReadSensorValues(leftDistance : out Distance_cm; rightDistance : out Distance_cm);

end TaskThink;
