With Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with MyMotorDriver; use MyMotorDriver;

package body TaskThink is

  task body think is
   myClock : Time;
   sensor1 : Distance_cm;
   sensor2 : Distance_cm;
   minDist : constant Distance_cm := 10;
   midDist : constant Distance_cm := 25;
   begin
      loop
         myClock := Clock;

         sensor1 := Brain.GetMeasurementSensor1;
         sensor2 := Brain.GetMeasurementSensor2;

         if sensor1 < minDist then
            MotorDriver_custom.SetDirection (Backward_Turn_Right);
         elsif sensor2 < minDist then
            MotorDriver_custom.SetDirection (Backward_Turn_Left);
         elsif sensor1 > midDist and sensor2 > midDist then
            MotorDriver_custom.SetDirection (Forward);
         elsif sensor1 < midDist and sensor2 > midDist then
            MotorDriver_custom.SetDirection (Turn_Left);
         elsif sensor2 < midDist and sensor1 > midDist then
            MotorDriver_custom.SetDirection (Turn_Right);
         end if;

         delay until myClock + Milliseconds(100);  --random period
      end loop;
   end think;


end TaskThink;
