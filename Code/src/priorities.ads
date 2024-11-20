with Ada.Real_Time; use Ada.Real_Time;
package Priorities is

   Sense : constant := 1;
   senseDeadline : constant Time_Span := Milliseconds(140);

   Act : constant := 2;
   actDeadline : constant Time_Span := Milliseconds(50);

   Think : constant := 3;
   thinkDeadline : constant Time_Span := Milliseconds(10);

end Priorities;
