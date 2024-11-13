package ExceptionHandler is

   protected Handler is
      function isThinkOverride return Boolean;
      function getSafeState return Boolean;
      function getWarningState return Boolean;

      procedure setSafeState (B : Boolean); -- Error has happened. Set car to safe state
      procedure setWarningState (B : Boolean); -- Error has happened. Warn with sound
      procedure setErrorState (B : Boolean); -- Combined safe state and warning state
   private
         safeState : Boolean := False;
         warningState : Boolean := False;
   end Handler;

end ExceptionHandler;
