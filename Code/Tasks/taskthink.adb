with Ada.Real_Time; use Ada.Real_Time;
with HAL;
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
   distance1, distance2 : Distance_cm;
   speedFactor : Float;
   motorSpeed : HAL.UInt12;
begin
   myClock := Clock;

   distance1 := Brain.GetMeasurementSensor1;
   distance2 := Brain.GetMeasurementSensor2;

   canDrive := checkDistance(distance1, distance2);

   if canDrive then
      speedFactor := 1.0 - (float(distance1) + float(distance2)) / 400.0;
      if speedFactor < 0.1 then
         speedFactor := 0.1;
      elsif speedFactor > 1.0 then
         speedFactor := 1.0;
      end if;

      motorSpeed := HAl.UInt12(float(4095) * speedFactor);

      MotorDriver_Custom.SetDirection (Forward, (motorSpeed, motorSpeed, motorSpeed, motorSpeed));
   else
      MotorDriver_Custom.SetDirection (Spin, (4095, 4095, 4095, 4095)); -- Cast to UInt12
   end if;

   delay until myClock + Milliseconds(100);
end coreThink;




end TaskThink;
