with nRF.GPIO; use nRF.GPIO;
with Microbit.Types; use MicroBit.Types;
with Ada.Real_Time; use Ada.Real_Time;

generic
   Trigger_Pin : GPIO_Point;
   Echo_Pin : GPIO_Point;

package MicroBit.UltrasonicExtended is

   function Read return Distance_cm;
   SensorError : exception;

private

   SensorDeadline : constant Time_Span := Milliseconds(26);

   procedure Initialize;

   procedure SendTriggerPulse;

   function WaitForEcho return Distance_cm;

   function Wait_For_End_Blocking_Using_Polling_With_Timeout(Timeout_Ms : Time_Span) return Distance_cm;

   function Wait_For_Start_Blocking_Using_Polling_With_Timeout  (Timeout_Ms : Time_Span) return Boolean;

end MicroBit.UltrasonicExtended;
