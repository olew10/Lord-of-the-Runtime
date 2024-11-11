package Profiler is

   procedure Timer(Navn : String; Measurements, taskDelay : Integer; codeExecute : access procedure);

end Profiler;
