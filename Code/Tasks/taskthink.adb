With Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body TaskThink is

  task body think is
   myClock : Time;
   minDist : constant Distance_cm := 10;
   midDist : constant Distance_cm := 20;
   begin
      loop
         myClock := Clock;

         --make a decision (could be wrapped nicely in a procedure)
         if Brain.GetMeasurementSensor1 < minDist or Brain.GetMeasurementSensor2 < minDist then
            MotorDriver_custom.SetDirection (Backward); --our decision what to do based on the sensor values
         elsif Brain.GetMeasurementSensor1 > midDist and Brain.GetMeasurementSensor2 > midDist then
            MotorDriver_custom.SetDirection (Forward);
         elsif Brain.GetMeasurementSensor1 < midDist then
            MotorDriver_custom.SetDirection (Turn_left);
         elsif Brain.GetMeasurementSensor2 < midDist then
            MotorDriver_custom.SetDirection (Turn_Right);
         else
            MotorDriver_custom.SetDirection (Rotating_Left);
         end if;

         delay until myClock + Milliseconds(100);  --random period
      end loop;
   end think;


end TaskThink;
