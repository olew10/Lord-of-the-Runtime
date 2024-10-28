with MyMotorDriver; use MyMotorDriver;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with Priorities;

package TaskAct is

   task Act with Priority=> Priorities.Act;

   procedure Setup;
   procedure setDrive (direction : customDirections);
end TaskAct;
