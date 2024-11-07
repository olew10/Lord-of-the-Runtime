package body TaskThink is

   -- Constants for movement and speed
   Max_Distance     : constant Distance_cm := 100;
   Min_Distance     : constant Distance_cm := 20;
   Min_Speed_Factor : constant Float := 0.1;
   Max_Speed_Factor : constant Float := 1.0;

   -- Variables for direction and stability counter
   lastTurnDirection : Directions;
   stableCounter     : Integer := 0;

   function checkDistance(Sensor1, Sensor2 : Distance_cm; Min_Dist : Distance_cm) return Boolean is
   begin
      return (Sensor1 < Min_Dist or else Sensor2 < Min_Dist);
   end checkDistance;

   function Min(A, B : Distance_cm) return Distance_cm is
   begin
      return (if A < B then A else B);
   end Min;

   function whichSensor(Left_Sensor, Right_Sensor, Min_Distance : Distance_cm) return Directions is
begin
   if Left_Sensor < Min_Distance and Right_Sensor < Min_Distance then
      return Left_Rotate;
   elsif Left_Sensor < Min_Distance then
      return Left_Rotate;
   elsif Right_Sensor < Min_Distance then
      return Right_Rotate;
   else
      return Forward;
   end if;
end whichSensor;

   function CalculateMotorSpeed(closest_distance : Distance_cm) return HAL.UInt12 is
      speedFactor : Float;
      motorSpeed : HAL.UInt12;
   begin
      if closest_distance < Max_Distance then
         speedFactor := Float(closest_distance) / Float(Max_Distance);
         if speedFactor < Min_Speed_Factor then
            speedFactor := Min_Speed_Factor;
         elsif speedFactor > Max_Speed_Factor then
            speedFactor := Max_Speed_Factor;
         end if;
         motorSpeed := HAL.UInt12(Integer(4095.0 * speedFactor));
      else
         motorSpeed := 4095;
      end if;
      return motorSpeed;
   end CalculateMotorSpeed;

   procedure UpdateMotorDirection(turningDirection : Directions; motorSpeed : HAL.UInt12) is
   begin
      MotorDriver_Custom.SetDirection(turningDirection, (motorSpeed, motorSpeed, motorSpeed, motorSpeed));
   end UpdateMotorDirection;

   procedure MoveForward(closest_distance : Distance_cm) is
      motorSpeed : HAL.UInt12;
   begin
      motorSpeed := CalculateMotorSpeed(closest_distance);
      MotorDriver_Custom.SetDirection(Forward, (motorSpeed, motorSpeed, motorSpeed, motorSpeed));
   end MoveForward;

   procedure ReadSensorValues(leftDistance : out Distance_cm; rightDistance : out Distance_cm) is
   begin
      leftDistance  := Brain.leftGetMeasurementSensor;
      rightDistance := Brain.rightGetMeasurementSensor;
   end ReadSensorValues;

   procedure coreThink is
      myClock : Time := Clock;
      leftDistance, rightDistance : Distance_cm;
      turningDirection : Directions;
      closest_distance : Distance_cm;
   begin
      ReadSensorValues(leftDistance, rightDistance);
      turningDirection := whichSensor(leftDistance, rightDistance, Min_Distance);

      if checkDistance(leftDistance, rightDistance, Min_Distance) then

         if turningDirection /= lastTurnDirection then
            stableCounter := stableCounter + 1;
         else
            stableCounter := 0;
         end if;

         if stableCounter >= 3 then
            lastTurnDirection := turningDirection;
            stableCounter := 0;
         end if;
         UpdateMotorDirection(lastTurnDirection, 4095);
      else
         closest_distance := Min(leftDistance, rightDistance);
         MoveForward(closest_distance);
      end if;

      delay until myClock + Milliseconds(100);
   end coreThink;

   task body think is
   begin
      loop
         if debugMode then
            Profiler.Timer("Think", 10, coreThink'Access);
         else
            coreThink;
         end if;
      end loop;
   end think;

end TaskThink;
