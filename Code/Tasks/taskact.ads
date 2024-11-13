with MyMotorDriver; use MyMotorDriver;
with MicroBit.MotorDriverExtended; use MicroBit.MotorDriverExtended;
with Ada.Real_Time; use Ada.Real_Time;
with Priorities;

package TaskAct is

   task act
      with Priority => Priorities.act;

   deadline : Time_Span := Priorities.actDeadline;

   procedure setup;

   procedure coreAct;

   procedure setDrive (
      direction : Directions;
      speed     : Speeds := (4095, 4095, 4095, 4095)
   );

end TaskAct;
