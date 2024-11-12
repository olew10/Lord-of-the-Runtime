with Ada.Real_Time; use Ada.Real_Time;
package Priorities is

   Sense : constant := 3;
   senseDeadline : constant Time_Span := Milliseconds(65);

   Think : constant := 2;
   thinkDeadline : constant Time_Span := Milliseconds(135);

   Act : constant := 1;
   actDeadline : constant Time_Span := Milliseconds(75);
end Priorities;
