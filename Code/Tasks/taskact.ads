with MyMotorDriver; use MyMotorDriver;
with MicroBit.Extended; use MicroBit.Extended;
with Priorities;

package TaskAct is

   task Act with Priority=> Priorities.Act;

   procedure Setup;
   procedure setDrive (direction : Directions);
end TaskAct;
