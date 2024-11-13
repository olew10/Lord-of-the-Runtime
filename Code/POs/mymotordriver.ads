with MicroBit.MotorDriverExtended; use MicroBit.MotorDriverExtended;
with DFR0548;
with MicroBit.Console; use MicroBit.Console;
use MicroBit;

package MyMotorDriver is
   type Status is record
      Direction : Directions;
      Speed     : Speeds;
   end record;

   protected MotorDriver_Custom is
      procedure SetDirection (V : Directions; S : Speeds);
      function GetStatus return Status;

   private
      DriveDirection : Directions;
      DriveSpeed     : Speeds;
   end MotorDriver_Custom;

end MyMotorDriver;
