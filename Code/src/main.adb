--with MyController; -- This embeds and instantiates the MyController package
with mycontroller;
-- NOTE ----------
-- See the MyController_empty package first for a single file empty Sense-Think-Act (STA) template
-- The MyController package contains a better structured STA template with each task having its own file
-- Build your own controller from scratch using the template and structured coding principles as a guide line.
-- Use
------------------

--Empty main running as a task currently set to lowest priority. Can be used as it is a normal task!

Procedure Main with Priority => 0 is

begin
   loop
      null;
   end loop;
end Main;
