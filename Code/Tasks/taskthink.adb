With Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body TaskThink is

  task body think is
   myClock : Time;
   sensor1 : Distance_cm;
   sensor2 : Distance_cm;
   minDist : constant Distance_cm := 10;
   midDist : constant Distance_cm := 20;
   begin
      loop
         myClock := Clock;

         sensor1 := Brain.GetMeasurementSensor1;
         sensor2 := Brain.GetMeasurementSensor2;

         --make a decision (could be wrapped nicely in a procedure)
         if sensor1 < minDist or sensor2 < minDist then
            MotorDriver_custom.SetDirection (Backward); --our decision what to do based on the sensor values
         elsif sensor1 > midDist and sensor2 > midDist then
            MotorDriver_custom.SetDirection (Forward);
         elsif sensor1 < midDist then
            MotorDriver_custom.SetDirection (Forward);
         elsif sensor2 < midDist then
            MotorDriver_custom.SetDirection (Forward);
         end if;

         delay until myClock + Milliseconds(100);  --random period
      end loop;
   end think;


end TaskThink;
