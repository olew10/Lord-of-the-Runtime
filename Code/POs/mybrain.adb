package body MyBrain is


    protected body Brain is
      --  procedures can modify the data
      procedure leftSetMeasurementSensor (V : Distance_cm) is
      begin
         leftMeasurementSensor := V;
      end leftSetMeasurementSensor;

      --  functions cannot modify the data
      function leftGetMeasurementSensor return Distance_cm is
      begin
         return leftMeasurementSensor;
      end leftGetMeasurementSensor;

      --  procedures can modify the data
      procedure rightSetMeasurementSensor (V : Distance_cm) is
      begin
         rightMeasurementSensor := V;
      end rightSetMeasurementSensor;

      --  functions cannot modify the data
      function rightGetMeasurementSensor return Distance_cm is
      begin
         return rightMeasurementSensor;
      end rightGetMeasurementSensor;
   end Brain;

end MyBrain;
