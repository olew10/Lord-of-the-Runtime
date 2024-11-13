with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriverExtended; use MicroBit.MotorDriverExtended;
with HAL;
with Ada.Real_Time; use Ada.Real_Time;
with MyMotorDriver; use MyMotorDriver;
with MyBrain; use MyBrain;
with Priorities;


package TaskThink is

   task Think with Priority=> Priorities.Think;

   maxDistance     : constant Distance_cm := 100;
   minDistance     : constant Distance_cm := 20;
   minSpeedFactor  : constant Float := 0.1;
   maxSpeedFactor  : constant Float := 1.0;
   maxSpeed : constant Integer := 4095;
   minSpeed : constant Integer := 2048;

   turnThreshold: constant Distance_cm := 50;

   deadline : constant Time_Span := Priorities.thinkDeadline;

   function min(
      a        : Distance_cm;
      b        : Distance_cm
   ) return Distance_cm;

   function determineDirection(
      leftDistance   : Distance_cm;
      rightDistance  : Distance_cm;
      minThreshold  : Distance_cm;
      turnThreshold : Distance_cm
   ) return Directions;

   function calculateMotorSpeed(
      closestDistance  : Distance_cm
   ) return Integer;

   procedure updateMotorDirection(
      turningDirection : Directions;
      motorSpeed       : Integer
   );

   procedure readSensorValues(
      leftDistance  : out Distance_cm;
      rightDistance : out Distance_cm
   );

   procedure coreThink;

end TaskThink;
