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
      setDrive(MotorDriver_custom.GetDirection);

      if debugMode then
      Put_Line ("Direction is: " & MotorDriver_custom.GetDirection'Image);
      end if;

      delay until myClock + Ada.Real_Time.Milliseconds(50);
   end coreAct;


   procedure Setup is
   begin
      Extended.Servo(1, 90);
      delay 1.0;
   end Setup;

   procedure setDrive(direction : Directions) is
   begin
      case direction is
         when Forward =>
            Extended.Drive(Forward, (4095, 4095, 4095, 4095));
         when Backward =>
            Extended.Drive(Backward, (4095, 4095, 4095, 4095));
         when Left =>
            Extended.Drive(Left, (4095, 4095, 4095, 4095));
         when Right =>
            Extended.Drive(Right, (4095, 4095, 4095, 4095));
         when Forward_Left =>
            Extended.Drive(Forward, (0, 0, 4095, 4095));
         when Backward_Left =>
            Extended.Drive(Backward_Left, (4095, 4095, 4095, 4095));
         when Turning =>
            Extended.Drive(Turning, (4095, 4095, 2000, 2000));
         when Lateral_Left =>
            Extended.Drive(Lateral_Left, (4095, 4095, 4095, 4095));
         when Rotating_Left =>
            Extended.Drive(Rotating_Left, (4095, 4095, 4095, 4095));
         when Stop =>
            Extended.Drive(Stop, (0, 0, 0, 0));
         when Spin =>
            Extended.Drive(Spin, (4095, 4095, 4095, 4095));
      end case;
   end setDrive;

end TaskAct;
