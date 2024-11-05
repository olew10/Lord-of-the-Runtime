with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Extended; use MicroBit.Extended;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Console; use MicroBit.Console;
with Profiler;
with Config; use Config;

package body TaskThink is

  function checkDistance (Sensor1, Sensor2 : Distance_cm) return Boolean is
      Min_Dist : constant Distance_cm := 10;
   begin
      if Sensor1 < Min_Dist or else Sensor2 < Min_Dist then
         return True;
      else
         return False;
      end if;
   end checkDistance;

   task body think is
   begin
      loop
       if debugMode then
            Profiler.Timer("Think",10, coreThink'Access);
            else
            coreThink;
         end if;
      end loop;
   end think;

   procedure coreThink is
      myClock : Time;
      canDrive : Boolean;
   begin
      myClock := Clock;
      canDrive := checkDistance(Brain.GetMeasurementSensor1, Brain.GetMeasurementSensor2);

      if canDrive then
         MotorDriver_Custom.SetDirection (Spin);
      else
         MotorDriver_Custom.SetDirection (Forward);
      end if;

      delay until myClock + Milliseconds(100);
   end coreThink;


end TaskThink;
