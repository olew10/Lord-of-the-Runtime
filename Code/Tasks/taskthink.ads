with MyMotorDriver; use MyMotorDriver;
with MyBrain; use MyBrain;
with Priorities;

package TaskThink is

   task Think with Priority=> Priorities.Think;

end TaskThink;
