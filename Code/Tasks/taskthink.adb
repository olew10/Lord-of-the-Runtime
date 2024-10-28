with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Extended; use MicroBit.Extended;

package body TaskThink is

   function Check_Distance (Sensor1, Sensor2 : Distance_cm) return Boolean is
      Min_Dist : constant Distance_cm := 10;
   begin
      if Sensor1 < Min_Dist or else Sensor2 < Min_Dist then
         return True;
      else
         return False;
      end if;
   end Check_Distance;

   task body Think is
      MyClock : Time;
      canDrive : Boolean;
   begin
      loop
         MyClock := Clock;
         canDrive := Check_Distance(Brain.GetMeasurementSensor1, Brain.GetMeasurementSensor2);

         -- Decision-making based on sensor values
         if canDrive then
            MotorDriver_Custom.SetDirection (Spin);
         else
            MotorDriver_Custom.SetDirection (Forward);
         end if;


         delay until MyClock + Milliseconds(100);  -- Control loop timing
      end loop;
   end Think;

end TaskThink;
