with MicroBit.Types; use MicroBit.Types;
use MicroBit;

package MyBrain is

   protected Brain is
      function GetMeasurementSensor1 return Distance_cm; -- concurrent read operations are now possible
      function GetMeasurementSensor2 return Distance_cm; -- concurrent read operations are now possible

      procedure SetMeasurementSensor1 (V : Distance_cm); -- but concurrent read/write are not!
      procedure SetMeasurementSensor2 (V : Distance_cm); -- but concurrent read/write are not!
   private
         MeasurementSensor1 : Distance_cm := 0;
         MeasurementSensor2 : Distance_cm := 0;
   end Brain;

end MyBrain;
