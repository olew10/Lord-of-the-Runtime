with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;  -- using the types defined here
with MicroBit.Console; use MicroBit.Console; -- for serial port communication
use MicroBit; --for pin names

package MyMotorDriver is

   protected MotorDriver_custom is
      function GetDirection return Directions; -- concurrent read operations are now possible
      procedure SetDirection (V : Directions); -- but concurrent read/write are not!

   private
      DriveDirection : Directions := Stop;
   end MotorDriver_custom;

end MyMotorDriver;
