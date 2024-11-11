with Ada.Real_Time; use Ada.Real_Time;
package Priorities is

   Base      : constant := 0;

   -- Task priorities
   Sense : constant := Base + 3;
   senseDeadline : constant Time_Span := Milliseconds(65);

   Think : constant := Base + 2;
   thinkDeadline : constant Time_Span := Milliseconds(135);

   Act : constant := Base + 1;
   actDeadline : constant Time_Span := Milliseconds(75);
end Priorities;
