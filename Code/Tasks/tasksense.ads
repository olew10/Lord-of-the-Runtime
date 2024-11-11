with MyBrain; use MyBrain;
with MicroBit.Types; use MicroBit.Types;
with Ada.Real_Time; use Ada.Real_Time;
with Priorities;

package TaskSense is

   task Sense with Priority => Priorities.Sense;

   deadline : constant Time_Span := Milliseconds(65);

   type Distance_Buffer is array (1 .. 10) of Distance_cm;
   function AverageBuffer(Buffer : Distance_Buffer) return Distance_cm;
   procedure CoreSense;
   procedure UpdateBuffer(SensorBuffer : in out Distance_Buffer;
                          Index : in out Integer;
                          NewDistance : in Distance_cm);

end TaskSense;
