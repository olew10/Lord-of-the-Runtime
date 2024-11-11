with MicroBit.Console; use MicroBit.Console;
with Profiler;
with Config; use Config;

package body TaskThink is

   function checkDistance(sensor1, sensor2 : Distance_cm; minDist : Distance_cm) return Boolean is
   begin
      return (sensor1 < minDist or else sensor2 < minDist);
   end checkDistance;

   function min(a, b : Distance_cm) return Distance_cm is
   begin
      if a < b then
         return a;
      else
         return b;
      end if;
   end min;

   function whichSensor(leftSensor, rightSensor, minDistance : Distance_cm) return Directions is
   begin
      if leftSensor < minDistance and rightSensor < minDistance then
         return Left_Rotate;
      elsif leftSensor < minDistance then
         return Left_Rotate;
      elsif rightSensor < minDistance then
         return Right_Rotate;
      else
         return Forward;
      end if;
   end whichSensor;

   function calculateMotorSpeed(closestDistance : Distance_cm) return Integer is
      speedFactor : Float;
      motorSpeed  : Integer;
   begin
      if closestDistance < maxDistance then
         speedFactor := Float(closestDistance) / Float(maxDistance);
         if speedFactor < minSpeedFactor then
            return minSpeed;
         elsif speedFactor > maxSpeedFactor then
            return maxSpeed;
         end if;
         motorSpeed := Integer(float(maxSpeed) * speedFactor);
      else
         motorSpeed := maxSpeed;
      end if;

      if motorSpeed < minSpeed then
         return minSpeed;
      else
         return motorSpeed;
      end if;
   end calculateMotorSpeed;

   procedure updateMotorDirection(turningDirection : Directions; motorSpeed : Integer) is
   begin
      MotorDriver_Custom.SetDirection(turningDirection, (hal.UInt12(motorSpeed), hal.UInt12(motorSpeed), hal.UInt12(motorSpeed), hal.UInt12(motorSpeed)));
   end updateMotorDirection;

   procedure moveForward(closestDistance : Distance_cm) is
      motorSpeed : Integer;
   begin
      motorSpeed := calculateMotorSpeed(closestDistance);
      MotorDriver_Custom.SetDirection(Forward, (hal.UInt12(motorSpeed), hal.UInt12(motorSpeed), hal.UInt12(motorSpeed), hal.UInt12(motorSpeed)));
   end moveForward;

   procedure readSensorValues(leftDistance : out Distance_cm; rightDistance : out Distance_cm) is
   begin
      leftDistance  := Brain.leftGetMeasurementSensor;
      rightDistance := Brain.rightGetMeasurementSensor;
   end readSensorValues;

   procedure coreThink is
      turningDirection : Directions;
      leftDistance     : Distance_cm;
      rightDistance    : Distance_cm;
      closestDistance  : Distance_cm;
   begin
      readSensorValues(leftDistance, rightDistance);
      turningDirection := whichSensor(leftDistance, rightDistance, minDistance);

      if checkDistance(leftDistance, rightDistance, minDistance) then
         updateMotorDirection(turningDirection, maxSpeed);
      else
         closestDistance := min(leftDistance, rightDistance);
         moveForward(closestDistance);
      end if;
      delay until myClock + Milliseconds(100);
   end coreThink;

   task body think is
   begin
    myClock          : Time := Clock;
      loop
         if profilerMode then
            Profiler.Timer("Think", 100, 100, coreThink'Access);
         else
            coreThink;
            delay until myClock + deadline;
         end if;
      end loop;
   end think;

end TaskThink;
