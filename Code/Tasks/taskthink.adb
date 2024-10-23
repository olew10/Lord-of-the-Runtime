With Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body TaskThink is

  task body think is
   myClock : Time;
   begin
      loop
         myClock := Clock;

         --make a decision (could be wrapped nicely in a procedure)
         if Brain.GetMeasurementSensor1 > 20 and Brain.GetMeasurementSensor2 > 20 then
            MotorDriver_custom.SetDirection (Forward); --our decision what to do based on the sensor values
         else
            MotorDriver_custom.SetDirection (Rotating_Left);
         end if;

         delay until myClock + Milliseconds(100);  --random period
      end loop;
   end think;


end TaskThink;
