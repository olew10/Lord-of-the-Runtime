with MicroBit.I2C;
package body MicroBit.Extended is


   MD  : DFR0548.MotorDriver (MicroBit.I2C.ControllerExt);

   procedure Initialize is
   begin
      if not MicroBit.I2C.InitializedExt then
         MicroBit.I2C.InitializeExt;
      end if;

      MD.Initialize;
      MD.Set_Frequency_Hz (50); --50 Hz
   end Initialize;

   procedure Drive (Direction : Directions;
                    Speed : Speeds := (4095,4095,4095,4095)) is
      --Note: See implementation of wheel to be (Forward, Backward)
      --!! They can never be a non zero value at the same time !! eg. rf => (4000,2000) is illegal
      --rf = right front wheel, rb = right back wheel, etc.
      --for example direction see:
   begin
      case Direction is
         when Forward =>
            Drive_Wheels(rf => (Speed.rf, 0),
                         rb => (Speed.rb, 0),
                         lf => (Speed.lf, 0),
                         lb => (Speed.lb, 0));
         when Backward =>
            Drive_Wheels(rf => (0, Speed.rf),
                         rb => (0, Speed.rb),
                         lf => (0, Speed.lf),
                         lb => (0, Speed.lb));
         when Left =>
            Drive_Wheels(rf => (Speed.rf ,0),
                         rb => (0, Speed.rb),
                         lf => (0, Speed.lf),
                         lb => (Speed.lb, 0));
         when Right =>
            Drive_Wheels(rf => (0, Speed.rf),
                         rb => (Speed.rb, 0),
                         lf => (Speed.lf ,0),
                         lb => (0, Speed.lb));
         when Forward_Left => --forward left diagonal
            Drive_Wheels(rf => (Speed.rf, 0),
                         rb => (0, 0),
                         lf => (0, 0),
                         lb => (Speed.lb, 0));
         when Backward_Left => --backward left diagonal
            Drive_Wheels(rf => (0, Speed.rf),
                         rb => (0, 0),
                         lf => (0, 0),
                         lb => (0, Speed.lb));
         when Turning => --Same as Forward, wheelspeed left < wheelspeed right results in curved left
            Drive_Wheels(rf => (Speed.rf, 0),
                         rb => (Speed.rb, 0),
                         lf => (Speed.lf, 0),
                         lb => (Speed.lb ,0));
         when Lateral_Left =>
            Drive_Wheels(rf => (Speed.rf,0),
                         lb => (0, 0),
                         lf => (0,Speed.lf),
                         rb => (0,0));
         when Rotating_Left =>
            Drive_Wheels(rf => (Speed.rf,0),
                         lb => (Speed.rb, 0),
                         lf => (0,Speed.lf),
                         rb => (0,Speed.lb));
         when Stop =>
            Drive_Wheels(rf => (0, 0),
                         rb => (0, 0),
                         lf => (0, 0),
                         lb => (0, 0));
         when Spin =>
            Drive_Wheels(rf => (Speed.rf, 0),
                         rb => (Speed.rb, 0),
                         lf => (0, Speed.lf),
                         lb => (0, Speed.lb));
      end case;
   end Drive;

   procedure Drive_Wheels(rf : Wheel;
                         rb : Wheel;
                         lf : Wheel;
                         lb : Wheel ) is
   begin
         MD.Set_PWM_Wheels (rf, rb, lf, lb);
   end Drive_Wheels;

   procedure Servo (ServoPin : ServoPins ;
                    Angle : Degrees)
   is
   begin
         MD.Set_Servo(ServoPin, Angle);
   end Servo;

begin
   Initialize;
end MicroBit.Extended;
