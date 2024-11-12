with MyBrain;           use MyBrain;
with MicroBit.Types;    use MicroBit.Types;
with Ada.Real_Time;     use Ada.Real_Time;
with Priorities;

package TaskSense is

   task sense
      with Priority => Priorities.sense;

   deadline : constant Time_Span := Priorities.senseDeadline;

   type distanceBuffer is array (1 .. 5) of Distance_cm;

   function averageBuffer (buffer : distanceBuffer) return Distance_cm;

   procedure coreSense;

   procedure updateBuffer (
      sensorBuffer : in out distanceBuffer;
      index        : in out Integer;
      newDistance  : in Distance_cm
   );

end TaskSense;
