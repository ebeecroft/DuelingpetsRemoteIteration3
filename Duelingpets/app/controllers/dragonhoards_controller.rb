class DragonhoardsController < ApplicationController
   include DragonhoardsHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def withdraw
      mode "withdraw"
   end

   def createemeralds
      mode "createemeralds"
   end

   def buyemeralds
      mode "buyemeralds"
   end

   def convertpoints
      mode "convertpoints"
   end

   def vacationmode
      mode "vacationmode"
   end

   def getvacationpoints
      mode "getvacationpoints"
   end

   def transfer
      mode "transfer"
   end
end
