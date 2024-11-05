package Priorities is

   Base      : constant := 0;

   -- Task priorities
   Sense : constant := Base + 3;
   Think : constant := Base + 2;
   Act   : constant := Base + 1;
end Priorities;
