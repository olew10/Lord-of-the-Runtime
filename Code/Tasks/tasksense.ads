With MyBrain; use MyBrain;
with MicroBit.Types; use MicroBit.Types;
with Priorities;

package TaskSense is

   task Sense with Priority =>Priorities.Sense;
   type Distance_Buffer is array (1 .. 5) of Distance_cm;
   function Average_Buffer(Buffer : Distance_Buffer) return Distance_cm;
   procedure coreSense;

end TaskSense;
