with MicroBit.Console; use MicroBit.Console;
with MicroBit.Extended; use MicroBit.Extended;
with MicroBit.Types; use MicroBit.Types;

with Config; use Config;
with DFR0548;
use MicroBit;
with Profiler;

package body taskAct is

   procedure coreAct is
   begin
      setDrive(motorDriver_Custom.getStatus.direction, motorDriver_Custom.getStatus.speed);
      if debugMode then
         put_Line("Direction is: " & motorDriver_Custom.getStatus.direction'Image);
      end if;
   end coreAct;

   procedure setup is
   begin
      servo(1,90);
      delay 1.0;
   end setup;

   procedure setDrive(direction : directions; speed : speeds := (4095, 4095, 4095, 4095)) is
   begin
      case direction is
         when Forward =>
            drive(Forward, (speed));
         when Backward =>
            drive(Backward, (speed));
         when Left =>
            drive(Left, (speed));
         when Right =>
            drive(Right, (speed));
         when Forward_Left =>
            drive(Forward_Left, (speed));
         when Backward_Left =>
            drive(Backward_Left, (speed));
         when Turning =>
            drive(Turning, (speed));
         when Lateral_Left =>
            drive(Lateral_Left, (speed));
         when Rotating_Left =>
            drive(Rotating_Left, (speed));
         when Stop =>
            drive(Stop, (0, 0, 0, 0));
         when Left_Rotate =>
            drive(Left_Rotate, (speed));
         when Right_Rotate =>
            drive(Right_Rotate, (speed));
      end case;
   end setDrive;

   task body act is
   myClock : Time;
   begin
      setup;
      loop
         myClock := Clock;
         if profilerMode then
            profiler.timer("Act", 100, deadline, coreAct'Access);
         else
            coreAct;
            delay until myClock + deadline;
         end if;
      end loop;
   end act;

end taskAct;
