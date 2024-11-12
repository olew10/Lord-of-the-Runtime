with MicroBit.Console; use MicroBit.Console;
with Profiler;
with Config; use Config;

package body TaskThink is

   function min(a, b : Distance_cm) return Distance_cm is
   begin
      if a < b then
         return a;
      else
         return b;
      end if;
   end min;


   function determineDirection(leftDistance, rightDistance, minThreshold, turnThreshold : Distance_cm) return Directions is
begin

   if leftDistance < turnThreshold and leftDistance > minThreshold then
      return Left;
   elsif rightDistance < turnThreshold and rightDistance > minThreshold then
      return Right;
   elsif leftDistance < minThreshold then
      return Left_Rotate;
   elsif rightDistance < minThreshold then
      return Right_Rotate;
   else
      return Forward;
   end if;

end determineDirection;


   function calculateMotorSpeed(closestDistance : Distance_cm) return Integer is
      speedFactor : Float;
      motorSpeed  : Integer;
   begin
      if closestDistance >= maxDistance then
         return maxSpeed;
      end if;

      speedFactor := Float(closestDistance) / Float(maxDistance);

      if speedFactor < minSpeedFactor then
         return minSpeed;
      elsif speedFactor > maxSpeedFactor then
         motorSpeed := maxSpeed;
      else
         motorSpeed := Integer(Float(maxSpeed) * speedFactor);
         if motorSpeed < minSpeed then
            return minSpeed;
         end if;
      end if;

      return motorSpeed;
   end calculateMotorSpeed;

   procedure updateMotorDirection(turningDirection : Directions; motorSpeed : Integer) is
      Speed : Speeds;
   begin
      case turningDirection is
      when Right =>
         Speed := (hal.UInt12(motorSpeed), hal.UInt12(motorSpeed), hal.UInt12(motorSpeed/2), hal.UInt12(motorSpeed/2));
      when Left =>
         Speed := (hal.UInt12(motorSpeed/2), hal.UInt12(motorSpeed/2), hal.UInt12(motorSpeed), hal.UInt12(motorSpeed));
      when Left_Rotate | Right_Rotate =>
         Speed := (hal.UInt12(maxSpeed), hal.UInt12(maxSpeed), hal.UInt12(maxSpeed), hal.UInt12(maxSpeed));
      when others =>
         Speed := (hal.UInt12(motorSpeed), hal.UInt12(motorSpeed), hal.UInt12(motorSpeed), hal.UInt12(motorSpeed));
      end case;
      MotorDriver_Custom.SetDirection(turningDirection, Speed);
   end updateMotorDirection;


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
      turningDirection := determineDirection(leftDistance, rightDistance, minDistance, turnThreshold);
      closestDistance :=   min(leftDistance, rightDistance);
      updateMotorDirection(turningDirection, calculateMotorSpeed(closestDistance));

   end coreThink;

   task body think is
   myClock : Time;
   begin
      loop
         myClock := Clock;
         if profilerMode then
            Profiler.Timer("Think", 100, deadline, coreThink'Access);
         else
            coreThink;
            delay until myClock + deadline;
         end if;
      end loop;
   end think;

end TaskThink;
