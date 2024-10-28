with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;  -- using the types defined here
with MicroBit.Console; use MicroBit.Console; -- for serial port communication
use MicroBit; --for pin names

package MyMotorDriver is

   type customDirections is (Forward,
                       Turn_Left,
                       Turn_Right,
                       Backward,
                       Backward_Turn_Left,
                       Backward_Turn_Right,
                       Stop);

   protected MotorDriver_custom is
      function GetDirection return customDirections; -- concurrent read operations are now possible
      procedure SetDirection (V : customDirections); -- but concurrent read/write are not!

   private
      DriveDirection : customDirections := Stop;
   end MotorDriver_custom;

end MyMotorDriver;
