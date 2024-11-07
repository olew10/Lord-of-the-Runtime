with MicroBit.Types; use MicroBit.Types;
use MicroBit;

package MyBrain is

   protected Brain is
      function leftGetMeasurementSensor return Distance_cm; -- concurrent read operations are now possible
      function rightGetMeasurementSensor return Distance_cm; -- concurrent read operations are now possible

      procedure leftSetMeasurementSensor (V : Distance_cm); -- but concurrent read/write are not!
      procedure rightSetMeasurementSensor (V : Distance_cm); -- but concurrent read/write are not!
   private
         leftMeasurementSensor : Distance_cm := 0;
         rightMeasurementSensor : Distance_cm := 0;
   end Brain;

end MyBrain;
