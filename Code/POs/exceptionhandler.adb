
with MicroBit.Console; use MicroBit.Console;
with MyMotorDriver; use MyMotorDriver;
with MicroBit.MotorDriverExtended; use MicroBit.MotorDriverExtended;
with HAL;

package body ExceptionHandler is

    protected body Handler is

      procedure setSafeState (B : Boolean) is
      begin
         safeState := B;
      end setSafeState;

      procedure setWarningState (B : Boolean) is
      begin
         warningState := B;
      end setWarningState;

      procedure setErrorState (B : Boolean) is
      begin
         setSafeState(B);
         setWarningState(B);
      end setErrorState;

      function getSafeState return Boolean is
      begin
         return safeState;
      end getSafeState;

      function getWarningState return Boolean is
      begin
         return warningState;
      end getWarningState;

      function isThinkOverride return Boolean is
      begin
         return safeState;
      end isThinkOverride;

   end Handler;

end ExceptionHandler;
