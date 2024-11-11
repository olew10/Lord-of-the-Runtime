package body MyMotorDriver is
   protected body MotorDriver_Custom is

      procedure SetDirection (V : Directions; S : Speeds) is
      begin
         DriveDirection := V;
         DriveSpeed := S;
      end SetDirection;

      function GetStatus return Status is
      begin
         return (Direction => DriveDirection, Speed => DriveSpeed);
      end GetStatus;

   end MotorDriver_Custom;
end MyMotorDriver;
