with MicroBit.Extended; use MicroBit.Extended;
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
      -- Declare the variables here so they are accessible in the body
      DriveDirection : Directions;
      DriveSpeed     : Speeds;
   end MotorDriver_Custom;

end MyMotorDriver;
