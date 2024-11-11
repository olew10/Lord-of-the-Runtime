package body MyBrain is


    protected body Brain is
      procedure leftSetMeasurementSensor (V : Distance_cm) is
      begin
         leftMeasurementSensor := V;
      end leftSetMeasurementSensor;

      function leftGetMeasurementSensor return Distance_cm is
      begin
         return leftMeasurementSensor;
      end leftGetMeasurementSensor;

      procedure rightSetMeasurementSensor (V : Distance_cm) is
      begin
         rightMeasurementSensor := V;
      end rightSetMeasurementSensor;

      function rightGetMeasurementSensor return Distance_cm is
      begin
         return rightMeasurementSensor;
      end rightGetMeasurementSensor;
   end Brain;

end MyBrain;
