With Ada.Real_Time; use Ada.Real_Time;
With MicroBit.Console; use MicroBit.Console;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;  -- using the types defined here
use MicroBit; --for pin names

package body TaskAct is

   task body act is
      myClock : Time;
   begin

      Setup; -- we do Setup once at the start of the task;

      loop
         myClock := Clock;

         setDrive(MotorDriver_custom.GetDirection);

         Put_Line ("Direction is: " & MotorDriver_custom.GetDirection'Image);

         delay until myClock + Milliseconds(50);  --random period, but faster than 20 ms is no use because Set_Analog_Period_Us(20000) !
                                                  --faster is better but note the weakest link: if decisions in the thinking task come at 100ms and acting come at 20ms
                                                  --then no change is set in the acting task for at least 5x (and is wasting power to wake up and execute task!)
      end loop;
   end act;

   procedure Setup is
   begin

      MotorDriver.Servo(1,90);
      delay 1.0; -- equivalent of Time.Sleep(1000) = 1 second

   end Setup;        --heihei

   procedure setDrive (direction : Directions) is
   begin
      case direction is
         when Forward =>
            MotorDriver.Drive(Forward,(4095,4095,4095,4095));
         when Backward =>
            MotorDriver.Drive(Backward,(4095,4095,4095,4095));
         when Left =>
            MotorDriver.Drive(Left,(4095,4095,4095,4095));
         when Right =>
            MotorDriver.Drive(Right,(4095,4095,4095,4095));
         when Forward_Left =>
            MotorDriver.Drive(Forward_Left,(4095,4095,4095,4095));
         when Backward_Left =>
            MotorDriver.Drive(Backward_Left,(4095,4095,4095,4095));
         when Turning =>
            MotorDriver.Drive(Turning,(4095,4095,2000,2000));
         when Lateral_Left =>
            MotorDriver.Drive(Lateral_Left,(4095,4095,4095,4095));
         when Rotating_Left =>
            MotorDriver.Drive(Rotating_Left,(4095,4095,4095,4095));
         when Stop =>
            MotorDriver.Drive(Stop,(0,0,0,0));
      end case;
   end setDrive;

end TaskAct;
