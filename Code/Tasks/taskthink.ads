with MyMotorDriver; use MyMotorDriver;
with MicroBit.Types; use MicroBit.Types;
with MyBrain; use MyBrain;
with Priorities;

package TaskThink is

   task Think with Priority=> Priorities.Think;
   procedure coreThink;
   function checkDistance (Sensor1, Sensor2 : Distance_cm) return Boolean;

end TaskThink;
