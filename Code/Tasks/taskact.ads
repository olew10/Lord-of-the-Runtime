with MyMotorDriver; use MyMotorDriver;
with MicroBit.Extended; use MicroBit.Extended;
with Ada.Real_Time; use Ada.Real_Time;
with Priorities;


package TaskAct is

   task Act with Priority=> Priorities.Act;

   deadline : Time_Span := Priorities.actDeadline;

   procedure Setup;
   procedure coreAct;
   procedure setDrive (direction : Directions;  speed : Speeds := (4095,4095,4095,4095));
end TaskAct;
