class ApplicationController < ActionController::Base
  before_action :set_some_variable
  
  private
  
    def set_some_variable
      @some_variable = "Some variable is set!"
    end
  
end
