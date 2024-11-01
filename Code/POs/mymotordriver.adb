package body MyMotorDriver is

   protected body MotorDriver_custom is
      --  procedures can modify the data
      procedure SetDirection (V : Directions) is
      begin
         DriveDirection := V;
      end SetDirection;

      --  functions cannot modify the data
      function GetDirection return Directions is
      begin
         return DriveDirection;
      end GetDirection;

   end MotorDriver_custom;

end MyMotorDriver;
