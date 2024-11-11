with Ada.Execution_Time; use Ada.Execution_Time;
with Ada.Real_Time; use Ada.Real_Time;
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

   function calculateMotorSpeed(closestDistance : Distance_cm) return Hal.UInt12 is
      speedFactor : Float;
      motorSpeed  : Hal.UInt12;
   begin
      if closestDistance < maxDistance then
         speedFactor := Float(closestDistance) / Float(maxDistance);
         if speedFactor < minSpeedFactor then
            speedFactor := minSpeedFactor;
         elsif speedFactor > maxSpeedFactor then
            speedFactor := maxSpeedFactor;
         end if;
         motorSpeed := Hal.UInt12(maxSpeed * speedFactor);
      else
         motorSpeed := Hal.UInt12(maxSpeed);
      end if;
      return motorSpeed;
   end calculateMotorSpeed;

   procedure updateMotorDirection(turningDirection : Directions; motorSpeed : Hal.UInt12) is
   begin
      MotorDriver_Custom.SetDirection(turningDirection, (motorSpeed, motorSpeed, motorSpeed, motorSpeed));
   end updateMotorDirection;

   procedure moveForward(closestDistance : Distance_cm) is
      motorSpeed : Hal.UInt12;
   begin
      motorSpeed := calculateMotorSpeed(closestDistance);
      MotorDriver_Custom.SetDirection(Forward, (motorSpeed, motorSpeed, motorSpeed, motorSpeed));
   end moveForward;

   procedure readSensorValues(leftDistance : out Distance_cm; rightDistance : out Distance_cm) is
   begin
      leftDistance  := Brain.leftGetMeasurementSensor;
      rightDistance := Brain.rightGetMeasurementSensor;
   end readSensorValues;

   procedure coreThink is
      myClock          : Time := Clock;
      turningDirection : Directions;
      leftDistance     : Distance_cm;
      rightDistance    : Distance_cm;
      closestDistance  : Distance_cm;
   begin
      readSensorValues(leftDistance, rightDistance);
      turningDirection := whichSensor(leftDistance, rightDistance, minDistance);

      if checkDistance(leftDistance, rightDistance, minDistance) then
         updateMotorDirection(turningDirection, Hal.UInt12(maxSpeed));
      else
         closestDistance := min(leftDistance, rightDistance);
         moveForward(closestDistance);
      end if;
      delay until myClock + Milliseconds(100);
   end coreThink;

   task body think is
   begin
      loop
         if profilerMode then
            Profiler.Timer("Think", 10, coreThink'Access);
         else
            coreThink;
         end if;
      end loop;
   end think;

end TaskThink;
