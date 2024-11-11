with Ada.Real_Time; use Ada.Real_Time;
package Profiler is

   procedure Timer(Navn : String; Measurements : Integer; taskDelay : Time_Span; codeExecute : access procedure);

end Profiler;
