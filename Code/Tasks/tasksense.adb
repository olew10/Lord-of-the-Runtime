With Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;
with MicroBit.Types; use MicroBit.Types;
use MicroBit;

package body TaskSense is

    task body sense is
      package sensor1 is new Ultrasonic(MB_P16, MB_P0);
      package sensor2 is new Ultrasonic(MB_P15, MB_P1);

      Distance1 : Distance_cm := 0;
      Distance2 : Distance_cm := 0;

      myClock : Time;
   begin

      null; -- note that you can place Setup code here that is only run once for the entire task

      loop
         myClock := Clock; --important to get current time such that the period is exactly 200ms.
                           --you need to make sure that the instruction NEVER takes more than this period.
                           --make sure to measure how long the task needs, see Tasking_Calculate_Execution_Time example in the repository.
                           --What if for some known or unknown reason the execution time becomes larger?
                           --When Worst Case Execution Time (WCET) is overrun so higher than your set period, see : https://www.sigada.org/ada_letters/dec2003/07_Puente_final.pdf
                           --In this template we put the responsiblity on the designer/developer.

         Distance1 := sensor1.Read;
         Distance2 := sensor2.Read;
         --  Distance1 := 1;
         --  Distance2 := 2;

         Put_line ("1: " & Distance_cm'Image(Distance1));
         Put_line ("2: " & Distance_cm'Image(Distance2));

         Brain.SetMeasurementSensor1 (Distance1); -- random value, hook up a sensor here note that you might need to either cast to integer OR -better- change type of Brain.SetMeasurementSensor1
         Brain.SetMeasurementSensor2 (Distance2); -- random value, hook up another sensor here

         delay until myClock + Milliseconds(200); --random period
      end loop;
   end sense;

end TaskSense;

--testing
