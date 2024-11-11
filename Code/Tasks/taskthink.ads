with MicroBit.Types; use MicroBit.Types;
with MicroBit.Extended; use MicroBit.Extended;
with HAL;

with MyMotorDriver; use MyMotorDriver;
with MyBrain; use MyBrain;
with Priorities;


package TaskThink is

   task Think with Priority=> Priorities.Think;

   maxDistance     : constant Distance_cm := 100;
   minDistance     : constant Distance_cm := 10;
   minSpeedFactor  : constant Float := 0.2;
   maxSpeedFactor  : constant Float := 1.0;
   turningDistance : constant Distance_cm := 30;
   maxSpeed : constant Float := 2050.0;

   function checkDistance(
      sensor1  : Distance_cm;
      sensor2  : Distance_cm;
      minDist  : Distance_cm
   ) return Boolean;

   function min(
      a        : Distance_cm;
      b        : Distance_cm
   ) return Distance_cm;

   function whichSensor(
      leftSensor   : Distance_cm;
      rightSensor  : Distance_cm;
      minDistance  : Distance_cm
   ) return Directions;

   function calculateMotorSpeed(
      closestDistance  : Distance_cm
   ) return HAL.UInt12;

   procedure updateMotorDirection(
      turningDirection : Directions;
      motorSpeed       : HAL.UInt12
   );

   procedure moveForward(
      closestDistance  : Distance_cm
   );

   procedure readSensorValues(
      leftDistance  : out Distance_cm;
      rightDistance : out Distance_cm
   );

   procedure coreThink;

end TaskThink;
