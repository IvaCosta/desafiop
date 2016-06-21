class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
   protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }
   
   respond_to :json
   before_action :configure_permitted_parameters, if: :devise_controller?
  
   
   def angular
    render 'layouts/application'
   end
  
  
  rescue_from ActiveRecord::RecordNotFound do    
	respond_to do |type|
    type.all  { render :nothing => true, :status => 404 }
    end
  end
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
