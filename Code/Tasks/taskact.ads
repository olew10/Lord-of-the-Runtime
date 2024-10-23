with mymotordriver; use mymotordriver;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package TaskAct is

   task Act with Priority=> 3;

   procedure Setup;
   procedure setDrive (direction : Directions);
end TaskAct;
