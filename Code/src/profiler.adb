with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Extended; use MicroBit.Extended;
with MicroBit.Types; use MicroBit.Types;
with DFR0548;
use MicroBit;

package body Profiler is

   procedure Timer (Navn : String; Measurements, taskDelay : Integer; codeExecute : access procedure) is
      Time_Now   : Time;
      Elapsed    : Time_Span := Ada.Real_Time.Time_Span_Zero;
      Max_Time   : Time_Span := Ada.Real_Time.Time_Span_Zero;
   begin
      for Index in 1 .. Measurements loop
         Time_Now := Clock;
         codeExecute.all;

         declare
            Execution_Time : Time_Span := Clock - Time_Now;
         begin
            Elapsed := Elapsed + Execution_Time;
            if Execution_Time > Max_Time then
               Max_Time := Execution_Time;
            end if;
         end;

            delay until Time_Now + Milliseconds(taskDelay);

      end loop;

      declare
         Average_Time : Duration := To_Duration(Elapsed) / Measurements;
         Worst_Time   : Duration := To_Duration(Max_Time);
      begin
         MicroBit.Console.Put_Line ("Average execution time for " & Navn & ": " &
                                    Duration'Image (Average_Time) & " seconds");
         MicroBit.Console.Put_Line ("Worst execution time for " & Navn & ": " &
                                    Duration'Image (Worst_Time) & " seconds");
      end;
   end Timer;

end Profiler;
