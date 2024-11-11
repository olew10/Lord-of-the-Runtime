with MicroBit.Types; use MicroBit.Types;
with MicroBit.Extended; use MicroBit.Extended;
with HAL;
with Ada.Real_Time; use Ada.Real_Time;
with MyMotorDriver; use MyMotorDriver;
with MyBrain; use MyBrain;
with Priorities;


package TaskThink is

   task Think with Priority=> Priorities.Think;

   maxDistance     : constant Distance_cm := 200;
   minDistance     : constant Distance_cm := 20;
   minSpeedFactor  : constant Float := 0.1;
   maxSpeedFactor  : constant Float := 1.0;
   turningDistance : constant Distance_cm := 30;
   maxSpeed : constant Integer := 4095;
   minSpeed : constant Integer := 1024;

   deadline : constant Time_Span := Milliseconds(135);

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
   ) return Integer;

   procedure updateMotorDirection(
      turningDirection : Directions;
      motorSpeed       : Integer
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
