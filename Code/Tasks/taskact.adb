with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Extended; use MicroBit.Extended;
with MicroBit.Types; use MicroBit.Types;
with Config; use Config;
with DFR0548;
use MicroBit;
with Profiler;

package body TaskAct is

      task body act is
   begin
      Setup;
      loop
      if debugMode then
        Profiler.Timer("Act",10, coreAct'Access);
      else
        coreAct;
      end if;
      end loop;
   end act;

   procedure coreAct is
      myClock : Ada.Real_Time.Time;
   begin
      myClock := Ada.Real_Time.Clock;
      setDrive(MotorDriver_custom.GetStatus.Direction,MotorDriver_Custom.GetStatus.Speed);

      if debugMode then
      Put_Line ("Direction is: " & MotorDriver_custom.GetStatus.Direction'Image);
      end if;

      delay until myClock + Ada.Real_Time.Milliseconds(50);
   end coreAct;

   procedure Setup is
   begin
      Extended.Servo(1, 90);
      delay 1.0;
   end Setup;

   procedure setDrive(direction : Directions;  speed : Speeds := (4095,4095,4095,4095)) is
   begin
      case direction is
         when Forward =>
            Extended.Drive(Forward, (speed));
         when Backward =>
            Extended.Drive(Backward, (speed));
         when Left =>
            Extended.Drive(Left, (speed));
         when Right =>
            Extended.Drive(Right, (speed));
         when Forward_Left =>
            Extended.Drive(Forward, (speed));
         when Backward_Left =>
            Extended.Drive(Backward_Left, (speed));
         when Turning =>
            Extended.Drive(Turning, (speed));
         when Lateral_Left =>
            Extended.Drive(Lateral_Left, (speed));
         when Rotating_Left =>
            Extended.Drive(Rotating_Left, (speed));
         when Stop =>
            Extended.Drive(Stop, (0, 0, 0, 0));
         when Left_Rotate  =>
            Extended.Drive(Left_Rotate, (speed));
         when Right_Rotate  =>
            Extended.Drive(Right_Rotate, (speed));
      end case;
   end setDrive;

end TaskAct;
