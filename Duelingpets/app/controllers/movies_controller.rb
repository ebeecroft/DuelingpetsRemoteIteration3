class MoviesController < ApplicationController
   include MoviesHelper
   include BookgroupretrievalHelper

   def index
      mode "index"
   end

   def show
      mode "show"
   end

   def new
      mode "new"
   end

   def create
      mode "create"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def destroy
      mode "destroy"
   end

   def review
      mode "review"
   end

   def approve
      mode "approve"
   end

   def deny
      mode "deny"
   end
end
