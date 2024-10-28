with MyMotorDriver; use MyMotorDriver;
with MicroBit.Types; use MicroBit.Types;
with MyBrain; use MyBrain;
with Priorities;

package TaskThink is

   task Think with Priority=> Priorities.Think;
   function Check_Distance (Sensor1, Sensor2 : Distance_cm) return Boolean;

end TaskThink;
